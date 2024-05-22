create table cafe
(
    id          uuid not null default uuid_generate_v4() primary key,
    source      text not null references data_source (id) on update cascade on delete cascade,
    name        text not null,
    description text,
    location    uuid null references location (id)
);

alter table cafe
    enable row level security;

create policy "Enable read access for all users"
    on cafe for select
    to public using (true);

---

create table cafe_cor
(
    id          text not null primary key,
    title       text not null,
    description text not null,
    icon_uri    text not null
);

alter table cafe_cor
    enable row level security;

create policy "Enable read access for all users"
    on cafe_cor for select
    to public using (true);

---

create table cafe_item
(
    id          uuid  not null default uuid_generate_v4() primary key,
    source      text  not null references data_source (id) on update cascade on delete cascade,
    title       text  not null,
    description text,
    rating      decimal,
    monotony    jsonb not null default '{}'::jsonb, -- TODO: expand this into a table
    nutrition   jsonb not null default '{}'::jsonb  -- TODO: expand this into a table
);

alter table cafe_item
    enable row level security;

create policy "Enable read access for all users"
    on cafe_item for select
    to public using (true);

---

create table cafe_item_variation
(
    cafe_item_id uuid not null references cafe_item (id),
    title        text not null,
    description  text
);

alter table cafe_item_variation
    enable row level security;

create policy "Enable read access for all users"
    on cafe_item_variation for select
    to public using (true);

---

create table cafe_item_cor
(
    cafe_item_id uuid not null references cafe_item (id),
    cafe_cor_id  text not null references cafe_cor (id),
    primary key (cafe_item_id, cafe_cor_id)
);

alter table cafe_item_cor
    enable row level security;

create policy "Enable read access for all users"
    on cafe_item_cor for select
    to public using (true);

---

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

alter table cafe_station_menu
    enable row level security;

create policy "Enable read access for all users"
    on cafe_station_menu for select
    to public using (true);

---

create table cafe_menu_schedule
(
    schedule_id uuid not null references location_schedule (id),
    station_id  uuid not null references cafe_station_menu (id),
    primary key (schedule_id, station_id)
);

alter table cafe_menu_schedule
    enable row level security;

create policy "Enable read access for all users"
    on cafe_menu_schedule for select
    to public using (true);