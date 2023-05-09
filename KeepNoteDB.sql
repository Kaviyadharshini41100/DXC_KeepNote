Create Database KeepNoteDB
Use KeepNoteDB
Create Table UserRecords(
user_id int Primary Key,
user_name varchar(20),
user_added_date DateTime,
user_password varchar(20),
user_mobile bigint
)
Create Table NoteRecords(
note_id int Primary Key,
note_title varchar(30),
note_content varchar(50),
note_status varchar(20),
note_creation_date DateTime,
user_id int references UserRecords(user_id)
)
Create Table CategoryRecords(
category_id int Primary Key,
category_name varchar(20),
category_descr varchar(50),
category_creation_date DateTime,
category_creator int references UserRecords(user_id)
)
Create Table ReminderRecords(
reminder_id int Primary Key,
reminder_name varchar(40),
reminder_descr varchar(50),
reminder_type varchar(40),
reminder_creation_date DateTime,
reminder_creator int
)
Create Table NoteCategory(
notecategory_id int Primary Key,
note_id int references NoteRecords(note_id),
category_id int references CategoryRecords(category_id)
)
Create Table NoteReminder(
notereminder_id int Primary key,
note_id int references NoteRecords(note_id),
reminder_id int references CategoryRecords(category_id)
)

Insert into UserRecords values(112233,'Maya','2019-01-02','Maya1214',8012345679),(112244,'Nair','2019-01-11','Welcome',9023778467)

Insert into NoteRecords values(1,'Today Tasks','1.Check emails and reply to them 2.Start the Pro..','InProgress','2019-01-21',112233),(2,'Training to plan','1.Application related 2.Technical relates','Yet to Start','2019-01-31',112244),(3,'Things to have Today','1.Fruits 2.More Water','InProgress','2019-01-25',112244)

Insert into CategoryRecords values(1,'Official','Office related notes','2019-01-21',112233),(2,'Diet','Health related notes','2019-01-24',112244)

Insert into ReminderRecords values(1,'KT reminder','session on technical queries','Office reminders','2019-02-12',112233),(2,'Personal reminder','Pick children','Personal reminders','2019-02-14',112244)

Insert into NoteCategory values(1,1,1),(2,2,1),(3,3,2)

Insert into NoteReminder values (1,3,2),(2,2,1)

select * from UserRecords 
select * from NoteRecords
select * from CategoryRecords
select * from ReminderRecords
select * from NoteCategory
select * from NoteReminder
---query 1 ---
select * from UserRecords where user_id=112233 and user_password='Maya1214'
---query 2 ---
select * from NoteRecords where note_creation_date='2019-01-31'
---query 3 ---
select * from CategoryRecords where category_creation_date > '2019-01-22'
---query 4 ---
select * from CategoryRecords where category_id = (select category_id from NoteRecords where note_id =1)
---query 5 ---
select * from NoteRecords where user_id=112244
---query 6 ---
select * from NoteRecords where user_id=(select category_creator from CategoryRecords where category_id=1)
---query 7 ---
select * from ReminderRecords inner join  NoteRecords on ReminderRecords.reminder_id= NoteRecords.note_id where note_id=2
---query 8 ---
update NoteRecords set note_status='Completed' where note_id=3 
select * from NoteRecords
---query 9 ---
Update ReminderRecords SET reminder_type = 'Personal Reminder' where reminder_creator=(select user_id from NoteRecords where note_id=1)
select * from ReminderRecords
---query 10 ---
Delete from NoteReminder where note_id=2
select * from NoteReminder
