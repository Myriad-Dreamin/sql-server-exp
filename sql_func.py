
from prettytable import from_db_cursor


def wk(db):
    def res(statement):
        print(statement)
        cursor = db.query_cursor(statement)
        while True:
            print(from_db_cursor(cursor))
            if not cursor.nextset():
                break
    return res
