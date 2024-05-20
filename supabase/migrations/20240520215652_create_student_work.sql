
create table student_work
(
    id                uuid        not null default uuid_generate_v4() primary key,
    source            text        not null references data_source (id) on update cascade on delete cascade,
    position_title    text        not null,
    posted_at         timestamptz not null,
    category          text        not null check (category in ('Student Work', 'Summer Student Work')),
    department_id     uuid references directory_entry (id),
    department_name   text,
    classification    text,
    position_duration text,
    description       text,
    pay_rate          text,
    skills            text,
    duties            text,
    qualifications    text,
    constraint department_id_or_name check (case
                                                when department_id is not null then department_name is null
                                                when department_name is null then department_id is not null end)
);

alter table student_work enable row level security;

create policy "student_work is viewable by everyone"
on student_work for select
to authenticated, anon
using ( true );
