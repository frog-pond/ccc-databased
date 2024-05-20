create table feed
(
    source text not null references data_source (id) on update cascade on delete cascade,
    title  text not null check (length(title) > 0),
    uri    text not null,
    primary key (uri)
);

alter table feed enable row level security;

create policy "feed is viewable by everyone"
on feed for select
to authenticated, anon
using ( true );
