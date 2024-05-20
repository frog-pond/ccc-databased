create table feed_article
(
    id                 uuid        not null default uuid_generate_v4() primary key,
    source             text        not null references data_source (id) on update cascade on delete cascade,
    published_at       timestamptz not null,
    updated_at         timestamptz null,
    title              text        not null check (length(title) > 0),
    body               text        not null default '',
    thumbnail_uri      text        null,
    banner_uri         text        null,
    sponsoring_entity  uuid        null references directory_entry (id) on update cascade on delete set null,
    campus_location_id uuid        null references location (id) on update cascade on delete set null,
    textual_location   text        null,
    constraint only_one_location check ( case when campus_location_id is not null then textual_location is null end )
);

alter table feed_article enable row level security;

create policy "feed_article is viewable by everyone"
on feed_article for select
to authenticated, anon
using ( true );
