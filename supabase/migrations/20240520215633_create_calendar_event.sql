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

alter table calendar_event
    enable row level security;

create policy "Enable read access for all users"
    on calendar_event for select
    to public using (true);

---

create table calendar_event_category
(
    calendar_event_id uuid not null references calendar_event (id) on update cascade on delete cascade,
    category_id       uuid not null references content_category (id) on update cascade on delete cascade,
    source            text not null references data_source (id) on update cascade on delete cascade,
    primary key (calendar_event_id, category_id)
);

alter table calendar_event_category
    enable row level security;

create policy "Enable read access for all users"
    on calendar_event_category for select
    to public using (true);

---

create table calendar_event_link
(
    calendar_event_id uuid not null references calendar_event (id) on update cascade on delete cascade,
    source            text not null references data_source (id) on update cascade on delete cascade,
    href              text not null,
    title             text not null,
    content_type      text,
    link_mode         text not null check (link_mode in ('a', 'stream')),
    primary key (calendar_event_id, href)
);

alter table calendar_event_link
    enable row level security;

create policy "Enable read access for all users"
    on calendar_event_link for select
    to public using (true);
