create table directory_entry_location
(
    directory_entry uuid not null references directory_entry (id) on update cascade on delete cascade,
    location        uuid not null references location (id) on update cascade on delete cascade,
    source          text not null references data_source (id) on update cascade on delete cascade,
    title           text,
    email           text,
    phone           text,
    fax             text,
    hours           text, -- can we use a schedule record for this? probably not...
    description     text
);

alter table directory_entry_location enable row level security;

create policy "directory_entry_location is viewable by everyone"
on directory_entry_location for select
to authenticated, anon
using ( true );
