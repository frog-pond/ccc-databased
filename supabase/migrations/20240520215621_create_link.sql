create table link
(
    source      text not null references data_source (id) on update cascade on delete cascade,
    type        text not null check (type in ('a-z', 'webcam', 'help', 'transit', 'contact', 'definition', 'app-link',
                                              'app-faq', 'app-tool')),
    uri         text not null default '',
    title       text not null check (length(title) < 1024),
    sort_title  text null check (length(sort_title) < 1024),
    subtitle    text not null default '' check (length(subtitle) < 1024),
    description text not null default '' check (length(description) < 65536),
    tint_color  text not null default '#fff',
    text_color  text not null default '#000',
    image_uri   text,
    sort_group  text not null default '',
    primary key (type, title)
);

alter table link
    enable row level security;

create policy "link is viewable by everyone"
    on link for select
    to authenticated, anon
    using (true);
