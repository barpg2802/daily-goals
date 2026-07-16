# 🎯 Daily Goals

A tiny personal tracker for **water**, **protein**, and **gym** — with daily/weekly goals.
One HTML file, no backend, data stored on your device (localStorage).

## Use it
Open `index.html`. Tap quick-add buttons (Cup / Bottle / Whey shake, protein amounts, +1 gym session)
or type a custom amount. Tap a goal to change it. `↩` undoes the last entry.
Water & protein reset each day; gym resets each week.

## Put it on your iPhone (feels like an app)
1. Open the deployed URL in Safari.
2. Share → **Add to Home Screen**. Launches full-screen, no browser bars.

## Deploy free on GitHub Pages
```bash
git init && git add -A && git commit -m "Daily Goals"
gh repo create daily-goals --public --source=. --push
gh api -X POST repos/{owner}/daily-goals/pages -f build_type=legacy -f 'source[branch]=main' -f 'source[path]=/'
```
Then open `https://<user>.github.io/daily-goals/`.

## Add another tracker
Add one object to the `TRACKERS` array in `index.html` (e.g. weed, weekly). That's the whole change.

## Not included (add when you actually need it)
- **Multi-device sync** — data lives on one device. Add a real DB/backend (Supabase, etc.) if you want it on phone + laptop.
- **Offline service worker** — works offline once loaded anyway; add a SW for guaranteed offline.
- **History/streak charts** — every entry is already stored, so this is easy to add later.
