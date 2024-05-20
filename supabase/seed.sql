-- data source

insert into data_source (type, id)
values ('manual', 'manual');

-- link

INSERT INTO link (type, uri, title, subtitle, sort_group, source)
VALUES ('a-z', 'https://moodle.stolaf.edu', 'Moodle', '', 'M', 'manual'),
       ('a-z', 'https://stolaf.edu/apps/tes', 'TES', 'Time Entry System', 'T',
        'manual');

INSERT INTO link (type, uri, title, sort_group, description, source)
VALUES ('transit', 'https://wp.stolaf.edu/transportation/', 'Transportation Options', 'All',
        'View all available transportation options on the St. Olaf website.', 'manual');

INSERT INTO link (type, uri, title, description, source, image_uri, tint_color, text_color)
VALUES ('webcam', 'https://www.stolaf.edu/multimedia/webcams/?cam=eastquad#fold', 'East Quad',
        'Looking out to Regents, Holland Hall, and Old Main', 'manual',
        '/eastquad.png', '#525736', '#fff');

INSERT INTO link (type, uri, title, sort_group, description, source, image_uri)
VALUES ('contact', 'tel:+15077863666', 'St. Olaf Public Safety', 'Safety',
        '**24-Hour Public Safety Dispatch.** [Public Safety][pubsafe] is available 24 hours a day, most days of the year. Call Public Safety in many situations, but there is always the option of calling the police as well.

[pubsafe]: https://wp.stolaf.edu/publicsafety/ "PubSafe"',
        'manual',
        '/pubsafe.png');

INSERT INTO link (type, uri, title, sort_group, description, source)
VALUES ('app-faq', '', '2am too often???', 'Known Issues',
        'Building Hours: It reports the 2am buildings as open too often; for instance, the Pause is open on Saturday at 2am, continuing from Friday, but the app reports it as being open on Friday at 2am, as well. This is incorrect.',
        'manual');

INSERT INTO link (type, uri, title, sort_group, description, source)
VALUES ('help', 'mailto:allaboutolaf@frogpond.tech?subject=A+Thing', 'Have an App Question?', '',
        'If you''ve got a question about the app, or a new feature idea, let us know!',
        'manual');

-- dictionary

INSERT INTO dictionary (title, sort_title, description, source)
VALUES ('AAC', 'aac', 'The Academic Advising Center provides support in exploring academic goals within the context of possible career and life-long goals. The Center supports both faculty advisors and their advisees in providing the necessary information and skills to fulfill graduation, general education and major requirements.

The Center also assists students in exploring possible major options, in changing faculty advisors, in using a degree audit, class/lab schedule, and the St. Olaf Catalog for necessary information about fulfilling requirements.

Academic Peer Advisors assist the Center.', 'manual');

-- metadata

insert into metadata (source, key, value)
values ('manual', 'app-version', '2.9.0');

insert into metadata (source, key, value)
values ('manual', 'color-printer', 'mfc-rml-4-disco'),
       ('manual', 'color-printer', 'mfc-toh101');

-- location_category

insert into location_category (title, source)
values ('Campus', 'manual'),
       ('Faculty/Staff Office', 'manual'),
       ('Café', 'manual'),
       ('Building', 'manual'),
       ('Department', 'manual'),
       ('Supplies & Books', 'manual'),
       ('Libraries', 'manual'),
       ('Help & Support', 'manual'),
       ('Gym & Exercise', 'manual'),
       ('Health & Wellness', 'manual'),
       ('Academia', 'manual'),
       ('Residence Hall', 'manual'),
       ('Museums & Studios', 'manual');

-- location

insert into location (within, category, title, abbreviation, room_number)
values (null, (select id from location_category where title = 'Campus'), 'St. Olaf College', '', '');

insert into location (within, category, title, abbreviation)
values ((select id from location where title = 'St. Olaf College'),
        (select id from location_category where title = 'Building'),
        'Regents Hall (Natural Science)', 'RNS')
     , ((select id from location where title = 'St. Olaf College'),
        (select id from location_category where title = 'Building'),
        'Buntrock Commons', 'BC')
     , ((select id from location where title = 'St. Olaf College'),
        (select id from location_category where title = 'Building'),
        'Regents Hall (Mathematical Science)', 'RMS')
     , ((select id from location where title = 'St. Olaf College'),
        (select id from location_category where title = 'Building'),
        'Rølvaag Memorial Library', 'RML')
;

insert into location (within, category, title, room_number)
values ((select id from location where title = 'Regents Hall (Natural Science)'),
        (select id from location_category where title = 'Department'),
        'Biology Office', '260')
     , ((select id from location where title = 'Regents Hall (Natural Science)'),
        (select id from location_category where title = 'Faculty/Staff Office'),
        '', '412')
     , ((select id from location where title = 'Buntrock Commons'),
        (select id from location_category where title = 'Café'),
        'Stav Hall', '???')
;

-- location_schedule

insert into location_schedule (source, parent_schedule, location_category, location, title, active_from, active_until)
values ('manual', null, null, (select id from location where title = 'Stav Hall'),
        'Breakfast', '2024-01-01T00:00:00', null);

-- location_schedule_timetable

insert into location_schedule_timetable (source, location_schedule_id, days, open_at, open_for)
values ('manual', (select id from location_schedule where title = 'Breakfast'),
        ':mo:tu:we:th:fr:', '07:15'::time, '2 hours 30 minutes'::interval),
       ('manual', (select id from location_schedule where title = 'Breakfast'),
        ':sa:', '08:00'::time, '1 hour 30 minutes'::interval),
       ('manual', (select id from location_schedule where title = 'Breakfast'),
        ':su:', '08:00'::time, '1 hour'::interval);

-- directory_entry

insert into directory_entry (name, source, sort_name, type, phone, email, pronouns, profile_uri, profile_text, title,
                             photo, office_hours, specialties)
values ('Barbara Barth', 'manual', 'Barth Barbara', 'individual', null,
        'barth@stolaf.edu', null, null, null, 'Academic Administrative Assistant - Team West',
        'https://www.stolaf.edu/stofaces/face.cfm?username=barth&v=298BFEA&fullsize', null, null);

-- directory_entry_location

insert into directory_entry_location (directory_entry, location, email, phone, fax, hours, description, source)
values ((select id from directory_entry where name = 'Barbara Barth'),
        (select id from location limit 1 /* todo: fix */),
        null, '+1-507-786-3568', null, null, null, 'manual');

-- content_category

insert into content_category (title)
values ('Scheduling'),
       ('Academics'),
       ('Athletics'),
       ('Alumni'),
       ('Campaign'),
       ('Campus and Community'),
       ('Chapel'),
       ('Conferences/Camps'),
       ('Featured'),
       ('Giving'),
       ('Meetings/Workshops'),
       ('Multicultural'),
       ('Music'),
       ('Performing and Visual Arts'),
       ('Piper Center'),
       ('Recreation'),
       ('SGA and Student Life'),
       ('Speakers/Lectures'),
       ('Special Events/Celebrations'),
       ('Vocation and Career');

-- bus_route

insert into bus_route (source, key, title)
values ('manual', 'hiawathaland-blue-route', 'Blue Route');
