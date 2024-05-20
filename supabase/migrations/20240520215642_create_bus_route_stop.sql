create table bus_route_stop
(
    id          uuid  not null default uuid_generate_v4() primary key,
    source      text  not null references data_source (id) on update cascade on delete cascade,
    name        text  not null,
    coordinates jsonb not null default '[]'::jsonb
);

alter table bus_route_stop enable row level security;

create policy "bus_route_stop is viewable by everyone"
on bus_route_stop for select
to authenticated, anon
using ( true );
