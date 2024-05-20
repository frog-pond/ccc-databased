
create table cafe_item_variation
(
    cafe_item_id uuid not null references cafe_item (id),
    title        text not null,
    description  text
);

alter table cafe_item_variation enable row level security;

create policy "cafe_item_variation is viewable by everyone"
on cafe_item_variation for select
to authenticated, anon
using ( true );
