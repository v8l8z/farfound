# Farfound website

The public pages for Farfound, the daily word game where rare answers fly further: the home page, the game itself, support, the privacy policy and the page that opens flight plan links.

Served by GitHub Pages at https://v8l8z.github.io/farfound/

## Pages

- `index.html`: the home page. Play now in your browser is the main button, with the App Store beside it.
- `play/`: the whole game, playable in any browser with no install and no account. Don't edit it by hand: it's copied from the game folder by `sync-play.sh`.
- `plan/`: opens flight plan links (`plan/#payload`). It shows the crew's board, then offers Open in Farfound for the app and Fly it in your browser, which opens `play/` with the same `#payload`.
- `support/` and `privacy/`.
- `robots.txt` and `sitemap.xml` list the home, play, support and privacy pages. Crawlers only read `robots.txt` at the root of the host, so also submit the sitemap in Google Search Console.

## Updating the play page

After changing the game, run:

```sh
./sync-play.sh            # or ./sync-play.sh path/to/farfound
```

It copies `play-offline.html` from `../farfound` as `play/index.html`, with this page's title, description, canonical link and link card tags put into its head, then copies `farfound.js`, `farfound-data.js`, `farfound-packs.js`, the `ff-*.woff2` fonts and `font-licenses.txt` next to it. The fonts ship with the game, so the play page loads nothing from Google Fonts.

## Link card

`og.png` (1200 by 630) is the picture shown when a link to the home, play or plan page is pasted into a chat or a post. It's `og-card.html` rendered at exactly 1200 by 630, for example with Playwright. The card uses the game's fonts from `play/`, so run `sync-play.sh` first.
