from collections import namedtuple


class _TableCollectionSys:
    def __init__(self):
        self.Database = namedtuple('Database', ['name'])


class _TableCollection:
    def __init__(self):
        self.create_table = namedtuple
        self.Sys = _TableCollectionSys()


TableCollection = _TableCollection()

