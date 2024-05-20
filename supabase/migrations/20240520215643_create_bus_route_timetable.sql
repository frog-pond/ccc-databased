create table bus_route_timetable
(
    id            uuid not null default uuid_generate_v4() primary key,
    source        text not null references data_source (id) on update cascade on delete cascade,
    inbound_stop  uuid null references bus_route_stop (id),
    inbound_time  time null,
    outbound_stop uuid null references bus_route_stop (id),
    outbound_time time null,
    constraint inbound_time_if_stop check (case when inbound_stop is not null then inbound_time is not null end),
    constraint outbound_time_if_stop check (case when outbound_stop is not null then outbound_time is not null end)
);

alter table bus_route_timetable enable row level security;

create policy "bus_route_timetable is viewable by everyone"
on bus_route_timetable for select
to authenticated, anon
using ( true );
