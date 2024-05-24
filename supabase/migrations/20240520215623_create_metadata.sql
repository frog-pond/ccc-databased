create table metadata
(
    source text not null references data_source (id) on update cascade on delete cascade,
    key    text not null check (key in ('app-version', 'color-printer')),
    value  text not null default '' check (length(value) < 1024),
    primary key (key, value)
);

create index on metadata(source);

alter table metadata
    enable row level security;

create policy "Enable read access for all users"
    on metadata for select
    to public using (true);
