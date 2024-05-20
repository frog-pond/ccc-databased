
create table cafe_cor
(
    id          text not null primary key,
    title       text not null,
    description text not null,
    icon_uri    text not null
);

alter table cafe_cor enable row level security;

create policy "cafe_cor is viewable by everyone"
on cafe_cor for select
to authenticated, anon
using ( true );
