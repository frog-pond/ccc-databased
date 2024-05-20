create table dictionary
(
    id          uuid not null default uuid_generate_v4() primary key,
    source      text not null references data_source (id) on update cascade on delete cascade,
    uri         text not null default '',
    title       text not null check (length(title) < 1024),
    sort_title  text null check (length(sort_title) < 1024),
    subtitle    text not null default '' check (length(subtitle) < 1024),
    description text not null default '' check (length(description) < 65536),
    tint_color  text not null default '#fff',
    text_color  text not null default '#000',
    image_uri   text,
    sort_group  text not null generated always as ( left(upper(sort_title), 1) ) stored
);

alter table dictionary enable row level security;

create policy "dictionary is viewable by everyone"
on dictionary for select
to authenticated, anon
using ( true );
