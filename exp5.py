

from sql_server import SqlServer
from sql_func import fc, wk
import pymssql

def up():
    database_name = 'student_source'

    with SqlServer(auto_commit=True) as server:
        server.just_exec("""create login teacher with password=N'123321', default_database=%s""" % database_name)
        server.just_exec("""alter login teacher with password=N'789987'""")
        server.just_exec("""alter login teacher disable""")
        server.just_exec("""drop login teacher""")

        server.just_exec("""create login teacher with password=N'123321', default_database=%s""")
        server.just_exec("""create user professor for login teacher with default_schema=dbo""")
        server.just_exec("""alter user professor with name=professor2""")
        server.just_exec("""drop user professor2""")
        server.just_exec("""create user professor for login teacher with default_schema=dbo""")
        server.just_exec("""grant all on teacher to professor""")
        server.just_exec("""revoke select on teacher to professor""")

#        CREATE LOGIN [WIN-5UAU8F9CP3F\andy] FROM WINDOWS WITH DEFAULT_DATABASE=[master]
