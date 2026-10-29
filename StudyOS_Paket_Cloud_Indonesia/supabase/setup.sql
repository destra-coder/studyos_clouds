-- STUDYOS: database + Row Level Security + Realtime
-- Jalankan seluruh skrip ini di Supabase Dashboard > SQL Editor > New query.

create table if not exists public.studyos_data (
  user_id uuid primary key references auth.users (id) on delete cascade,
  payload jsonb not null default '{"version":1,"records":{},"reviews":{}}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.studyos_data enable row level security;

-- Hapus policy lama bernama sama agar skrip aman dijalankan ulang.
drop policy if exists "studyos_select_own" on public.studyos_data;
drop policy if exists "studyos_insert_own" on public.studyos_data;
drop policy if exists "studyos_update_own" on public.studyos_data;

create policy "studyos_select_own"
on public.studyos_data for select
to authenticated
using (auth.uid() = user_id);

create policy "studyos_insert_own"
on public.studyos_data for insert
to authenticated
with check (auth.uid() = user_id);

create policy "studyos_update_own"
on public.studyos_data for update
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

-- Akses tabel hanya untuk pengguna yang sudah login.
revoke all on table public.studyos_data from anon, public;
grant usage on schema public to authenticated;
grant select, insert, update on table public.studyos_data to authenticated;

-- Aktifkan Postgres Changes untuk sinkronisasi realtime.
do $$
begin
  if not exists (
    select 1
    from pg_publication_tables
    where pubname = 'supabase_realtime'
      and schemaname = 'public'
      and tablename = 'studyos_data'
  ) then
    alter publication supabase_realtime add table public.studyos_data;
  end if;
end $$;
