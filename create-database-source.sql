CREATE DATABASE student_source
ON PRIMARY
(
    NAME='stu_main',
    FILENAME='/home/sql/main.mdf',
    SIZE=3MB,
    MAXSIZE=unlimited,
    FILEGROWTH=1MB
),
FILEGROUP Course1
(
    NAME = 'course_1',
    FILENAME='/home/sql/c1.ndf',
    SIZE=3MB,
    MAXSIZE=unlimited,
    FILEGROWTH=1MB
),
FILEGROUP Course2
(
    NAME = 'course_2',
    FILENAME='/home/sql/c2.ndf',
    SIZE=3MB,
    MAXSIZE=unlimited,
    FILEGROWTH=1MB
)
LOG ON
(
    NAME = 'logger',
    FILENAME='/home/sql/c2.ldf',
    SIZE=3MB,
    MAXSIZE=1GB,
    FILEGROWTH=10%
)
