
from sql_server import SqlServer
from sql_func import fc, wk
import pymssql

def up():
    database_name = 'student_source'

    with SqlServer(auto_commit=True) as server:
        q = wk(server)
        q("""select * from sys.databases where name = '%s'""" % (database_name,))
        server.just_exec("""
if exists(select name from sys.databases where name='student_source')
drop database student_source;
        """)
        print("""
if exists(select name from sys.databases where name='student_source')
drop database student_source;
        """)
        q("""select * from sys.databases where name = '%s'""" % (database_name,))
        server.just_exec("""
CREATE DATABASE student_source
ON PRIMARY
(
    NAME='stu_main',
    FILENAME='/home/sql/main.mdf',
    SIZE=8MB,
    MAXSIZE=unlimited,
    FILEGROWTH=1MB
),
FILEGROUP Course1
(
    NAME = 'course_1',
    FILENAME='/home/sql/c1.ndf',
    SIZE=8MB,
    MAXSIZE=unlimited,
    FILEGROWTH=1MB
),
FILEGROUP Course2
(
    NAME = 'course_2',
    FILENAME='/home/sql/c2.ndf',
    SIZE=8MB,
    MAXSIZE=unlimited,
    FILEGROWTH=1MB
)
LOG ON
(
    NAME = 'logger',
    FILENAME='/home/sql/c2.ldf',
    SIZE=8MB,
    MAXSIZE=1GB,
    FILEGROWTH=10%
)
        """)
        print("""
CREATE DATABASE student_source
ON PRIMARY
(
    NAME='stu_main',
    FILENAME='/home/sql/main.mdf',
    SIZE=8MB,
    MAXSIZE=unlimited,
    FILEGROWTH=1MB
),
FILEGROUP Course1
(
    NAME = 'course_1',
    FILENAME='/home/sql/c1.ndf',
    SIZE=8MB,
    MAXSIZE=unlimited,
    FILEGROWTH=1MB
),
FILEGROUP Course2
(
    NAME = 'course_2',
    FILENAME='/home/sql/c2.ndf',
    SIZE=8MB,
    MAXSIZE=unlimited,
    FILEGROWTH=1MB
)
LOG ON
(
    NAME = 'logger',
    FILENAME='/home/sql/c2.ldf',
    SIZE=8MB,
    MAXSIZE=1GB,
    FILEGROWTH=10%
)
        """)
        q("""select * from sys.databases where name = '%s'""" % (database_name,))


def modify():
    database_name = 'student_source'

    with SqlServer(auto_commit=True) as server:
        server.just_exec("""
alter database %s
add filegroup Course_3
        """ % (database_name, ))
        print("""
alter database %s
add filegroup Course_3
        """ % (database_name, ))

        server.just_exec("""
alter database %s
add file
(
    name = course_3,
    FILENAME='/home/sql/c3.ndf',
    SIZE=8MB,
    MAXSIZE=unlimited,
    FILEGROWTH=2MB
)
to filegroup Course_3
        """ % (database_name, ))
        print("""
alter database %s
add file
(
    name = course_3,
    FILENAME='/home/sql/c3.ndf',
    SIZE=8MB,
    MAXSIZE=unlimited,
    FILEGROWTH=2MB
)
to filegroup Course_3
        """ % (database_name, ))


def down():
    database_name = 'student_source'

    with SqlServer(auto_commit=True) as server:
        q = wk(server)
        s = fc(server)

        if server.get_database_id(database_name):
            server.just_exec("""
alter database %s
remove file course_3
                        """ % (database_name,))
            print("""
alter database %s
remove file course_3
                        """ % (database_name,))

            server.just_exec("""
alter database %s
remove filegroup Course_3
            """ % (database_name, ))
            print("""
alter database %s
remove filegroup Course_3
            """ % (database_name, ))


if __name__ == '__main__':
    from exp1 import main as main1

    print("----------------------------------------------       up       ----------------------------------------------")
    up()
    print("----------------------------------------------    after up    ----------------------------------------------")
    main1()

    print("----------------------------------------------     modify     ----------------------------------------------")
    modify()
    print("----------------------------------------------  after modify  ----------------------------------------------")
    main1()

    print("----------------------------------------------      down      ----------------------------------------------")
    down()
    print("----------------------------------------------    after down  ----------------------------------------------")
    main1()
