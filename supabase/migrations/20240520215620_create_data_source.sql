create table data_source (
  id text not null primary key,
  type text not null check (type in ('manual', 'automated-scrape', 'scrape')),
  uri text check (
    case
      when type != 'manual' then uri is not null
    end
  )
);

comment on table data_source is 'the authoritative list of data sources, including manual data entry';

comment on column data_source.type is 'what type of source is this?';

comment on column data_source.uri is 'where did we start this scrape from?';

alter table data_source enable row level security;

create policy "data_source are viewable by everyone" on data_source for
select
  to authenticated,
  anon using (true);
