
if exists(select constraint_name from information_schema.key_column_usage where constraint_name='fk_book_id_on_course')
alter table course drop constraint fk_book_id_on_course
        

insert into book(id, name) select id, 'auto_generated' from (
    (select book_id as id from course) except (select id from book)) as ids
        
alter table course add constraint fk_book_id_on_course foreign key(book_id) references book(id)

if exists(select constraint_name from information_schema.key_column_usage where constraint_name='fk_class_id_on_class_course')
alter table class_course drop constraint fk_class_id_on_class_course
        

insert into class(id, dept_id, address) select id, 'dep_05', 'auto_generated' from (
    (select class_id as id from class_course) except (select id from class)) as ids
        
alter table class_course add constraint fk_class_id_on_class_course foreign key(class_id) references class(id)

if exists(select constraint_name from information_schema.key_column_usage where constraint_name='fk_course_id_on_class_course')
alter table class_course drop constraint fk_course_id_on_class_course
        

insert into course(id, book_id, name) select id, 'dep01_s001_01', 'auto_generated' from (
    (select course_id as id from class_course) except (select id from course)) as ids
        
alter table class_course add constraint fk_course_id_on_class_course foreign key(course_id) references course(id)

if exists(select constraint_name from information_schema.key_column_usage where constraint_name='fk_class_id_on_student')
alter table student drop constraint fk_class_id_on_student
        

insert into class(id, dept_id, address) select id, 'dep_05', 'auto_generated' from (
    (select class_id as id from student) except (select id from class)) as ids
        
alter table student add constraint fk_class_id_on_student foreign key(class_id) references class(id)

if exists(select constraint_name from information_schema.key_column_usage where constraint_name='fk_course_id_on_student_course')
alter table student_course drop constraint fk_course_id_on_student_course
        
alter table student_course add constraint fk_course_id_on_student_course foreign key(course_id) references course(id)

if exists(select constraint_name from information_schema.key_column_usage where constraint_name='fk_student_id_on_student_course')
alter table student_course drop constraint fk_student_id_on_student_course
        
alter table student_course add constraint fk_student_id_on_student_course foreign key(student_id) references student(id)

if exists(select constraint_name from information_schema.key_column_usage where constraint_name='fk_dept_id_on_teacher')
alter table teacher drop constraint fk_dept_id_on_teacher
        
alter table teacher add constraint fk_dept_id_on_teacher foreign key(dept_id) references department(id)

if exists(select constraint_name from information_schema.key_column_usage where constraint_name='fk_dept_id_on_class')
alter table class drop constraint fk_dept_id_on_class
        
alter table class add constraint fk_dept_id_on_class foreign key(dept_id) references department(id)

if exists(select constraint_name from information_schema.key_column_usage where constraint_name='fk_cat_on_teacher')
alter table teacher drop constraint fk_cat_on_teacher
        
alter table teacher add constraint fk_cat_on_teacher foreign key(cat) references teacher_type(id)

if exists(select constraint_name from information_schema.key_column_usage where constraint_name='fk_teacher_id_on_teacher_course')
alter table teacher_course drop constraint fk_teacher_id_on_teacher_course
        
alter table teacher_course add constraint fk_teacher_id_on_teacher_course foreign key(teacher_id) references teacher(id)

if exists(select constraint_name from information_schema.key_column_usage where constraint_name='fk_course_id_on_teacher_course')
alter table teacher_course drop constraint fk_course_id_on_teacher_course
        
alter table teacher_course add constraint fk_course_id_on_teacher_course foreign key(course_id) references course(id)

if exists(select constraint_name from information_schema.key_column_usage where constraint_name='fk_class_id_on_teacher_course')
alter table teacher_course drop constraint fk_class_id_on_teacher_course
        
alter table teacher_course add constraint fk_class_id_on_teacher_course foreign key(class_id) references class(id)

if exists(select constraint_name from information_schema.key_column_usage where constraint_name='fk_book_id_on_teacher_course')
alter table teacher_course drop constraint fk_book_id_on_teacher_course
        
alter table teacher_course add constraint fk_book_id_on_teacher_course foreign key(book_id) references book(id)
insert into student(id) values ('g0940201')
/* 验证实体完整性约束 <class 'pymssql.IntegrityError'> (2627, b"Violation of PRIMARY KEY constraint 'PK__student__3213E83F4544E73F'. Cannot insert duplicate key in object 'dbo.student'. The duplicate key value is (g0940201).DB-Lib error message 20018, severity 14:\nGeneral SQL Server error: Check messages from the SQL Server\n") */
insert into student(id, class_id) values ('not_exists_id', 'not_exists_class')
/* 验证参照完整性约束 <class 'pymssql.IntegrityError'> (547, b'The INSERT statement conflicted with the FOREIGN KEY constraint "fk_class_id_on_student". The conflict occurred in database "student_source", table "dbo.class", column \'id\'.DB-Lib error message 20018, severity 16:\nGeneral SQL Server error: Check messages from the SQL Server\n') */
create login teacher with password=N'123321aA', default_database=student_source
alter login teacher with password=N'789987aA'
alter login teacher disable
drop login teacher
create login teacher with password=N'123321aA', default_database=student_source
create user professor for login teacher with default_schema=dbo
alter user professor with name=professor2
drop user professor2
create user professor for login teacher with default_schema=dbo
grant all on teacher to professor
revoke select on teacher to professor
drop user professor
drop login teacher
