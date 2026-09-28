-- Base de datos para Control Lotería de Navidad
-- Ejecuta este SQL en Supabase > SQL Editor.

create table if not exists public.app_state (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.app_state enable row level security;

drop policy if exists "Usuarios pueden leer sus datos" on public.app_state;
create policy "Usuarios pueden leer sus datos"
  on public.app_state for select
  to authenticated
  using (auth.uid() = user_id);

drop policy if exists "Usuarios pueden crear sus datos" on public.app_state;
create policy "Usuarios pueden crear sus datos"
  on public.app_state for insert
  to authenticated
  with check (auth.uid() = user_id);

drop policy if exists "Usuarios pueden actualizar sus datos" on public.app_state;
create policy "Usuarios pueden actualizar sus datos"
  on public.app_state for update
  to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

create index if not exists app_state_updated_at_idx on public.app_state(updated_at);
