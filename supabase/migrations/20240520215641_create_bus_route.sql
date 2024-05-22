create table bus_route
(
    id     uuid not null default uuid_generate_v4() primary key,
    source text not null references data_source (id) on update cascade on delete cascade,
    key    text not null,
    title  text not null
);

alter table bus_route
    enable row level security;

create policy "Enable read access for all users"
    on bus_route for select
    to public using (true);

---

create table bus_route_stop
(
    id          uuid  not null default uuid_generate_v4() primary key,
    source      text  not null references data_source (id) on update cascade on delete cascade,
    name        text  not null,
    coordinates jsonb not null default '[]'::jsonb
);

alter table bus_route_stop
    enable row level security;

create policy "Enable read access for all users"
    on bus_route_stop for select
    to public using (true);

---

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

alter table bus_route_timetable
    enable row level security;

create policy "Enable read access for all users"
    on bus_route_timetable for select
    to public using (true);

---

create table bus_route_schedule
(
    bus_route_id uuid        not null references bus_route (id) on update cascade on delete restrict,
    timetable_id uuid        not null references bus_route_timetable (id) on update cascade on delete restrict,
    source       text        not null references data_source (id) on update cascade on delete cascade,
    active_from  timestamptz null,
    active_until timestamptz null
);

alter table bus_route_schedule
    enable row level security;

create policy "Enable read access for all users"
    on bus_route_schedule for select
    to public using (true);
