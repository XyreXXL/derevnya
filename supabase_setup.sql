-- Деревня за 1 рубль: таблицы для своего Supabase.
-- МОЖНО ЗАПУСКАТЬ ПОВТОРНО (ничего не дублируется).
-- Supabase → SQL Editor → New query → вставить всё → Run.

create table if not exists public.saves (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb, stage int, people numeric,
  updated_at timestamptz default now()
);
create table if not exists public.leaderboard (
  user_id uuid references auth.users(id) on delete cascade,
  difficulty text not null,
  nickname text, stage int, people int, days int,
  won boolean default false, score double precision default 0,
  play_seconds int, updated_at timestamptz default now(),
  primary key (user_id, difficulty)
);
create table if not exists public.achievements (
  user_id uuid references auth.users(id) on delete cascade,
  ach_id text not null,
  primary key (user_id, ach_id)
);
create table if not exists public.user_skins (
  user_id uuid references auth.users(id) on delete cascade,
  skin text not null,
  primary key (user_id, skin)
);

-- процент игроков, получивших достижение
create or replace view public.ach_stats as
  select ach_id,
         round(100.0 * count(*) / greatest((select count(distinct user_id) from public.achievements), 1), 1) as pct
  from public.achievements group by ach_id;
grant select on public.ach_stats to anon, authenticated;

alter table public.saves enable row level security;
alter table public.leaderboard enable row level security;
alter table public.achievements enable row level security;
alter table public.user_skins enable row level security;

drop policy if exists "saves: свои" on public.saves;
create policy "saves: свои" on public.saves for all to authenticated
  using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists "lb: читают все" on public.leaderboard;
create policy "lb: читают все" on public.leaderboard for select to anon, authenticated using (true);
drop policy if exists "lb: вставка своих" on public.leaderboard;
create policy "lb: вставка своих" on public.leaderboard for insert to authenticated with check (auth.uid() = user_id);
drop policy if exists "lb: правка своих" on public.leaderboard;
create policy "lb: правка своих" on public.leaderboard for update to authenticated
  using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists "ach: свои" on public.achievements;
create policy "ach: свои" on public.achievements for all to authenticated
  using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists "skins: читать свои" on public.user_skins;
create policy "skins: читать свои" on public.user_skins for select to authenticated using (auth.uid() = user_id);
-- скины выдаёте вы вручную: Table Editor → user_skins → Insert row (user_id, skin)
