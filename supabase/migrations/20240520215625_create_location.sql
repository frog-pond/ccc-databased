create table location
(
    id            uuid                          not null default gen_random_uuid() primary key,
    source        text                          not null default 'manual',
    within        uuid                          null references location (id) on update cascade on delete restrict,
    title         text                          not null default '',
    subtitle      text                          not null default '',
    abbreviation  text                          not null default '',
    room_number   text                          not null default '',
    outline_shape geography(GEOMETRYCOLLECTION) null,
    coordinates   geography(POINT)              null,
    -- todo: keep these?
    banner_uri    text                          not null default '',
    icon_uri      text                          not null default '',
    website_uri   text                          not null default '',
    phone         text                          not null default '',
    email         text                          not null default ''
);

alter table location
    enable row level security;

create policy "Enable read access for all users"
    on location for select
    to public using (true);

---

create table location_category
(
    id         uuid not null default gen_random_uuid() primary key,
    title      text not null unique check (length(title) between 0 and 256),
    sort_title text unique check (length(sort_title) between 0 and 256),
    source     text not null references data_source (id) on update cascade on delete cascade
);

alter table location_category
    enable row level security;

create policy "Enable read access for all users"
    on location_category for select
    to public using (true);

---

create table location_category_mapping
(
    location_id          uuid not null references location (id),
    location_category_id uuid not null references location_category (id)
);

alter table location_category_mapping
    enable row level security;

create policy "Enable read access for all users"
    on location_category_mapping for select
    to public using (true);
