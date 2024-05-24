create table app_notice
(
    id           uuid        not null default gen_random_uuid() primary key,
    source       text        not null references data_source (id) on update cascade on delete cascade,
    created_at   timestamptz not null default current_timestamp,
    title        text        not null,
    subtitle     text        null,
    body         text        null,
    severity     text        not null check (severity in ('stop', 'note', 'caution', 'plain')), -- taken from https://developer.apple.com/documentation/corefoundation/1534483-alert_levels
    active_from  timestamptz null,
    active_until timestamptz null,
    app_version  text        null,
    platform     text        null
);

create index on app_notice (source);
create index on app_notice (active_until) where (active_until is not null);

alter table app_notice
    enable row level security;

create policy "Enable read access for all users"
    on app_notice for select
    to public using (true);
