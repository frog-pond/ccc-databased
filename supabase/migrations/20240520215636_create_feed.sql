create table feed
(
    source text not null references data_source (id) on update cascade on delete cascade,
    title  text not null check (length(title) > 0),
    uri    text not null,
    primary key (uri)
);

alter table feed
    enable row level security;

create policy "Enable read access for all users"
    on feed for select
    to public using (true);

---

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

alter table feed_article
    enable row level security;

create policy "Enable read access for all users"
    on feed_article for select
    to public using (true);

---

create table feed_article_category
(
    feed_article_id uuid not null references feed_article (id) on update cascade on delete cascade,
    category_id     uuid not null references content_category (id) on update cascade on delete cascade,
    primary key (feed_article_id, category_id)
);

alter table feed_article_category
    enable row level security;

create policy "Enable read access for all users"
    on feed_article_category for select
    to public using (true);
