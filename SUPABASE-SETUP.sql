-- Estrutura opcional para o Smart Life Online.
-- O aplicativo envia apenas um pacote criptografado no dispositivo.

create table if not exists public.smart_life_sync (
  sync_id text primary key,
  payload text not null,
  updated_at timestamptz not null default now()
);

alter table public.smart_life_sync enable row level security;

drop policy if exists "smart_life_sync_anon" on public.smart_life_sync;
create policy "smart_life_sync_anon"
on public.smart_life_sync
for all
to anon
using (true)
with check (true);

-- Use um ID de sincronização aleatório e uma senha forte dentro do aplicativo.
-- A chave anônima do Supabase identifica o projeto; ela não descriptografa o conteúdo.

