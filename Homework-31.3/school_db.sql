-- exercise 2
create schema school_db;
use school_db;

create table students (
studentid int not null auto_increment,
firstname varchar(45),
lastname varchar(45),
dateofbirth date,
primary key(studentid));

create table courses (
courseid int not null auto_increment,
coursename varchar(100),
lecturername varchar(100),
assistant varchar(100),
duration int,
startdate date,
primary key(courseid));

create table exams (
examid int not null auto_increment,
courseid int,
primary key(examid));

create table student_course (
studentid int,
courseid int,
primary key(studentid));

create table examinations (
examinationid int not null auto_increment,
studentid int,
examid int not null,
courseid int,
grade int,
primary key(examinationid));

insert into students(firstname, lastname, dateofbirth) values ('Giorgos', 'Georgiou', '1995-07-31');
insert into students(firstname, lastname, dateofbirth) values ('Panos', 'Panoglou', '1990-10-25');
insert into students(firstname, lastname, dateofbirth) values ('Maria', 'Mariopoulou', '1992-08-05');

insert into courses(coursename, lecturername, assistant, duration, startdate) values ('Java', 'Tasos', 'Kostas', 10, '2020-3-30');
insert into courses(coursename, lecturername, assistant, duration, startdate) values ('SQL', 'Petros', 'Makis', 20, '2020-4-10');

insert into student_course(studentid, courseid) values (1, 1);
insert into student_course(studentid, courseid) values (2, 1);
insert into student_course(studentid, courseid) values (3, 2);

insert into exams (courseid) values (1);
insert into exams (courseid) values (1);
insert into exams (courseid) values (2);
insert into exams (courseid) values (2);

-- exercise 3
insert into examinations(studentid, examid, courseid, grade) values (1, 1, 1, 10);
insert into examinations(studentid, examid, courseid, grade) values (1, 2, 1, 8);
insert into examinations(studentid, examid, courseid, grade) values (2, 1, 1, 7);
insert into examinations(studentid, examid, courseid, grade) values (2, 2, 1, 9);
insert into examinations(studentid, examid, courseid, grade) values (3, 3, 2, 6);
insert into examinations(studentid, examid, courseid, grade) values (3, 4, 2, 6);

-- exercise 4
select students.firstname as FirstName, students.lastname as LastName
from students
join examinations on students.studentid = examinations.studentid
join exams on exams.examid = examinations.examid
group by students.studentid;

-- exercise 5
select students.firstname as FirstName, students.lastname as LastName, examinations.examid as ExamID, examinations.grade as ExamGrade
from students
join examinations on students.studentid = examinations.studentid;

-- exercise 6
select students.firstname as FirstName, students.lastname as LastName, avg(examinations.grade) as AverageGrade
from students
join examinations on students.studentid = examinations.studentid
group by students.studentid;

-- exercise 7
select students.firstname as FirstName, students.lastname as LastName, avg(examinations.grade) as AverageGrade
from students
join examinations on students.studentid = examinations.studentid
group by students.studentid
having avg(examinations.grade) > 5;

-- exercise 8
select courses.coursename as CourseName, avg(examinations.grade) as AverageGrade
from courses
join examinations on courses.courseid = examinations.courseid
group by courses.courseid;

-- exercise 9
select students.firstname as FirstName, students.lastname as LastName, courses.coursename as CourseName
from students, courses, student_course
where students.studentid = student_course.studentid
and courses.courseid = student_course.courseid
and courses.coursename = 'SQL';

-- exercise 10
select courses.coursename as CourseName, max(examinations.grade) as MaxGrade
from courses
join examinations on courses.courseid = examinations.courseid
group by courses.courseid;

select students.firstname as FirstName, students.lastname as LastName, courses.coursename as CourseName, max(examinations.grade) as MaxGrade
from students
join examinations on students.studentid = examinations.studentid
join courses on courses.courseid = examinations.courseid
where examinations.grade > 5
and courses.coursename = 'SQL'
group by students.studentid;





