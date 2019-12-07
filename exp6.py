

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
        print(proc)
        server.just_exec(proc)
        q("""execute sel_course_check 'g0940207'""")

        server.drop_procedure("show_tea")
        with open('show_tea.sql') as f:
            proc = f.read()
        print(proc)
        server.just_exec(proc)
        q("""execute show_tea""")


