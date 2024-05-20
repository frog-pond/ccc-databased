create table cafe
(
    id          uuid not null default uuid_generate_v4() primary key,
    source      text not null references data_source (id) on update cascade on delete cascade,
    name        text not null,
    description text,
    location    uuid null references location (id)
);

alter table cafe enable row level security;

create policy "cafe is viewable by everyone"
on cafe for select
to authenticated, anon
using ( true );
