create table livestream
(
    id              uuid not null default uuid_generate_v4() primary key,
    source          text not null references data_source (id) on update cascade on delete cascade,
    title           text not null,
    subtitle        text not null,
    stream_uri      text not null,
    tint_color      text null,
    text_color      text null,
    logo_uri        text null,
    calendar_source text null references data_source (id) on update cascade on delete restrict,
    phone           text null,
    email           text null,
    website         text null
);

alter table livestream
    enable row level security;

create policy "Enable read access for all users"
    on livestream for select
    to public using (true);
