
from sql_server import SqlServer
from sql_func import fc, wk
import pymssql


def main():
    database_name = 'student_source'

    with SqlServer() as server:
        has_database_flag = (server.get_database_id(database_name) is not None)

    with SqlServer(database_name if has_database_flag else None) as server:
        q = wk(server)
        s = fc(server)

        s(server.show_database_cursor())

        q("""select * from sys.databases where name = '%s'""" % (database_name,))

        q("""select * from sys.database_files""")
        q("""select * from sys.filegroups""")
        id = server.get_database_id(database_name)
        if id:
            q("""select file_id, file_guid, type_desc, name, physical_name,
                size, max_size, growth, is_percent_growth
                from sys.master_files where database_id = %d """ % (id,))


if __name__ == '__main__':
    main()

