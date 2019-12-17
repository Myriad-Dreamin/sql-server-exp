

from sql_server import SqlServer
from sql_func import fc, wk
import pymssql

if __name__ == '__main__':
    database_name = 'student_source'

    with SqlServer(database_name, auto_commit=True) as server:
        q = wk(server)
        server.drop_procedure("sel_course_check")
        with open('sel_course_check.sql') as f:
            proc = f.read()
        server.just_exec(proc)
        q("""execute sel_course_check 'g0940207'""")

        server.drop_procedure("show_tea")
        with open('show_tea.sql') as f:
            proc = f.read()
        server.just_exec(proc)
        q("""execute show_tea""")

        # todo 修改 show_tea 用于查询副教授职称的姓，性别，职称和授课名
        # 删除存储过程

        server.drop_trigger("check_teachers_dept_id")
        with open('check_teachers_dept_id.sql') as f:
            trigger = f.read()
        server.just_exec(trigger)
        # q("""execute show_tea""")

        try:
            server.just_exec("""insert into teacher(id, dept_id) values ('not_exists_id', 'not_exists_dept')""")
        except Exception as e:
            # pymssql.OperationalError().args
            print("/* 验证触发器约束", type(e), e.args[0], e.args[1].decode('utf-8'), "*/")


        server.drop_trigger("update_class")
        with open('update_class.sql') as f:
            trigger = f.read()
        server.just_exec(trigger)

        server.just_exec("""update class set id='test' where id='g09403' """)

        q("""select id, class_id from student""")

        server.just_exec("""update class set id='g09403' where id='test' """)

        q("""select id, class_id from student""")

    
