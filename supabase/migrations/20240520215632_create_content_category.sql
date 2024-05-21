create table content_category
(
    id         uuid not null default uuid_generate_v4() primary key,
    title      text not null unique check (length(title) between 0 and 256),
    sort_title text null unique check (length(sort_title) between 0 and 256)
);

alter table content_category
    enable row level security;

create policy "content_category is viewable by everyone"
    on content_category for select
    to authenticated, anon
    using (true);
