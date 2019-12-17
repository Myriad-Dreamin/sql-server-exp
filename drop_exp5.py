

from sql_server import SqlServer
from sql_func import fc, wk
import pymssql

if __name__ == '__main__':
    database_name = 'student_source'

    with SqlServer(database_name, auto_commit=True) as server:
        server.drop_foreign_key("class", "fk_header_teacher_on_class")
        server.drop_foreign_key("course", "fk_book_id_on_course")
        server.drop_foreign_key("class_course", "fk_class_id_on_class_course")
        server.drop_foreign_key("class_course", "fk_course_id_on_class_course")
        server.drop_foreign_key("department", "fk_leader_on_department")
        server.drop_foreign_key("student", "fk_class_id_on_student")
        server.drop_foreign_key("student_course", "fk_course_id_on_student_course")
        server.drop_foreign_key("student_course", "fk_student_id_on_student_course")
        server.drop_foreign_key("teacher", "fk_dept_id_on_teacher")
        server.drop_foreign_key("class", "fk_dept_id_on_class")
        server.drop_foreign_key("teacher", "fk_cat_on_teacher")
        server.drop_foreign_key("teacher_course", "fk_teacher_id_on_teacher_course")
        server.drop_foreign_key("teacher_course", "fk_course_id_on_teacher_course")
        server.drop_foreign_key("teacher_course", "fk_class_id_on_teacher_course")
        server.drop_foreign_key("teacher_course", "fk_book_id_on_teacher_course")