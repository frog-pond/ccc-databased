create table bus_route_schedule
(
    bus_route_id     uuid        not null references bus_route (id) on update cascade on delete restrict,
    timetable_id uuid        not null references bus_route_timetable (id) on update cascade on delete restrict,
    source       text        not null references data_source (id) on update cascade on delete cascade,
    active_from  timestamptz null,
    active_until timestamptz null
);

alter table bus_route_schedule enable row level security;

create policy "bus_route_schedule is viewable by everyone"
on bus_route_schedule for select
to authenticated, anon
using ( true );
