
create table cafe_menu_schedule
(
    schedule_id uuid not null references location_schedule (id),
    station_id  uuid not null references cafe_station_menu (id),
    primary key (schedule_id, station_id)
);

alter table cafe_menu_schedule enable row level security;

create policy "cafe_menu_schedule is viewable by everyone"
on cafe_menu_schedule for select
to authenticated, anon
using ( true );
