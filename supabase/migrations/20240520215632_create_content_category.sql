create table content_category
(
    id         uuid not null default gen_random_uuid() primary key,
    title      text not null unique check (length(title) between 0 and 256),
    sort_title text null unique check (length(sort_title) between 0 and 256)
);

alter table content_category
    enable row level security;

create policy "Enable read access for all users"
    on content_category for select
    to public using (true);
