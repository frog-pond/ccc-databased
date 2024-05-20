create table location
(
    id            uuid  not null default uuid_generate_v4() primary key,
    source        text  not null default 'manual',
    within        uuid references location (id) on update cascade on delete restrict,
    category      uuid  not null references location_category (id) on update cascade on delete restrict, -- TODO: keep as 1-1, or allow multiple?
    title         text  not null default '',
    subtitle      text  not null default '',
    abbreviation  text  not null default '',
    room_number   text  not null default '',
    outline_shape jsonb not null default '[]'::jsonb,                                                    -- geojson
    coordinates   jsonb not null default '[]'::jsonb,
    -- todo: keep these?
    banner_uri    text  not null default '',
    icon_uri      text  not null default '',
    website_uri   text  not null default '',
    phone         text  not null default '',
    email         text  not null default ''
);

alter table location enable row level security;

create policy "location is viewable by everyone"
on location for select
to authenticated, anon
using ( true );
