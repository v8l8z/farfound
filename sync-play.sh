#!/bin/sh
# Copies the latest web game into play/, the page at https://v8l8z.github.io/farfound/play/. Run it after changing the game.
# usage: ./sync-play.sh [path to the farfound folder]
set -e
here="$(cd "$(dirname "$0")" && pwd)"
src="${1:-$here/../farfound}"
dest="$here/play"
mkdir -p "$dest"
# the page's own title, description and link card, so a pasted link unfurls with og.png
TAGS=$(cat <<'EOF'
<title>Play Farfound: daily rare-answer trivia in your browser</title>
<meta name="description" content="Play Farfound free in your browser. Eight prompts a day: the rarer your answer, the further your rocket flies through 31 real stops. No ads, no account, no install.">
<link rel="canonical" href="https://v8l8z.github.io/farfound/play/">
<link rel="icon" href="../icon.png">
<link rel="apple-touch-icon" href="../icon.png">
<meta name="theme-color" content="#070a1c">
<meta property="og:type" content="website">
<meta property="og:site_name" content="Farfound">
<meta property="og:url" content="https://v8l8z.github.io/farfound/play/">
<meta property="og:title" content="Play Farfound in your browser">
<meta property="og:description" content="The daily trivia game where rare answers fly further. Eight prompts, 31 real stops, no ads and nothing to install.">
<meta property="og:image" content="https://v8l8z.github.io/farfound/og.png">
<meta property="og:image:width" content="1200">
<meta property="og:image:height" content="630">
<meta property="og:image:alt" content="The Farfound rocket icon and wordmark above a row of the game's tier symbols.">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="Play Farfound in your browser">
<meta name="twitter:description" content="The daily trivia game where rare answers fly further. Eight prompts, 31 real stops, no ads and nothing to install.">
<meta name="twitter:image" content="https://v8l8z.github.io/farfound/og.png">
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
cp "$src/farfound.js" "$src/farfound-data.js" "$src/farfound-packs.js" "$dest/"
# the fonts come with the game, so the page never needs Google Fonts
cp "$src"/ff-*.woff2 "$src/font-licenses.txt" "$dest/"
echo "Copied the game from $src into $dest"
