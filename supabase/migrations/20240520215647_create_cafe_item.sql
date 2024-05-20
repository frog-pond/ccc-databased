
create table cafe_item
(
    id          uuid  not null default uuid_generate_v4() primary key,
    source      text  not null references data_source (id) on update cascade on delete cascade,
    title       text  not null,
    description text,
    rating      decimal,
    monotony    jsonb not null default '{}'::jsonb, -- TODO: expand this into a table
    nutrition   jsonb not null default '{}'::jsonb  -- TODO: expand this into a table
);

alter table cafe_item enable row level security;

create policy "cafe_item is viewable by everyone"
on cafe_item for select
to authenticated, anon
using ( true );
