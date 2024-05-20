create table feed_article_category
(
    feed_article_id uuid not null references feed_article (id) on update cascade on delete cascade,
    category_id     uuid not null references content_category (id) on update cascade on delete cascade,
    primary key (feed_article_id, category_id)
);

alter table feed_article_category enable row level security;

create policy "feed_article_category is viewable by everyone"
on feed_article_category for select
to authenticated, anon
using ( true );
