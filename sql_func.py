
from prettytable import from_db_cursor


def wk(db):
    def from_statement(statement):
        print(statement)
        print("/*")
        cursor = db.query_cursor(statement)
        while True:
            print(from_db_cursor(cursor))
            if not cursor.nextset():
                break
        print("*/")
        db.return_cursor(cursor)

    return from_statement


def fc(db):
    def from_cursor(cursor):
        while True:
            print(from_db_cursor(cursor))
            if not cursor.nextset():
                break
        db.return_cursor(cursor)
    return from_cursor
