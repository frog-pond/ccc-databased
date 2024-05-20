create table directory_entry_organization
(
    directory_entry        uuid not null references directory_entry (id) on update cascade on delete cascade,
    directory_organization uuid not null references directory_entry (id) on update cascade on delete cascade,
    source                 text not null references data_source (id) on update cascade on delete cascade,
    role                   text, -- not sure if needed, or if can be replaced with title
    title                  text,
    email                  text,
    phone                  text,
    fax                    text,
    hours                  text, -- can we use a schedule record for this? probably not...
    description            text
);

alter table directory_entry_organization enable row level security;

create policy "directory_entry_organization is viewable by everyone"
on directory_entry_organization for select
to authenticated, anon
using ( true );
