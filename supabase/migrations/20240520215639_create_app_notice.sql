create table app_notice
(
    id           uuid        not null default uuid_generate_v4() primary key,
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

alter table app_notice
    enable row level security;

create policy "app_notice is viewable by everyone"
    on app_notice for select
    to authenticated, anon
    using (true);
