create table calendar_event
(
    id                     uuid        not null default uuid_generate_v4() primary key,
    source                 text        not null references data_source (id) on update cascade on delete cascade,
    recurrence_of_event_id uuid        null references calendar_event (id) on update cascade on delete cascade,
    start_time             timestamptz not null,
    end_time               timestamptz not null check (end_time >= start_time),
    title                  text        not null check (length(title) > 0),
    description            text        not null default '',
    thumbnail_uri          text        null,
    banner_uri             text        null,
    sponsoring_entity      uuid        null references directory_entry (id) on update cascade on delete set null,
    campus_location_id     uuid        null references location (id) on update cascade on delete set null,
    textual_location       text        null,
    constraint only_one_location check ( case when campus_location_id is not null then textual_location is null end )
);

alter table calendar_event enable row level security;

create policy "calendar_event is viewable by everyone"
on calendar_event for select
to authenticated, anon
using ( true );
