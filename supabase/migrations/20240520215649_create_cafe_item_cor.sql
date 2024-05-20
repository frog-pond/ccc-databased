
create table cafe_item_cor
(
    cafe_item_id uuid not null references cafe_item (id),
    cafe_cor_id  text not null references cafe_cor (id),
    primary key (cafe_item_id, cafe_cor_id)
);

alter table cafe_item_cor enable row level security;

create policy "cafe_item_cor is viewable by everyone"
on cafe_item_cor for select
to authenticated, anon
using ( true );
