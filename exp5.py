

from sql_server import SqlServer
from sql_func import fc, wk
import pymssql

if __name__ == '__main__':
    database_name = 'student_source'

    with SqlServer(database_name, auto_commit=True) as server:
        
        # server.drop_foreign_key("class", "fk_header_teacher_on_class")
        # server.just_exec("""alter table class add constraint fk_header_teacher_on_class foreign key(header_teacher) references teacher(id)""")
        
        server.drop_foreign_key("course", "fk_book_id_on_course")
        server.just_exec("""
insert into book(id, name) select id, 'auto_generated' from (
    (select book_id as id from course) except (select id from book)) as ids
        """)
        server.just_exec("""alter table course add constraint fk_book_id_on_course foreign key(book_id) references book(id)""")
        
        server.drop_foreign_key("class_course", "fk_class_id_on_class_course")
        server.just_exec("""
insert into class(id, dept_id, address) select id, 'dep_05', 'auto_generated' from (
    (select class_id as id from class_course) except (select id from class)) as ids
        """)
        server.just_exec("""alter table class_course add constraint fk_class_id_on_class_course foreign key(class_id) references class(id)""")
        
        server.drop_foreign_key("class_course", "fk_course_id_on_class_course")
        server.just_exec("""
insert into course(id, book_id, name) select id, 'dep01_s001_01', 'auto_generated' from (
    (select course_id as id from class_course) except (select id from course)) as ids
        """)
        server.just_exec("""alter table class_course add constraint fk_course_id_on_class_course foreign key(course_id) references course(id)""")
        
#         server.drop_foreign_key("department", "fk_leader_on_department")
#         server.just_exec("""
# insert into teacher(id, name, dept_id) select concat(N'auto_generated', name), name, 'dep_05' from (
#     (select leader as name from department) except (select name from teacher)) as names
#         """)
#         server.just_exec("""alter table department add constraint fk_leader_on_department foreign key(leader) references teacher(name)""")
        
        server.drop_foreign_key("student", "fk_class_id_on_student")
        server.just_exec("""
insert into class(id, dept_id, address) select id, 'dep_05', 'auto_generated' from (
    (select class_id as id from student) except (select id from class)) as ids
        """)
        server.just_exec("""alter table student add constraint fk_class_id_on_student foreign key(class_id) references class(id)""")
        
        server.drop_foreign_key("student_course", "fk_course_id_on_student_course")
        server.just_exec("""alter table student_course add constraint fk_course_id_on_student_course foreign key(course_id) references course(id)""")
        
        server.drop_foreign_key("student_course", "fk_student_id_on_student_course")
        server.just_exec("""alter table student_course add constraint fk_student_id_on_student_course foreign key(student_id) references student(id)""")
        
        server.drop_foreign_key("teacher", "fk_dept_id_on_teacher")
        server.just_exec("""alter table teacher add constraint fk_dept_id_on_teacher foreign key(dept_id) references department(id)""")
        
        server.drop_foreign_key("class", "fk_dept_id_on_class")
        server.just_exec("""alter table class add constraint fk_dept_id_on_class foreign key(dept_id) references department(id)""")
        
        server.drop_foreign_key("teacher", "fk_cat_on_teacher")
        server.just_exec("""alter table teacher add constraint fk_cat_on_teacher foreign key(cat) references teacher_type(id)""")
        
        server.drop_foreign_key("teacher_course", "fk_teacher_id_on_teacher_course")
        server.just_exec("""alter table teacher_course add constraint fk_teacher_id_on_teacher_course foreign key(teacher_id) references teacher(id)""")
        
        server.drop_foreign_key("teacher_course", "fk_course_id_on_teacher_course")
        server.just_exec("""alter table teacher_course add constraint fk_course_id_on_teacher_course foreign key(course_id) references course(id)""")
        
        server.drop_foreign_key("teacher_course", "fk_class_id_on_teacher_course")
        server.just_exec("""alter table teacher_course add constraint fk_class_id_on_teacher_course foreign key(class_id) references class(id)""")
        
        server.drop_foreign_key("teacher_course", "fk_book_id_on_teacher_course")
        server.just_exec("""alter table teacher_course add constraint fk_book_id_on_teacher_course foreign key(book_id) references book(id)""")

        try:
            server.just_exec("""insert into student(id) values ('g0940201')""")
        except Exception as e:
            print("/* 验证实体完整性约束", type(e), e, "*/")

        try:
            server.just_exec("""insert into student(id, class_id) values ('not_exists_id', 'not_exists_class')""")
        except Exception as e:
            print("/* 验证参照完整性约束", type(e), e, "*/")

        server.just_exec("""create login teacher with password=N'123321aA', default_database=%s""" % (database_name,))
        server.just_exec("""alter login teacher with password=N'789987aA'""")
        server.just_exec("""alter login teacher disable""")
        server.just_exec("""drop login teacher""")

        server.just_exec("""create login teacher with password=N'123321aA', default_database=%s""" % (database_name,))
        server.just_exec("""create user professor for login teacher with default_schema=dbo""")
        server.just_exec("""alter user professor with name=professor2""")
        server.just_exec("""drop user professor2""")
        server.just_exec("""create user professor for login teacher with default_schema=dbo""")
        server.just_exec("""grant all on teacher to professor""")
        server.just_exec("""revoke select on teacher to professor""")
        server.just_exec("""drop user professor""")
        server.just_exec("""drop login teacher""")

#        CREATE LOGIN [WIN-5UAU8F9CP3F\andy] FROM WINDOWS WITH DEFAULT_DATABASE=[master]
