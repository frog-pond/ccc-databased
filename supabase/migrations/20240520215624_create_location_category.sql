create table location_category
(
    id         uuid not null default uuid_generate_v4() primary key,
    title      text not null unique check (length(title) between 0 and 256),
    sort_title text unique check (length(sort_title) between 0 and 256),
    source     text not null references data_source (id) on update cascade on delete cascade
);

alter table location_category enable row level security;

create policy "location_category is viewable by everyone"
on location_category for select
to authenticated, anon
using ( true );
