create table bus_route
(
    id     uuid not null default uuid_generate_v4() primary key,
    source text not null references data_source (id) on update cascade on delete cascade,
    key    text not null,
    title  text not null
);

alter table bus_route enable row level security;

create policy "bus_route is viewable by everyone"
on bus_route for select
to authenticated, anon
using ( true );
