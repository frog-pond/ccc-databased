create table calendar_event_category
(
    calendar_event_id uuid not null references calendar_event (id) on update cascade on delete cascade,
    category_id       uuid not null references content_category (id) on update cascade on delete cascade,
    source            text not null references data_source (id) on update cascade on delete cascade,
    primary key (calendar_event_id, category_id)
);

alter table calendar_event_category enable row level security;

create policy "calendar_event_category is viewable by everyone"
on calendar_event_category for select
to authenticated, anon
using ( true );
