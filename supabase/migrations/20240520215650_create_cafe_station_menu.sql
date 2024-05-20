
create table cafe_station_menu
(
    id                 uuid    not null default uuid_generate_v4() primary key,
    source             text    not null references data_source (id) on update cascade on delete cascade,
    station_title      text    not null,
    station_note       text    null,
    station_sort_order integer not null,
    item_id            uuid    not null references cafe_item (id) on update cascade on delete cascade,
    item_sort_order    integer not null,
    is_featured        bool    not null default false
);

alter table cafe_station_menu enable row level security;

create policy "cafe_station_menu is viewable by everyone"
on cafe_station_menu for select
to authenticated, anon
using ( true );
