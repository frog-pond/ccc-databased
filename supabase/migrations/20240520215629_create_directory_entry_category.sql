-- TODO: what is this for, again?
create table directory_entry_category
(
    directory_entry uuid references directory_entry (id) on update cascade on delete cascade,
    category        text not null check (length(trim(category)) > 0)
);

alter table directory_entry_category enable row level security;

create policy "directory_entry_category is viewable by everyone"
on directory_entry_category for select
to authenticated, anon
using ( true );
