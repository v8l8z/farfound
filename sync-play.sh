#!/bin/sh
# Copies the latest web game into play/, the page at https://farfoundtrivia.com/play/. Run it after changing the game.
# usage: ./sync-play.sh [path to the farfound folder]
set -e
here="$(cd "$(dirname "$0")" && pwd)"
src="${1:-$here/../farfound}"
dest="$here/play"
mkdir -p "$dest"
# the page's own title, description and link card, so a pasted link unfurls with og.png
TAGS=$(cat <<'EOF'
<title>Play Farfound: daily rare-answer trivia in your browser</title>
<meta name="description" content="Play Farfound free in your browser. Eight prompts a day: the rarer your answer, the further your rocket flies through 31 real stops. No account, nothing to install.">
<link rel="canonical" href="https://farfoundtrivia.com/play/">
<link rel="icon" href="../icon.png">
<link rel="apple-touch-icon" href="../icon.png">
<meta name="theme-color" content="#070a1c">
<meta property="og:type" content="website">
<meta property="og:site_name" content="Farfound">
<meta property="og:url" content="https://farfoundtrivia.com/play/">
<meta property="og:title" content="Play Farfound in your browser">
<meta property="og:description" content="The daily trivia game where rare answers fly further. Eight prompts, 31 real stops and nothing to install.">
<meta property="og:image" content="https://farfoundtrivia.com/og.png">
<meta property="og:image:width" content="1200">
<meta property="og:image:height" content="630">
<meta property="og:image:alt" content="The Farfound rocket icon and wordmark above a row of the game's tier symbols.">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="Play Farfound in your browser">
<meta name="twitter:description" content="The daily trivia game where rare answers fly further. Eight prompts, 31 real stops and nothing to install.">
<meta name="twitter:image" content="https://farfoundtrivia.com/og.png">
<script async data-ad-frequency-hint="60s" src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-5512492798436213" crossorigin="anonymous"></script>
<script>
// The game asks for an ad break after every second finished game (see adBreak in farfound.js).
// Here the break is a Google AdSense interstitial. With no ad to show, or the ad code blocked, the game carries on at once.
window.adsbygoogle = window.adsbygoogle || [];
window.farfoundPrivacyPolicyURL = 'https://farfoundtrivia.com/privacy/';
adsbygoogle.push({ preloadAdBreaks: 'on', sound: 'on' });
window.farfoundAdBreak = function (name) {
  return new Promise(function (resolve) {
    if (!window.adsbygoogle || !adsbygoogle.loaded) { resolve(); return; }
    var showing = false;
    // Google answers at once when it has no ad; this covers the case where it never answers
    var timer = setTimeout(function () { if (!showing) resolve(); }, 4000);
    try {
      adsbygoogle.push({
        type: 'next', name: String(name || 'game_over').replace(/[^a-z0-9_]/gi, '_'),
        beforeAd: function () { showing = true; },
        adBreakDone: function () { clearTimeout(timer); resolve(); }
      });
    } catch (e) { clearTimeout(timer); resolve(); }
  });
};

// A small banner at the foot of a flight log. It sits in the page and stays folded away until Google has filled it,
// so an empty slot leaves no gap. The bar that stays at the bottom of the screen is the Google anchor ad,
// switched on in AdSense (Ads, By site, Auto ads: anchor ads only, bottom only); the page has no code for it.
document.addEventListener('DOMContentLoaded', function () {
  var app = document.getElementById('app'), log = document.getElementById('log');
  if (!app || !log || !window.MutationObserver) return;
  var wide = innerWidth >= 780, w = wide ? 728 : 320, h = wide ? 90 : 50;
  function unit(slot) {
    var box = document.createElement('div');
    box.className = 'ff-ad';
    box.innerHTML = '<span>Advertisement</span><ins class="adsbygoogle" style="display:inline-block;width:' + w + 'px;height:' + h + 'px" data-ad-client="ca-pub-5512492798436213" data-ad-slot="' + slot + '"></ins>';
    var ins = box.lastChild;
    new MutationObserver(function () { box.classList.toggle('is-filled', ins.getAttribute('data-ad-status') === 'filled'); }).observe(ins, { attributes: true, attributeFilter: ['data-ad-status'] });
    return box;
  }
  function ask() { try { (window.adsbygoogle = window.adsbygoogle || []).push({}); } catch (e) { /* blocked, or no slot to fill */ } }

  // flight log: the game redraws the log for each finished flight, so each gets a new banner, at most one every 30 seconds
  var last = 0;
  new MutationObserver(function () {
    var inner = log.querySelector('.sheet-inner');
    if (log.hidden || !inner || inner.querySelector('.ff-ad') || Date.now() - last < 30000) return;
    last = Date.now();
    inner.appendChild(unit('2709613643'));
    ask();
  }).observe(log, { childList: true });
});
</script>
<style>
.ff-ad { display: flex; flex-direction: column; align-items: center; gap: 6px; width: 100%; height: 0; overflow: hidden; }
.ff-ad.is-filled { height: auto; margin-top: 28px; padding-top: 12px; border-top: 1px solid rgba(255, 255, 255, 0.1); }
.ff-ad span { font-size: 10px; letter-spacing: 0.12em; text-transform: uppercase; color: #8d95b8; }
</style>
EOF
)
export TAGS
# play-offline.html is the whole page (doctype, viewport and safe-area padding) around the game.
# The tags go in its head, and the game's own bare <title> gives way to the one above.
awk '
  !l && sub(/<html>/, "<html lang=\"en\">") { l = 1 }
  !t && match($0, /<title>[^<]*<\/title>/) { $0 = substr($0, 1, RSTART - 1) substr($0, RSTART + RLENGTH); t = 1 }
  !h && (i = index($0, "</head>")) { $0 = substr($0, 1, i - 1) ENVIRON["TAGS"] "\n" substr($0, i); h = 1 }
  { print }
  END { if (!h) exit 1 }
' "$src/play-offline.html" > "$dest/index.html" || { echo "No </head> in $src/play-offline.html" >&2; exit 1; }
cp "$src/farfound.js" "$src/farfound-data.js" "$src/farfound-packs.js" "$src/farfound-categories.js" "$src/farfound-cat-prompts.js" "$src/farfound-flags.js" "$dest/"
# the fonts come with the game, so the page never needs Google Fonts
cp "$src"/ff-*.woff2 "$src/font-licenses.txt" "$src/flags-licence.txt" "$dest/"
echo "Copied the game from $src into $dest"
