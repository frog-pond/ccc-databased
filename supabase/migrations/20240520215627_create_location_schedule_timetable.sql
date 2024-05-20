create table location_schedule_timetable
(
    id                   uuid            not null default uuid_generate_v4() primary key,
    source               text            not null references data_source (id),
    location_schedule_id uuid            not null references location_schedule (id),
    days                 text            not null,
    open_at              time            not null,
    open_for             interval minute not null
);

alter table location_schedule_timetable enable row level security;

create policy "location_schedule_timetable is viewable by everyone"
on location_schedule_timetable for select
to authenticated, anon
using ( true );
