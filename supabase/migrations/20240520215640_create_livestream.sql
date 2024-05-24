create table livestream
(
    id                uuid not null default gen_random_uuid() primary key,
    source            text not null references data_source (id) on update cascade on delete cascade,
    title             text not null,
    subtitle          text not null,
    stream_uri        text not null,
    tint_color        text null,
    text_color        text null,
    logo_uri          text null,
    calendar_event_id text null references calendar_event (id) on update cascade on delete cascade,
    phone             text null,
    email             text null,
    website           text null
);

create index on livestream (source);
create index on livestream (calendar_event_id);

alter table livestream
    enable row level security;

create policy "Enable read access for all users"
    on livestream for select
    to public using (true);
