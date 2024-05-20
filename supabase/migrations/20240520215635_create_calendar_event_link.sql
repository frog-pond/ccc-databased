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

alter table calendar_event_link enable row level security;

create policy "calendar_event_link is viewable by everyone"
on calendar_event_link for select
to authenticated, anon
using ( true );
