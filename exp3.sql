select id, name from student where class_id = 'g09402'
/*
+----+------+
| id | name |
+----+------+
+----+------+
*/
select week_hour, credit from course where name = N'网络技术与实践'
/*
+-----------+--------+
| week_hour | credit |
+-----------+--------+
|     4     |   4    |
+-----------+--------+
*/
select student_id, score from student_course where course_id = 'dep04_s001' order by score desc 
/*
+------------+-------+
| student_id | score |
+------------+-------+
|  g0940206  |   92  |
|  g0940302  |   89  |
|  g0940201  |   89  |
|  g0940202  |   78  |
|  g0940301  |   78  |
|  g0940207  |   77  |
|  g0940204  |   65  |
|  g0940205  |   52  |
|  g0940203  |   44  |
+------------+-------+
*/
select * from student where name like N'张%' 
/*
+----+------+----------+--------+-------+------------+---------+
| id | name | class_id | gender | birth | created_at | address |
+----+------+----------+--------+-------+------------+---------+
+----+------+----------+--------+-------+------------+---------+
*/
select * from student where birth between '1994-01-01' and '1995-12-31' 
/*
+----+------+----------+--------+-------+------------+---------+
| id | name | class_id | gender | birth | created_at | address |
+----+------+----------+--------+-------+------------+---------+
+----+------+----------+--------+-------+------------+---------+
*/
select id, name, gender, birth from student where gender = N'女' and birth > '1992' order by birth desc 
/*
+----+------+--------+-------+
| id | name | gender | birth |
+----+------+--------+-------+
+----+------+--------+-------+
*/
select * from student
/*
+----+------+----------+--------+-------+------------+---------+
| id | name | class_id | gender | birth | created_at | address |
+----+------+----------+--------+-------+------------+---------+
+----+------+----------+--------+-------+------------+---------+
*/
select count(1) from student
/*
+---+
|   |
+---+
| 0 |
+---+
*/
select id, name, score from student_course left join student on student_id = id
        where course_id = 'dep04_s002' and score > 85 
/*
+------+------+-------+
|  id  | name | score |
+------+------+-------+
| None | None |   98  |
| None | None |   87  |
+------+------+-------+
*/
select id, name,
        string_agg(course_id, ', ') as course_ids,
        string_agg(score, ', ') as score_ids
        from student left join student_course on student_id = id group by id, name
/*
+----+------+------------+-----------+
| id | name | course_ids | score_ids |
+----+------+------------+-----------+
+----+------+------------+-----------+
*/
select student_id, string_agg(course.name, ',') as course_name, 
        string_agg((case when student_course.score >= 60 then student_course.credit else 0 end), ',') as course_credit,
        string_agg(student_course.score, ',') as course_score from student left join (
            student_course left join course on course_id = course.id
        ) on student_id = student.id where student.name = N'林红'
        and student_id in (
            select student.id from student left join class on class_id = class.id
             where class.dept_id = isnull((select id from department where name=N'计算机科学'), 'dep_-1')
        ) group by student_id 
/*
+------------+-------------+---------------+--------------+
| student_id | course_name | course_credit | course_score |
+------------+-------------+---------------+--------------+
+------------+-------------+---------------+--------------+
*/
select teacher.id, name, gender, birth, dept_id, prof, phone, address, post_code, t_type from teacher inner join teacher_type on teacher_type.id = teacher.cat
        
/*
+-----------+--------+--------+---------------------+---------+--------+-------------+------------------------+-----------+--------+
|     id    |  name  | gender |        birth        | dept_id |  prof  |    phone    |        address         | post_code | t_type |
+-----------+--------+--------+---------------------+---------+--------+-------------+------------------------+-----------+--------+
| dep01_001 | 王敬远 |   男   | 1956-09-09 00:00:00 |  dep_01 | 副教授 |   6211544   |     南京先贤路31号     |   210002  |  专职  |
| dep01_002 |  马丽  |   女   | 1973-07-09 00:00:00 |  dep_01 | 副教授 |   65431235  |   南京古北青年路35号   |   210021  |  专职  |
| dep01_003 |  包维  |   女   | 1978-07-10 00:00:00 |  dep_01 | 副教授 |   65431246  |   南京鼓山新风路78号   |   210028  |  专职  |
| dep01_004 | 蒋晓英 |   女   | 1982-07-11 00:00:00 |  dep_01 |  讲师  |   5881254   |   南京河西总统路79号   |   215828  |  兼职  |
| dep01_005 |  黄翔  |   男   | 1988-01-12 00:00:00 |  dep_01 |  讲师  |   3728543   |   南京下沙环江路2号    |   214428  |  外聘  |
| dep01_025 | 周春桃 |   女   | 1989-06-01 00:00:00 |  dep_05 |  教授  |   40123456  | 云南省景洪市解放路61号 |   100102  |  兼职  |
| dep02_001 |  康辉  |   男   | 1949-08-06 00:00:00 |  dep_02 |  教授  | 13951606754 |  南京鼓楼区长虹路3号   |   210008  |  兼职  |
| dep02_002 |  王皓  |   男   | 1987-06-13 00:00:00 |  dep_02 |  讲师  |   3728643   |   南京下沙环江路45号   |   214428  |  外聘  |
| dep02_003 | 李丽华 |   女   | 1989-03-14 00:00:00 |  dep_02 |  讲师  |   7654987   |  南京鼓楼区高邮路2号   |   210012  |  兼职  |
| dep02_004 |  罗伟  |   男   | 1989-11-15 00:00:00 |  dep_02 |  讲师  |   7342122   | 南京西霞区长寿路102号  |   219912  |  兼职  |
| dep03_001 | 董一平 |   男   | 1968-01-01 00:00:00 |  dep_03 | 副教授 |   3728543   |     南京长江路9号      |   210036  |  专职  |
| dep03_002 |  潘惠  |   女   | 1966-04-01 00:00:00 |  dep_01 |  讲师  |   5887654   |     南京长江路5号      |   210036  |  专职  |
| dep04_001 |  纪云  |   男   | 1965-09-09 00:00:00 |  dep_04 | 副教授 |   6245321   |     南京长江路3号      |   210036  |  外聘  |
| dep04_002 |  章红  |   女   | 1970-07-04 00:00:00 |  dep_04 |  教授  | 13027816022 |    南京北京西路31号    |   210043  |  兼职  |
| dep04_003 |  李伟  |   男   | 1954-06-06 00:00:00 |  dep_04 |  教授  |   3728543   |     南京先贤路3号      |   210002  |  兼职  |
| dep04_004 |  严为  |   男   | 1978-09-01 00:00:00 |  dep_04 |  助教  |   7654987   |  南京鼓楼区长虹路3号   |   210002  |  兼职  |
| dep04_005 |  乔红  |   女   | 1969-05-31 00:00:00 |  dep_04 |  讲师  |   8802888   |   南京太州青年路3号    |   210071  |  外聘  |
+-----------+--------+--------+---------------------+---------+--------+-------------+------------------------+-----------+--------+
*/
select teacher_id, teacher.id, name, course_id, class_id, sem, year,
        teacher_course.id as teacher_course_id, teacher_course.address, book_id
        from teacher join teacher_course on teacher.id = teacher_id
/*
+------------+-----------+--------+------------+----------+-----+-----------+-------------------+-----------+---------------+
| teacher_id |     id    |  name  | course_id  | class_id | sem |    year   | teacher_course_id |  address  |    book_id    |
+------------+-----------+--------+------------+----------+-----+-----------+-------------------+-----------+---------------+
| dep01_001  | dep01_001 | 王敬远 | dep01_s002 |  g09402  |  1  | 2009/2010 |     110310510     | 教学楼201 | dep01_s002_01 |
| dep01_001  | dep01_001 | 王敬远 | dep01_s002 |  g10402  |  1  | 2011/2012 |     120320520     | 教学楼202 | dep01_s002_01 |
| dep04_001  | dep04_001 |  纪云  | dep04_s001 |  g09402  |  1  | 2012/2013 |     110320512     | 教学楼601 | dep04_s001_01 |
| dep04_001  | dep04_001 |  纪云  | dep04_s005 |  g09402  |  2  | 2011/2012 |     130310511     | 教学楼602 | dep04_s005_01 |
| dep04_002  | dep04_002 |  章红  | dep04_p001 |  g09402  |  1  | 2009/2010 |     110320234     | 教学楼302 | dep04_p001_01 |
| dep04_002  | dep04_002 |  章红  | dep04_s002 |  g09402  |  1  | 2012/2013 |     210420321     | 教学楼601 | dep04_s002_01 |
| dep04_003  | dep04_003 |  李伟  | dep04_s003 |  g09402  |  1  | 2009/2010 |     110410231     | 教学楼212 | dep04_s003_01 |
| dep04_003  | dep04_003 |  李伟  | dep04_s004 |  g09403  |  1  | 2011/2012 |     120410132     | 教学楼211 | dep04_s004_01 |
| dep04_004  | dep04_004 |  严为  | dep04_b001 |  g09403  |  2  | 2011/2012 |     310520789     | 教学楼603 | dep04_b001_01 |
| dep04_004  | dep04_004 |  严为  | dep04_s004 |  g09402  |  1  | 2011/2012 |     220521897     | 教学楼211 | dep04_s004_01 |
| dep04_005  | dep04_005 |  乔红  | dep04_s001 |  g09403  |  1  | 2011/2012 |     210512456     | 教学楼212 | dep04_s001_01 |
+------------+-----------+--------+------------+----------+-----+-----------+-------------------+-----------+---------------+
*/
select id, name,
        count(course_id) as course_count
        from student left join student_course on student_id = id group by id, name
        order by course_count desc
/*
+----+------+--------------+
| id | name | course_count |
+----+------+--------------+
+----+------+--------------+
*/

    select teacher_id, teacher_course.course_id, string_agg(student_id, ',') as student_ids
        from teacher_course left join student_course on teacher_course.course_id = student_course.course_id
        where teacher_id in (
            select id from teacher where dept_id = isnull((select id from department where name=N'计算机科学'), 'dep_-1')
        )
        group by teacher_id, teacher_course.course_id
    
/*
+------------+------------+----------------------------------------------------------------------------------+
| teacher_id | course_id  |                                   student_ids                                    |
+------------+------------+----------------------------------------------------------------------------------+
| dep04_001  | dep04_s001 | g0940201,g0940202,g0940203,g0940204,g0940205,g0940206,g0940207,g0940301,g0940302 |
| dep04_001  | dep04_s005 |                   g0940201,g0940202,g0940203,g0940204,g0940205                   |
| dep04_002  | dep04_p001 |                                       None                                       |
| dep04_002  | dep04_s002 |          g0940201,g0940202,g0940203,g0940204,g0940205,g0940206,g0940207          |
| dep04_003  | dep04_s003 |          g0940201,g0940202,g0940203,g0940204,g0940205,g0940206,g0940207          |
| dep04_003  | dep04_s004 |          g0940201,g0940202,g0940203,g0940204,g0940205,g0940206,g0940207          |
| dep04_004  | dep04_b001 |          g0940201,g0940202,g0940203,g0940204,g0940205,g0940206,g0940207          |
| dep04_004  | dep04_s004 |          g0940201,g0940202,g0940203,g0940204,g0940205,g0940206,g0940207          |
| dep04_005  | dep04_s001 | g0940201,g0940202,g0940203,g0940204,g0940205,g0940206,g0940207,g0940301,g0940302 |
+------------+------------+----------------------------------------------------------------------------------+
*/

    select id, name from 
    ((select course_id from teacher left join teacher_course on
        teacher.id = teacher_course.teacher_id
      where teacher.name = N'纪云') intersect
    (select course_id from teacher left join teacher_course on
        teacher.id = teacher_course.teacher_id
      where teacher.name = N'乔红')) as cmn left join course on id = course_id
    
/*
+------------+--------------------------+
|     id     |           name           |
+------------+--------------------------+
| dep04_s001 | SQL Server数据库开发技术 |
+------------+--------------------------+
*/

    select course.* from 
    ((select course_id from teacher left join teacher_course on
        teacher.id = teacher_course.teacher_id
      where teacher.name = N'严为') except
    (select course_id from teacher left join teacher_course on
        teacher.id = teacher_course.teacher_id
      where teacher.name = N'乔红')) as cmn left join course on id = course_id
    
/*
+------------+--------------+---------------+------------+-----------+--------+
|     id     |     name     |    book_id    | total_hour | week_hour | credit |
+------------+--------------+---------------+------------+-----------+--------+
| dep04_b001 |  计算机基础  | dep04_b001_01 |     68     |     4     |   4    |
| dep04_s004 | 软件开发技术 | dep04_s004_01 |     51     |     3     |   3    |
+------------+--------------+---------------+------------+-----------+--------+
*/
select id, name
        from student left join student_course on student_id = id group by id, name
        having count(course_id) >= 3
/*
+----+------+
| id | name |
+----+------+
+----+------+
*/
select avg(score) from student_course where course_id = 'dep04_b001'
/*
+----+
|    |
+----+
| 77 |
+----+
*/
select student.id, max(isnull(score, -1)) from
        student left join student_course on student.id = student_id
        group by student.id
/*
+----+--+
| id |  |
+----+--+
+----+--+
*/

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
    
/*
+------------+----------+------------+------+----------+
| course_id  | mx_score | student_id | name | class_id |
+------------+----------+------------+------+----------+
| dep04_s004 |    95    |  g0940202  | None |   None   |
+------------+----------+------------+------+----------+
*/

    select course.name, book.name as book_name, author, publish
     from course left join book on book_id = book.id where course.name = N'SQL Server数据库开发技术'
/*
+--------------------------+--------------------------+--------+--------------------+
|           name           |        book_name         | author |      publish       |
+--------------------------+--------------------------+--------+--------------------+
| SQL Server数据库开发技术 | SQL Server数据库开发技术 |  成虎  | 北方交通大学出版社 |
+--------------------------+--------------------------+--------+--------------------+
*/

    select name, prof from
        (select teacher_id, course_id
            from teacher_course
        where teacher_id in (
            select id from teacher where dept_id = isnull((select id from department where name=N'计算机科学'), 'dep_-1')
        )
        and course_id = (select id from course where name=N'JAVA程序设计与开发')) as scs_java_teachers
        left join teacher on teacher_id = id
    
/*
+------+------+
| name | prof |
+------+------+
| 章红 | 教授 |
+------+------+
*/

    select name, gender from teacher where id in (select id from teacher where gender=N'女' and prof = N'副教授')
/*
+------+--------+
| name | gender |
+------+--------+
| 马丽 |   女   |
| 包维 |   女   |
+------+--------+
*/

    select * from teacher where id in (select teacher_id from teacher_course where course_id = 'dep01_s002')
/*
+-----------+--------+--------+---------------------+---------+--------+---------+----------------+-----------+-----+
|     id    |  name  | gender |        birth        | dept_id |  prof  |  phone  |    address     | post_code | cat |
+-----------+--------+--------+---------------------+---------+--------+---------+----------------+-----------+-----+
| dep01_001 | 王敬远 |   男   | 1956-09-09 00:00:00 |  dep_01 | 副教授 | 6211544 | 南京先贤路31号 |   210002  |  1  |
+-----------+--------+--------+---------------------+---------+--------+---------+----------------+-----------+-----+
*/

    select id, name from student where id in (select student_id from student_course where course_id = 'dep04_s002')
/*
+----+------+
| id | name |
+----+------+
+----+------+
*/

        select id, name from student where id in (select distinct student_id from student_course where score < 60)
/*
+----+------+
| id | name |
+----+------+
+----+------+
*/

        select name, gender, address from student where id in (
        select distinct student_id from student_course
        where score < 60 and course_id = (select id from course where name=N'网页设计'))
/*
+------+--------+---------+
| name | gender | address |
+------+--------+---------+
+------+--------+---------+
*/

    select id, name from student where id in (
    select distinct student_id from student_course
    where course_id = (select id from course where name=N'计算机基础'))
/*
+----+------+
| id | name |
+----+------+
+----+------+
*/

    select id, name from student where id not in (
    select distinct student_id from student_course
    where course_id = (select id from course where name=N'计算机基础'))
/*
+----+------+
| id | name |
+----+------+
+----+------+
*/

    select id, name from
    student where not exists 
    ((select course_id from student_course where student_id = 'g0940201') except
     (select course_id from student_course where student_id = student.id))
    
/*
+----+------+
| id | name |
+----+------+
+----+------+
*/
