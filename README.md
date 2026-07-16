# 🎯 Daily Goals

A tiny personal tracker for **water**, **protein**, and **gym** — with daily/weekly goals.
Cloud-synced across devices, **no login**. Live at
**https://barpg2802.github.io/daily-goals/**

## Use it
Tap quick-add buttons (Cup / Bottle / Whey shake, protein amounts, +1 gym session)
or type a custom amount. Tap a goal to change it. `↩` undoes the last entry.
Water & protein reset each day; gym resets each week. The dot up top shows sync status
(green = synced, orange = offline, still saved on the device).

## On your iPhone (feels like an app)
Open the URL in Safari → Share → **Add to Home Screen**. Full-screen, no browser bars.

## Sync to a second device (optional)
Data lives under a secret **sync code** stored on your device. To see the same data
elsewhere: open **🔗 Sync across devices** on device 1, **Copy** the code, paste it into
the same panel on device 2 → **Use**. If you only use one phone, ignore this.

## How the "DB" works
- Storage is **Supabase** (hosted Postgres). Each install gets a random UUID "vault";
  that UUID *is* the secret. The `vault` table is sealed by RLS, and the app reaches
  exactly one vault through two `SECURITY DEFINER` functions — so nobody can list
  anyone else's data. See [supabase-setup.sql](supabase-setup.sql).
- `localStorage` is kept as an instant-load + offline cache. On open the app shows the
  cached data immediately, then reconciles with the cloud (**newest write wins**).
- Project: `https://hpzjieftfscvppwklqjf.supabase.co` (anon key is public by design).

## Add another tracker (e.g. weed, weekly)
Add one object to the `TRACKERS` array near the top of the `<script>` in
[index.html](index.html). That's the whole change.

## Not included (add when you actually need it)
- **Accounts / real auth** — the vault-code model has no per-user login. Fine for a
  personal tracker; switch to Supabase Auth if the data gets sensitive.
- **Offline write queue** — offline edits are cached locally and pushed on the next
  successful save (the full state is sent each time, so a missed write self-heals).
  Two devices editing while one is offline can clobber via last-write-wins.
- **History / streak charts** — every entry is stored with a timestamp, so this is easy later.
