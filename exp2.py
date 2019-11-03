
from sql_server import SqlServer
from sql_func import wk
import xls

with SqlServer("student_source") as server:

    server.drop(xls.Books).create(xls.Books)

    server.dump_table(xls.get_book())
    print('/*\n{}\n*/'.format(list(server.select(xls.Books))))

    server.drop(xls.TeacherTypes).create(xls.TeacherTypes)

    server.dump_table(xls.get_teacher_type())
    print('/*\n{}\n*/'.format(list(server.select(xls.TeacherTypes))))

    server.drop(xls.Courses).create(xls.Courses)

    server.dump_table(xls.get_course())
    print('/*\n{}\n*/'.format(list(server.select(xls.Courses))))

    server.drop(xls.Classes).create(xls.Classes)

    server.dump_table(xls.get_class())
    print('/*\n{}\n*/'.format(list(server.select(xls.Classes))))

    server.drop(xls.ClassCourses).create(xls.ClassCourses)

    server.dump_table(xls.get_class_course())
    print('/*\n{}\n*/'.format(list(server.select(xls.ClassCourses))))

    server.drop(xls.Departments).create(xls.Departments)

    server.dump_table(xls.get_department())
    print('/*\n{}\n*/'.format(list(server.select(xls.Departments))))

    server.drop(xls.Students).create(xls.Students)

    server.dump_table(xls.get_student())
    print('/*\n{}\n*/'.format(list(server.select(xls.Students))))

    server.drop(xls.StudentCourses).create(xls.StudentCourses)

    server.dump_table(xls.get_student_course())
    print('/*\n{}\n*/'.format(list(server.select(xls.StudentCourses))))

    server.drop(xls.Teachers).create(xls.Teachers)

    server.dump_table(xls.get_teacher())
    print('/*\n{}\n*/'.format(list(server.select(xls.Teachers))))

    server.drop(xls.TeacherCourses).create(xls.TeacherCourses)

    server.dump_table(xls.get_teacher_course())
    print('/*\n{}\n*/'.format(list(server.select(xls.TeacherCourses))))

    server.drop(xls.TeacherCourses).create(xls.TeacherCourses)

    server.dump_table(xls.get_teacher_course())
    print('/*\n{}\n*/'.format(list(server.select(xls.TeacherCourses))))

    q = wk(server)

    q("""exec sp_columns student""")

    server.just_exec("""alter table student add comment varchar(100) not null default ''""")
    print("""alter table student add comment varchar(100) not null default ''""")

    q("""exec sp_columns student""")

    try:
        server.just_exec("""alter table student alter column comment varchar(100) null""")
        print("""alter table student alter column comment varchar(100) null""")
    except Exception as e:
        print("?", e)

    try:
        server.just_exec("""alter table student alter column comment int""")
        print("""alter table student alter column comment int""")
    except Exception as e:
        server.db.rollback()
        server.just_exec("""alter table student drop constraint %s""" % (str(e).split(' ')[3][1:-1]))
        print("""alter table student drop constraint %s""" % (str(e).split(' ')[3][1:-1]))
        server.just_exec("""alter table student alter column comment int""")
        print("""alter table student alter column comment int""")

    q("""exec sp_columns student""")

    server.just_exec("""alter table student drop column comment""")
    print("""alter table student drop column comment""")

    q("""exec sp_columns student""")

    server.drop(xls.Students)

    q("""exec sp_columns student""")

    server.create(xls.Students)

    q("""exec sp_columns student""")

    q("""select name from sys.tables""")

