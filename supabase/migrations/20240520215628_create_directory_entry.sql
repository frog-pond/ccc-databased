create table directory_entry
(
    id           uuid not null default uuid_generate_v4() primary key,
    source       text not null references data_source (id) on update cascade on delete cascade,
    name         text not null,
    sort_name    text not null,
    -- todo: do we need this field?
    type         text not null check (type in ('individual', 'department', 'organization')),
    phone        text,
    email        text,
    pronouns     text,
    profile_uri  text,
    profile_text text,
    title        text,
    photo        text,
    office_hours text,
    specialties  text
);

alter table directory_entry enable row level security;

create policy "directory_entry is viewable by everyone"
on directory_entry for select
to authenticated, anon
using ( true );
