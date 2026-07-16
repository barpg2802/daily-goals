-- ── Daily Goals: run this ONCE in Supabase → SQL Editor → Run ────────────────
-- Model: a "vault" whose random UUID id IS the secret. The table is sealed by
-- RLS (no direct anon access = nobody can list other people's data); the app
-- reaches exactly one vault through the two SECURITY DEFINER functions below.

create table if not exists public.vault (
  id         uuid primary key,
  data       jsonb       not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.vault enable row level security;
-- (deliberately no anon policies — the functions are the only way in)

create or replace function public.get_vault(p_id uuid)
returns jsonb language sql security definer set search_path = public as $$
  select data from public.vault where id = p_id;
$$;

create or replace function public.save_vault(p_id uuid, p_data jsonb, p_updated timestamptz)
returns void language sql security definer set search_path = public as $$
  insert into public.vault (id, data, updated_at)
  values (p_id, p_data, p_updated)
  on conflict (id) do update
    set data = excluded.data, updated_at = excluded.updated_at;
$$;

revoke all on function public.get_vault(uuid)                     from public;
revoke all on function public.save_vault(uuid, jsonb, timestamptz) from public;
grant execute on function public.get_vault(uuid)                     to anon;
grant execute on function public.save_vault(uuid, jsonb, timestamptz) to anon;
-- ponytail: anon can write any id (unguessable, so fine for a personal app);
-- add a rate limit / auth only if it ever gets abused.
