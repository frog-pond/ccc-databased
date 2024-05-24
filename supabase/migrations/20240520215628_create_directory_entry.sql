create table directory_entry
(
    id           uuid not null default gen_random_uuid() primary key,
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

create index on directory_entry (source);

alter table directory_entry
    enable row level security;

create policy "Enable read access for all users"
    on directory_entry for select
    to public using (true);

---

create table directory_entry_category
(
    directory_entry uuid references directory_entry (id) on update cascade on delete cascade,
    category        text not null check (length(trim(category)) > 0)
);

create index on directory_entry_category (directory_entry);

alter table directory_entry_category
    enable row level security;

create policy "Enable read access for all users"
    on directory_entry_category for select
    to public using (true);

---

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

create index on directory_entry_location (directory_entry);
create index on directory_entry_location (location);
create index on directory_entry_location (source);

alter table directory_entry_location
    enable row level security;

create policy "Enable read access for all users"
    on directory_entry_location for select
    to public using (true);

---

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

create index on directory_entry_organization (directory_entry);
create index on directory_entry_organization (directory_organization);
create index on directory_entry_organization (source);

alter table directory_entry_organization
    enable row level security;

create policy "Enable read access for all users"
    on directory_entry_organization for select
    to public using (true);
