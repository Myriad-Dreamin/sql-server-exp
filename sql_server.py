import datetime
import xlrd
import pymssql

from tables_results import TableCollection


class nstr:
    def __init__(self, data):
        self.data = str(data)

    def __str__(self):
        return self.data


class datetime_str:
    def __init__(self, data):
        if isinstance(data, float):
            self.data = xlrd.xldate_as_datetime(data, 0).date()
        else:
            self.data = datetime.date(*map(int, data.split('/')))

    def __str__(self):
        return str(self.data)


class SqlServer:
    def __init__(self, database=None, auto_commit=None, host='localhost', user='SA', password='<xX123456>'):
        self.db = None
        self.database = database
        self.host = host
        self.user = user
        self.password = password
        self.auto_commit = auto_commit

    def __enter__(self):
        self.close()
        self.db = pymssql.connect(self.host, self.user, self.password,
                                  self.database)
        if self.auto_commit is not None:
            self.db.autocommit(self.auto_commit)
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.close()

    def show_database_cursor(self):
        return self.query_cursor("""select Name from sys.databases;""")

    def show_database(self) -> TableCollection.Sys.Database:
        cursor = self.show_database_cursor()
        results = [TableCollection.Sys.Database(name=row[0]) for row in cursor.fetchall()]
        self.return_cursor(cursor)
        return results

    def get_database_id(self, database_name):
        res = self.query("""select database_id from sys.databases where name = '%s'""" % (database_name, ))
        if len(res) != 0:
            return res[0][0]
        return None

    @staticmethod
    def return_cursor(cursor):
        return cursor.close()

    def just_exec(self, stmt):
        self.db.cursor().execute(stmt)
        self.db.commit()
        return self

    def query_cursor(self, stmt):
        cursor = self.db.cursor()
        cursor.execute(stmt)
        return cursor

    def query(self, stmt):
        cursor = self.query_cursor(stmt)
        results = cursor.fetchall()
        self.return_cursor(cursor)
        return results

    def use_database(self, db_name):
        return self.just_exec("use " + db_name)

    def dump_table(self, table):
        return self.just_exec("insert into " + table.Table + "(" + ','.join(table.Columns) + ")" + " values" +
                              ','.join(["(" + ','.join(["N'" + str(column) + "'" if isinstance(column, nstr)
                                                        else "'" + column + "'" if isinstance(column, str)
                                                        else "'" + str(column) + "'" if isinstance(column, datetime_str)
                                                        else "'" + str(column) + "'" if isinstance(column, datetime.date)
                                                        else str(column) for column in row]) + ")" for row in table]))

    def drop(self, table):
        print("""
        if exists(select name from sys.tables where name='%s')
        drop table %s;
        """ % (table.Table, table.Table))
        return self.just_exec("""
        if exists(select name from sys.tables where name='%s')
        drop table %s;
        """ % (table.Table, table.Table))

    def drop_database(self, database_name):
        print("""
        if exists(select name from sys.databases where name='%s')
        drop database %s;
        """ % (database_name, database_name))
        return self.just_exec("""
        if exists(select name from sys.databases where name='%s')
        drop database %s;
        """ % (database_name, database_name))

    def create(self, table):
        print(table.CreateStatement)
        return self.just_exec(table.CreateStatement)

    def select(self, table):
        return self.query("select * from " + table.Table)

    def close(self):
        if self.db is not None:
            self.db.close()
            self.db = None


if __name__ == '__main__':
    server = SqlServer()
    print(server.show_database())
    server.close()
