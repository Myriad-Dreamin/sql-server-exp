
from tables_results import TableCollection
from sql_server import SqlServer
import xls

with SqlServer("student_source") as server:
    print(server.show_database())

    server.drop(xls.Books).create(xls.Books)

    print(server.dump_table(xls.get_book()))
    print(list(server.select(xls.Books)))

    server.drop(xls.TeacherTypes).create(xls.TeacherTypes)

    print(server.dump_table(xls.get_teacher_type()))
    print(list(server.select(xls.TeacherTypes)))

    server.drop(xls.Courses).create(xls.Courses)

    print(server.dump_table(xls.get_course()))
    print(list(server.select(xls.Courses)))

    server.drop(xls.Classes).create(xls.Classes)

    print(server.dump_table(xls.get_class()))
    print(list(server.select(xls.Classes)))

    server.drop(xls.ClassCourses).create(xls.ClassCourses)

    print(server.dump_table(xls.get_class_course()))
    print(list(server.select(xls.ClassCourses)))

    server.drop(xls.Departments).create(xls.Departments)

    print(server.dump_table(xls.get_department()))
    print(list(server.select(xls.Departments)))

    server.drop(xls.Students).create(xls.Students)

    print(server.dump_table(xls.get_student()))
    print(list(server.select(xls.Students)))

    server.drop(xls.StudentCourses).create(xls.StudentCourses)

    print(server.dump_table(xls.get_student_course()))
    print(list(server.select(xls.StudentCourses)))

    server.drop(xls.Teachers).create(xls.Teachers)

    print(server.dump_table(xls.get_teacher()))
    print(list(server.select(xls.Teachers)))

    server.drop(xls.TeacherCourses).create(xls.TeacherCourses)

    print(server.dump_table(xls.get_teacher_course()))
    print(list(server.select(xls.TeacherCourses)))

    server.drop(xls.TeacherCourses).create(xls.TeacherCourses)

    print(server.dump_table(xls.get_teacher_course()))
    print(list(server.select(xls.TeacherCourses)))
