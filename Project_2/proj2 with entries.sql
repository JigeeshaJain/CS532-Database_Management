drop table logs;
drop table prerequisites;
drop table enrollments;
drop table classes;
drop table courses;
drop table students;


drop sequence log1;
drop package proj2;


create table students (sid char(5) primary key check (sid like 'B%'),
firstname varchar2(20) not null, lastname varchar2(20) not null, status varchar2(10) 
check (status in ('freshman', 'sophomore', 'junior', 'senior', 'graduate')), 
gpa number(3,2) check (gpa between 0 and 4.0), email varchar2(20) unique);

create table courses (dept_code varchar2(4) not null, course_no number(3) not null
check (course_no between 100 and 799), title varchar2(20) not null,
primary key (dept_code, course_no));

create table prerequisites (dept_code varchar2(4) not null,
course_no number(3) not null, pre_dept_code varchar2(4) not null,
pre_course_no number(3) not null,
primary key (dept_code, course_no, pre_dept_code, pre_course_no),
foreign key (dept_code, course_no) references courses on delete cascade,
foreign key (pre_dept_code, pre_course_no) references courses
on delete cascade);

create table classes (classid char(5) primary key check (classid like 'c%'), 
dept_code varchar2(4) not null, course_no number(3) not null, 
sect_no number(2), year number(4), semester varchar2(6) 
check (semester in ('Spring', 'Fall', 'Summer')), limit number(3), 
class_size number(3), foreign key (dept_code, course_no) references courses
on delete cascade, unique(dept_code, course_no, sect_no, year, semester),
check (class_size <= limit));

create table enrollments (sid char(5) references students, classid char(5) references classes, 
lgrade char check (lgrade in ('A', 'B', 'C', 'D', 'F', 'I', null)), primary key (sid, classid));

create table logs (logid number(4) primary key, who varchar2(10) not null, time date not null,
table_name varchar2(20) not null, operation varchar2(6) not null, key_value varchar2(14));



create sequence log1
increment by 1
start with 0
minvalue 0000
maxvalue 9999
nocycle
cache 20;

insert into students values ('B0001','John','Smith','junior',3.9,'john.smith@gmail.com');
insert into students values ('B0002','rohan','deore','senior',3.2,'rohan.deor@gmail.com');
insert into students values ('B0003','Brad','Green','senior',3.9,'brad.gree@gmail.com');
insert into students values ('B0004','Jack','Perry','sophomore',3.2,'jack.gre@gmail.com');
insert into students values ('B0005','Peter','Geller','junior',2.9,'peter.gre@gmail.com');

insert into courses values ('CS', 432, 'database systems');
insert into courses values ('Math', 314, 'discrete math');
insert into courses values ('CS', 240, 'data structure');
insert into courses values ('Math', 221, 'calculus I');
insert into courses values ('CS', 532, 'database systems');
insert into courses values ('CS', 552, 'operating systems');
insert into courses values ('CS', 355, 'operating systems');

insert into prerequisites values ('CS',532,'CS',432);
insert into prerequisites values ('CS',552,'CS',355);
insert into prerequisites values ('Math',314,'Math', 221);
insert into prerequisites values ('CS',432,'CS', 240);


insert into classes values  ('c0001', 'CS', 432, 1, 2020, 'Fall', 35, 34);
insert into classes values  ('c0002', 'Math', 314, 1, 2020, 'Fall', 25, 24);
insert into classes values  ('c0003', 'Math', 314, 2, 2020, 'Fall', 25, 22);
insert into classes values  ('c0004', 'CS', 432, 1, 2021, 'Spring', 30, 30);
insert into classes values  ('c0005', 'CS', 240, 1, 2021, 'Fall', 40, 39);
insert into classes values  ('c0006', 'CS', 532, 1, 2021, 'Fall', 29, 28);
insert into classes values  ('c0007', 'Math', 221, 1, 2021, 'Spring', 30, 30);


insert into enrollments values  ('B0002', 'c0002', 'B');
insert into enrollments values  ('B0003', 'c0004', 'A');
insert into enrollments values  ('B0004', 'c0004', 'C');
insert into enrollments values  ('B0004', 'c0005', 'B');
insert into enrollments values  ('B0005', 'c0006', 'B');
insert into enrollments values  ('B0001', 'c0004', 'A');
insert into enrollments values  ('B0001', 'c0006', 'B');
insert into enrollments values  ('B0001', 'c0003', 'A');
insert into enrollments values  ('B0001', 'c0005', 'B');

create package proj2 as 
procedure insert_in_students(s_id in students.sid%type,fname in students.firstname%type,lname in students.lastname%type,st in students.status%type);
procedure insert_into_logs(w in logs.who%type, o_time in logs.time%type, tablename in logs.table_name%type,op in logs.operation%type, keyvalue in logs.key_value%type);

procedure show_students(rc out sys_refcursor);
procedure show_logs(rc out sys_refcursor);

end proj2;
/
show errors
