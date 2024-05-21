create table metadata
(
    source text not null references data_source (id) on update cascade on delete cascade,
    key    text not null check (key in ('app-version', 'color-printer')),
    value  text not null default '' check (length(value) < 1024),
    primary key (key, value)
);

alter table metadata
    enable row level security;

create policy "metadata is viewable by everyone"
    on metadata for select
    to authenticated, anon
    using (true);
