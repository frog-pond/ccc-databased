create table location_schedule
(
    id                uuid        not null default gen_random_uuid() primary key,
    source            text        not null references data_source (id) on update cascade on delete cascade,
    parent_schedule   uuid        null references location_schedule (id) on update cascade on delete cascade,
    location_category uuid        null references location_category (id),
    location          uuid        null references location (id),
    title             text        not null,
    status            text        not null default 'open' check (status in ('open', 'closed')),
    message           text        null check (case when status != 'open' then message is not null end),
    active_from       timestamptz not null,
    active_until      timestamptz null,
    audience          text        not null default '*' check (audience in ('*', 'students', 'seniors', 'facstaff')),
    constraint category_or_location check (case
                                               when location_category is not null then location is null
                                               when location is null then location_category is not null end)
);

alter table location_schedule
    enable row level security;

create policy "Enable read access for all users"
    on location_schedule for select
    to public using (true);

---

create table location_schedule_timetable
(
    id                   uuid            not null default gen_random_uuid() primary key,
    source               text            not null references data_source (id),
    location_schedule_id uuid            not null references location_schedule (id),
    days                 text            not null,
    open_at              time            not null,
    open_for             interval minute not null
);

alter table location_schedule_timetable
    enable row level security;

create policy "Enable read access for all users"
    on location_schedule_timetable for select
    to public using (true);
