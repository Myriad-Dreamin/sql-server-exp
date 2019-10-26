from prettytable import from_db_cursor
from sql_server import SqlServer


def wk(db):
    def res(statement):
        print(statement)
        cursor = db.query_cursor(statement)
        while True:
            print(from_db_cursor(cursor))
            if not cursor.nextset():
                break
    return res


with SqlServer("student_source") as server:
    q = wk(server)
    q("""select id, name from student where class_id = 'g09402'""")
    q("""select week_hour, credit from course where name = N'网络技术与实践'""")
    q("""select student_id, score from student_course where course_id = 'dep04_s001' order by score desc """)
    q("""select * from student where name like N'张%' """)
    q("""select * from student where birth between '1994-01-01' and '1995-12-31' """)
    q("""select id, name, gender, birth from student where gender = N'女' and birth > '1992' order by birth desc """)
    q("""select * from student""")
    q("""select count(1) from student""")
    q("""select id, name, score from student_course left join student on student_id = id
        where course_id = 'dep04_s002' and score > 85 """)
    q("""select id, name,
        string_agg(course_id, ', ') as course_ids,
        string_agg(score, ', ') as score_ids
        from student left join student_course on student_id = id group by id, name""")

    q("""select student_id, string_agg(course.name, ',') as course_name, 
        string_agg((case when student_course.score >= 60 then student_course.credit else 0 end), ',') as course_credit,
        string_agg(student_course.score, ',') as course_score from student left join (
            student_course left join course on course_id = course.id
        ) on student_id = student.id where student.name = N'林红'
        and student_id in (
            select student.id from student left join class on class_id = class.id
             where class.dept_id = isnull((select id from department where name=N'计算机科学'), 'dep_-1')
        ) group by student_id """)

    q("""select teacher.id, name, gender, birth, dept_id, prof, phone, address, post_code, t_type from teacher inner join teacher_type on teacher_type.id = teacher.cat
        """)

    # q("""select student_course.course_id, student_id, score, credit,  from student_course inner join teacher_course
    #     on student_course.course_id = teacher_course.course_id""")

    q("""select teacher_id, teacher.id, name, course_id, class_id, sem, year,
        teacher_course.id as teacher_course_id, teacher_course.address, book_id
        from teacher join teacher_course on teacher.id = teacher_id""")

    q("""select id, name,
        count(course_id) as course_count
        from student left join student_course on student_id = id group by id, name
        order by course_count desc""")

    q("""
    select teacher_id, teacher_course.course_id, string_agg(student_id, ',') as student_ids
        from teacher_course left join student_course on teacher_course.course_id = student_course.course_id
        where teacher_id in (
            select id from teacher where dept_id = isnull((select id from department where name=N'计算机科学'), 'dep_-1')
        )
        group by teacher_id, teacher_course.course_id
    """)

    q("""
    select id, name from 
    ((select course_id from teacher left join teacher_course on
        teacher.id = teacher_course.teacher_id
      where teacher.name = N'纪云') intersect
    (select course_id from teacher left join teacher_course on
        teacher.id = teacher_course.teacher_id
      where teacher.name = N'乔红')) as cmn left join course on id = course_id
    """)

    q("""
    select course.* from 
    ((select course_id from teacher left join teacher_course on
        teacher.id = teacher_course.teacher_id
      where teacher.name = N'严为') except
    (select course_id from teacher left join teacher_course on
        teacher.id = teacher_course.teacher_id
      where teacher.name = N'乔红')) as cmn left join course on id = course_id
    """)

    q("""select id, name
        from student left join student_course on student_id = id group by id, name
        having count(course_id) >= 3""")

    q("""select avg(score) from student_course where course_id = 'dep04_b001'""")

    q("""select student.id, max(isnull(score, -1)) from
        student left join student_course on student.id = student_id
        group by student.id""")

    q("""
    select yw2011_2012_st_mx_stu.*, name, class_id from
    (select course_id, mx_score, student_id from
        (select yw2011_2012_st.id, max(score) as mx_score from
            (select course.id from
                (select teacher_course.* from
                    teacher left join teacher_course on teacher.id = teacher_id
                where teacher.name = N'严为' and year = '2011/2012') as yw2011_2012
            inner join 
            course on course_id = course.id where name = N'软件开发技术') as yw2011_2012_st
        left join
        student_course on yw2011_2012_st.id = course_id group by id
        ) as yw2011_2012_st_mx_score left join student_course on 
            id = course_id and mx_score = score
    ) as yw2011_2012_st_mx_stu left join student on student_id = id
    """)

    q("""
    select course.name, book.name as book_name, author, publish
     from course left join book on book_id = book.id where course.name = N'SQL Server数据库开发技术'""")

    # 判断java为空
    q("""
    select name, prof from
        (select teacher_id, course_id
            from teacher_course
        where teacher_id in (
            select id from teacher where dept_id = isnull((select id from department where name=N'计算机科学'), 'dep_-1')
        )
        and course_id = (select id from course where name=N'JAVA程序设计与开发')) as scs_java_teachers
        left join teacher on teacher_id = id
    """)

    q("""
    select name, gender from teacher where id in (select id from teacher where gender=N'女' and prof = N'副教授')""")

    q("""
    select * from teacher where id in (select teacher_id from teacher_course where course_id = 'dep01_s002')""")

    # dep04_s002, dep01_s002
    q("""
    select id, name from student where id in (select student_id from student_course where course_id = 'dep04_s002')""")

    q("""
        select id, name from student where id in (select distinct student_id from student_course where score < 60)""")

    q("""
        select name, gender, address from student where id in (
        select distinct student_id from student_course
        where score < 60 and course_id = (select id from course where name=N'网页设计'))""")

    q("""
    select id, name from student where id in (
    select distinct student_id from student_course
    where course_id = (select id from course where name=N'计算机基础'))""")

    q("""
    select id, name from student where id not in (
    select distinct student_id from student_course
    where course_id = (select id from course where name=N'计算机基础'))""")

    q("""
    select id, name from
    student where not exists 
    ((select course_id from student_course where student_id = 'g0940201') except
     (select course_id from student_course where student_id = student.id))
    """)

