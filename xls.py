import xlrd
import datetime
from sql_server import nstr, datetime_str
from tables_results import TableCollection

data_source = xlrd.open_workbook('ds.xls')


def get_index(cls, idx):
    def laz():
        sheet = data_source.sheet_by_index(idx)
        return cls(sheet.nrows - 1, [sheet.row_values(i) for i in range(1, sheet.nrows)])
    return laz


class Books(list):
    Table = 'book'
    Columns = ['id', 'name', 'publish', 'author', 'price']
    ColumnsType = [str, nstr, nstr, nstr, float]
    Type = TableCollection.create_table('Book', Columns)
    CreateStatement = """
    create table book (
        id varchar(20) not null primary key,
        name nvarchar(80) not null,
        publish nvarchar(30),
        author nvarchar(15),
        price decimal(10, 3)
    );
    """

    def __init__(self, n, l):
        super().__init__(
            map(lambda x: Books.Type(*map(lambda y: y[0](y[1]), zip(Books.ColumnsType, x))), l))
        self.cnt = n


class TeacherTypes(list):
    Table = 'teacher_type'
    Columns = ['id', 't_type']
    ColumnsType = [int, nstr]
    Type = TableCollection.create_table('TeacherType', Columns)
    CreateStatement = """
    create table teacher_type (
        id smallint not null,
        t_type nvarchar(15) not null,
        primary key(id, t_type)
    );
    """

    def __init__(self, n, l):
        super().__init__(
            map(lambda x: TeacherTypes.Type(*map(lambda y: y[0](y[1]), zip(TeacherTypes.ColumnsType, x))), l))
        self.cnt = n


class Courses(list):
    Table = 'course'
    Columns = ['id', 'name', 'book_id', 'total_hour', 'week_hour', 'credit']
    ColumnsType = [str, nstr, str, int, int, int]
    Type = TableCollection.create_table('Course', Columns)
    CreateStatement = """
    create table course (
        id varchar(20) not null primary key,
        name nvarchar(80),
        book_id varchar(20),
        total_hour int,
        week_hour int,
        credit int
    );
    """

    def __init__(self, n, l):
        super().__init__(
            map(lambda x: Courses.Type(*map(lambda y: y[0](y[1]), zip(Courses.ColumnsType, x))), l))
        self.cnt = n


class Classes(list):
    Table = 'class'
    Columns = ['id', 'head_teacher', 'address', 'dept_id']
    ColumnsType = [str, nstr, nstr, str]
    Type = TableCollection.create_table('Class', Columns)
    CreateStatement = """
    create table class (
        id varchar(20) not null primary key,
        head_teacher nvarchar(15),
        address nvarchar(120),
        dept_id varchar(20)
    );
    """

    def __init__(self, n, l):
        super().__init__(
            map(lambda x: Classes.Type(*map(lambda y: y[0](y[1]), zip(Classes.ColumnsType, x))), l))
        self.cnt = n


class ClassCourses(list):
    Table = 'class_course'
    Columns = ['class_id', 'course_id']
    ColumnsType = [str, str]
    Type = TableCollection.create_table('ClassCourse', Columns)
    CreateStatement = """
    create table class_course (
        class_id varchar(20) not null,
        course_id varchar(20) not null,
        primary key(class_id, course_id)
    );
    """

    def __init__(self, n, l):
        super().__init__(
            map(lambda x: ClassCourses.Type(*map(lambda y: y[0](y[1]), zip(ClassCourses.ColumnsType, x))), l))
        self.cnt = n


class Departments(list):
    Table = 'department'
    Columns = ['id', 'name', 'leader', 'teacher_count']
    ColumnsType = [str, nstr, nstr, int]
    Type = TableCollection.create_table('Department', Columns)
    CreateStatement = """
    create table department (
        id varchar(20) not null primary key,
        name nvarchar(15) not null,
        leader nvarchar(15),
        teacher_count int,
    );
    """

    def __init__(self, n, l):
        super().__init__(
            map(lambda x: Departments.Type(*map(lambda y: y[0](y[1]), zip(Departments.ColumnsType, x))), l))
        self.cnt = n


class Students(list):
    Table = 'student'
    Columns = ['id', 'name', 'class_id', 'gender', 'birth', 'created_at', 'address']
    ColumnsType = [str, nstr, str, nstr, datetime_str, datetime_str, nstr]
    Type = TableCollection.create_table('Student', Columns)
    CreateStatement = """
    create table student (
        id varchar(20) not null primary key,
        name nvarchar(15),
        class_id varchar(20),
        gender nvarchar(2),
        birth datetime,
        created_at datetime default CURRENT_TIMESTAMP,
        address nvarchar(120),
    );
    """

    def __init__(self, n, l):
        super().__init__(
            map(lambda x: Students.Type(*map(lambda y: y[0](y[1]), zip(Students.ColumnsType, x))), l))
        self.cnt = n


class StudentCourses(list):
    Table = 'student_course'
    Columns = ['course_id', 'student_id', 'score', 'credit', 'sem', 'year']
    ColumnsType = [str, str, int, int, int, str]
    Type = TableCollection.create_table('StudentCourse', Columns)
    CreateStatement = """
    create table student_course (
        course_id varchar(20) not null,
        student_id varchar(20) not null,
        score int,
        credit int,
        sem smallint,
        year varchar(20)
    );
    """

    def __init__(self, n, l):
        super().__init__(
            map(lambda x: StudentCourses.Type(*map(lambda y: y[0](y[1]), zip(StudentCourses.ColumnsType, x))), l))
        self.cnt = n


class Teachers(list):
    Table = 'teacher'
    Columns = ['id', 'name', 'gender', 'birth', 'dept_id', 'prof', 'phone', 'address', 'post_code', 'cat']
    ColumnsType = [str, nstr, nstr, datetime_str, str, nstr, str, nstr, str, int]
    Type = TableCollection.create_table('Teacher', Columns)
    CreateStatement = """
    create table teacher (
        id varchar(20) not null primary key,
        name nvarchar(20),
        gender nvarchar(2),
        birth datetime,
        dept_id varchar(20),
        prof nvarchar(5),
        phone varchar(15),
        address nvarchar(120),
        post_code varchar(10),
        cat smallint
    );
    """

    def __init__(self, n, l):
        super().__init__(
            map(lambda x: Teachers.Type(*map(lambda y: y[0](y[1]), zip(Teachers.ColumnsType, x))), l))
        self.cnt = n


class TeacherCourses(list):
    Table = 'teacher_course'
    Columns = ['teacher_id', 'course_id', 'class_id', 'sem', 'year', 'id', 'address', 'book_id']
    ColumnsType = [str, str, str, int, str, int, nstr, str]
    Type = TableCollection.create_table('TeacherCourse', Columns)
    CreateStatement = """
    create table teacher_course (
        teacher_id varchar(20) not null,
        course_id varchar(20) not null,
        class_id varchar(20),
        sem smallint,
        year varchar(20),
        id bigint not null,
        address nvarchar(20),
        book_id varchar(20),
        primary key(teacher_id, course_id, class_id)
    );
    """

    def __init__(self, n, l):
        super().__init__(map(lambda x: TeacherCourses.Type(*map(lambda y: y[0](y[1]), zip(TeacherCourses.ColumnsType, x))), l))
        self.cnt = n


get_book = get_index(Books, 0)
get_teacher_type = get_index(TeacherTypes, 1)
get_course = get_index(Courses, 2)
get_class = get_index(Classes, 3)
get_class_course = get_index(ClassCourses, 4)
get_department = get_index(Departments, 5)
get_student = get_index(Students, 6)
get_student_course = get_index(StudentCourses, 7)
get_teacher = get_index(Teachers, 8)
get_teacher_course = get_index(TeacherCourses, 9)


if __name__ == '__main__':
    print(get_book())
    print(get_teacher_type())
    print(get_course())
    print(get_class())
    print(get_class_course())
    print(get_department())
    print(get_student())
    print(get_student_course())
    print(get_teacher())
    print(get_teacher_course())
