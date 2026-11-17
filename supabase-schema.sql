-- Obrat: one private JSON backup per authenticated account.
create table if not exists public.app_state (
  user_id uuid primary key references auth.users (id) on delete cascade,
  state jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.app_state enable row level security;
revoke all on table public.app_state from anon;
grant select, insert, update, delete on table public.app_state to authenticated;

drop policy if exists "Read own app state" on public.app_state;
create policy "Read own app state"
  on public.app_state for select to authenticated
  using ((select auth.uid()) = user_id);

drop policy if exists "Insert own app state" on public.app_state;
create policy "Insert own app state"
  on public.app_state for insert to authenticated
  with check ((select auth.uid()) = user_id);

drop policy if exists "Update own app state" on public.app_state;
create policy "Update own app state"
  on public.app_state for update to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

drop policy if exists "Delete own app state" on public.app_state;
create policy "Delete own app state"
  on public.app_state for delete to authenticated
  using ((select auth.uid()) = user_id);
