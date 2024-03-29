## 数据库实验第三次实验

Myriad Dreamin 2017211279 2017211301

## 实验目的

- 通过对实验二建立的数据库关系表和视图的各种查询的操作，加深对SQL语言和Transact
    SQL查询语言的了解，掌握相关查询语句的语法及使用方法。

## 实验平台及环境

- 系统: Ubuntu18.04 LTS
- 环境: Docker 18.09.7
- 数据库版本: Microsoft SQL Server 2017

## 实验内容

+ 简单的查询操作，包括单表的查询、选择条件、结果排序等的练习；

+ 多表的连接查询，包括等值连接、自然连接等；

+ 复杂的查询操作，包括使用分组等库函数的查询操作；

+ 练习带有IN、比较符的嵌套查询。

具体内容包括：

+ 简单查询:
    + 查询班号为“g9940206”班的学生的学号和姓名；
    + 查询“网络技术与实践”课程的周学时和学分；
    + 查询选修了课程编号为“dep04_s001”的学生的学号和成绩，并将成绩按降序输出；
    + 查询所有姓张的学生的信息；
    + 查询出生在1984年和1985年间的学生信息；
    + 查询1982年以后出生的女学生的学号、姓名、性别和出生日期，结果按年龄从小到大排序；
    + 显示所有学生的相关信息，并汇总学生总人数。

+ 在多表连接的查询实验中，在SQL　SERVER提供的交互式语言环境下用Transact SQL语句完成以下查询操作：
    + 查询选修了课程编号为“dep04_s002”且成绩高于85分的学生的学号、姓名和成绩；
    + 查询所有学生的学号、姓名、选修的课程名称和成绩；
    + 查询计算机科学系林红同学选修的课程名称、学分和成绩(考试成绩>＝60　有学分，否则无学分) 。

    + 查询每个教师的基本信息及教师类别；
    + 使用完全外联接查看StuSelDB数据库中每位教师的授课情况；

    + 查询选课程最多的学生由高到低排序；

    + 查询计算机工程系的教师授课课程的选修情况；
    + 查询严为老师和李红老师教授的同1门课程并列出课程名称；
    + 查询由严为老师授课而没有由李红老师授课的课程。
    + 查询至少选修了三门课程的学生的学号和姓名；
    + 查询选修课程号为“dep04_b001”的学生的平均成绩；
    + 查询所有学生的学号和其选修课程的最高成绩，要求他的选修课程中没有成绩为空的；

    + 查询严为老师2011/2012学年所授“软件开发技术”课程的最高成绩及此学生的学号、姓名、班级；
    + 查询数据库开发技术课程用过的教材名称，作者和出版社；
    + 查询计算机科学系讲授过“JAVA程序设计与开发”的老师姓名和职称。 

+ 在嵌套查询实验中，在SQL　SERVER提供的交互式语言环境下用Transact SQL语句完成以下查询操作，要求写嵌套查询语句：
    + 查询所有已获“副教授”职称的女教师的--姓名、性别、学历和职称；
    + 查询开设了课程ID为*的课程的教师的相关信息；

    + 查询选修了*号课程的学生学号、姓名和联系电话；

    + 查询课程考试不及格的学生的姓名、性别；
    + 查询网页设计课程不及格的学生姓名、性别和联系电话；
    + 查询选修了“计算机基础”的学生的学号和姓名；
    + 查询没有选修 “计算机基础”的学生的学号和姓名；
    + 查询至少选修了学号为“g9940201”的学生所选修的所有课程的学生的学号和姓名。

## 实验步骤

封装如下：

```python
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
```

利用该方式查询第一个结果集：

```python
from sql_func import wk
from sql_server import SqlServer


with SqlServer("student_source") as server:
    q = wk(server)
    q("""select id, name from student where class_id = 'g09402'""")
```

剩下29个查询也类似。最终结果如下：

#### 查询班号为“g9940206”班的学生的学号和姓名

怀疑是数据略微错误，修改为“g09402”后进行filter。

```sql
select id, name from student where class_id = 'g09402'
/*
+----------+----------+
|    id    |   name   |
+----------+----------+
| g0940201 |   张虹   |
| g0940202 |   林红   |
| g0940203 |   曹雨   |
| g0940204 |   芮华   |
| g0940205 | 李红[大] |
| g0940206 |  林海国  |
| g0940207 | 李红[小] |
| g0940210 |   赵青   |
| g0940211 |   赵凯   |
+----------+----------+
```

#### 查询“网络技术与实践”课程的周学时和学分

重点在于N，对于部分MS版本，需要添加N转`unicode`字符，否则中文会乱码。

```sql
select week_hour, credit from course where name = N'网络技术与实践'
/*
+-----------+--------+
| week_hour | credit |
+-----------+--------+
|     4     |   4    |
+-----------+--------+
```

#### 查询选修了课程编号为“dep04_s001”的学生的学号和成绩，并将成绩按降序输出

使用了`order by`关键字。

```sql
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
```

#### 查询所有姓张的学生的信息

用`%`通配符匹配后缀，SQL对`A%`形式的查询特别优化过，因此不用担心效率问题。

```sql
select * from student where name like N'张%' 
/*
+----------+--------+----------+--------+---------------------+---------------------+-----------------------+
|    id    |  name  | class_id | gender |        birth        |      created_at     |        address        |
+----------+--------+----------+--------+---------------------+---------------------+-----------------------+
| g0140105 |  张威  |  g01401  |   男   | 1992-01-11 00:00:00 | 2010-09-01 00:00:00 |    诸暨市高湖路65号   |
| g0940201 |  张虹  |  g09402  |   男   | 1991-09-12 00:00:00 | 2009-09-01 00:00:00 | 南京玄武区美玲大道4号 |
| g0940303 | 张雅丽 |  g09403  |   女   | 1990-01-21 00:00:00 | 2009-09-01 00:00:00 |  上海市北京东路191号  |
+----------+--------+----------+--------+---------------------+---------------------+-----------------------+
*/
```

#### 查询出生在1984年和1985年间的学生信息

怀疑是数据略微错误，修改为1994和1995以后进行查询。

另外如果查的是`between 1994 and 1995`，那么不会查到1995年1月1日以后的人。

```sql
select * from student where birth between '1994-01-01' and '1995-12-31' 
/*
+----------+--------+----------+--------+---------------------+---------------------+------------------+
|    id    |  name  | class_id | gender |        birth        |      created_at     |     address      |
+----------+--------+----------+--------+---------------------+---------------------+------------------+
| g0140201 | 王一言 |  g01402  |   男   | 1994-08-14 00:00:00 | 2010-09-01 00:00:00 | 深圳市华侨路78号 |
| g0240304 | 赵慧琳 |  g01403  |   女   | 1995-04-23 00:00:00 | 2012-09-01 00:00:00 | 镇江市静安路16号 |
| g0240403 | 吴珊珊 |  g01404  |   女   | 1994-03-26 00:00:00 | 2012-09-01 00:00:00 | 广州市体育路55号 |
+----------+--------+----------+--------+---------------------+---------------------+------------------+
*/
```

#### 查询1982年以后出生的女学生的学号、姓名、性别和出生日期，结果按年龄从小到大排序

怀疑是数据略微错误，修改为1992以后进行查询。

```sql
select id, name, gender, birth from student where gender = N'女' and birth > '1992' order by birth desc 
/*
+----------+--------+--------+---------------------+
|    id    |  name  | gender |        birth        |
+----------+--------+--------+---------------------+
| g0240304 | 赵慧琳 |   女   | 1995-04-23 00:00:00 |
| g0240403 | 吴珊珊 |   女   | 1994-03-26 00:00:00 |
| g0240402 | 赵莹莹 |   女   | 1993-05-25 00:00:00 |
| g0140104 | 叶梦宇 |   女   | 1992-03-10 00:00:00 |
+----------+--------+--------+---------------------+
```

#### 显示所有学生的相关信息，并汇总学生总人数

```sql
select * from student
/*
+----------+----------+----------+--------+---------------------+---------------------+-------------------------+
|    id    |   name   | class_id | gender |        birth        |      created_at     |         address         |
+----------+----------+----------+--------+---------------------+---------------------+-------------------------+
| g0140101 |  徐志超  |  g01401  |   男   | 1992-01-07 00:00:00 | 2010-09-01 00:00:00 |     杭州市余杭路12号    |
| g0140102 |  王志鹏  |  g01401  |   男   | 1992-10-08 00:00:00 | 2010-09-01 00:00:00 |     慈溪市中正路23号    |
| g0140103 |   李昊   |  g01401  |   男   | 1992-05-09 00:00:00 | 2010-09-01 00:00:00 |     南昌市起义路55号    |
| g0140104 |  叶梦宇  |  g01401  |   女   | 1992-03-10 00:00:00 | 2010-09-01 00:00:00 |    新昌市海棠路123号    |
| g0140105 |   张威   |  g01401  |   男   | 1992-01-11 00:00:00 | 2010-09-01 00:00:00 |     诸暨市高湖路65号    |
| g0140106 |  唐勇睿  |  g01401  |   男   | 1992-11-12 00:00:00 | 2010-09-01 00:00:00 |     北京市正义路2号     |
| g0140107 |   邓皓   |  g01401  |   男   | 1992-07-13 00:00:00 | 2010-09-01 00:00:00 |     邯郸市望江路24号    |
| g0140201 |  王一言  |  g01402  |   男   | 1994-08-14 00:00:00 | 2010-09-01 00:00:00 |     深圳市华侨路78号    |
| g0140204 |  徐江洪  |  g01402  |   男   | 1992-11-17 00:00:00 | 2010-09-01 00:00:00 |     高邮市樱花路22号    |
| g0140205 |  朱玺仲  |  g01402  |   男   | 1996-10-20 00:00:00 | 2010-09-01 00:00:00 |    扬州市望乡路156号    |
| g0240206 |  刘又嘉  |  g01402  |   男   | 1993-12-19 00:00:00 | 2012-09-01 00:00:00 |     上海市东风路12号    |
| g0240301 |  袁毓堃  |  g01403  |   男   | 1992-11-20 00:00:00 | 2012-09-01 00:00:00 |     上海市模范路4号     |
| g0240302 |  顾天飞  |  g01403  |   男   | 1992-12-21 00:00:00 | 2012-09-01 00:00:00 |     南京市下沙路88号    |
| g0240303 |   刘乐   |  g01403  |   男   | 1992-02-22 00:00:00 | 2012-09-01 00:00:00 |     常熟市后山路6号     |
| g0240304 |  赵慧琳  |  g01403  |   女   | 1995-04-23 00:00:00 | 2012-09-01 00:00:00 |     镇江市静安路16号    |
| g0240401 |  王晓庆  |  g01404  |   男   | 1993-09-24 00:00:00 | 2012-09-01 00:00:00 |     苏州市普陀路15号    |
| g0240402 |  赵莹莹  |  g01404  |   女   | 1993-05-25 00:00:00 | 2012-09-01 00:00:00 |     昆明市花市路77号    |
| g0240403 |  吴珊珊  |  g01404  |   女   | 1994-03-26 00:00:00 | 2012-09-01 00:00:00 |     广州市体育路55号    |
| g0940201 |   张虹   |  g09402  |   男   | 1991-09-12 00:00:00 | 2009-09-01 00:00:00 |  南京玄武区美玲大道4号  |
| g0940202 |   林红   |  g09402  |   女   | 1991-06-16 00:00:00 | 2009-09-01 00:00:00 |     扬州市五亭街41号    |
| g0940203 |   曹雨   |  g09402  |   男   | 1990-12-11 00:00:00 | 2009-09-01 00:00:00 |  南京玄武区林荫大道4号  |
| g0940204 |   芮华   |  g09402  |   男   | 1992-09-09 00:00:00 | 2009-09-01 00:00:00 |   江苏仪征市青年路6号   |
| g0940205 | 李红[大] |  g09402  |   女   | 1991-09-02 00:00:00 | 2009-09-01 00:00:00 |  江苏仪征市青年东路16号 |
| g0940206 |  林海国  |  g09402  |   男   | 1991-04-05 00:00:00 | 2009-09-01 00:00:00 | 北京市中关村太平北路1号 |
| g0940207 | 李红[小] |  g09402  |   女   | 1991-05-23 00:00:00 | 2009-09-01 00:00:00 |     南京虎踞北路43号    |
| g0940210 |   赵青   |  g09402  |   男   | 1990-01-09 00:00:00 | 2009-09-01 00:00:00 |     南京中山北路10号    |
| g0940211 |   赵凯   |  g09402  |   男   | 1992-01-11 00:00:00 | 2009-09-01 00:00:00 |     南京中山北路10号    |
| g0940301 |  左群声  |  g09403  |   男   | 1992-09-08 00:00:00 | 2009-09-01 00:00:00 |     贵州是遵义路68号    |
| g0940302 |  许小华  |  g09403  |   女   | 1991-10-15 00:00:00 | 2009-09-01 00:00:00 |     上海市龙盘路97号    |
| g0940303 |  张雅丽  |  g09403  |   女   | 1990-01-21 00:00:00 | 2009-09-01 00:00:00 |   上海市北京东路191号   |
+----------+----------+----------+--------+---------------------+---------------------+-------------------------+
*/
select count(1) from student
/*
+----+
|    |
+----+
| 30 |
+----+
*/
```

#### 查询选修了课程编号为“dep01_s002”且成绩高于85分的学生的学号、姓名和成绩

怀疑是数据略微错误，修改为dep04_s002以后进行查询。

```sql
select id, name, score from student_course left join student on student_id = id
        where course_id = 'dep04_s002' and score > 85 
/*
+----------+----------+-------+
|    id    |   name   | score |
+----------+----------+-------+
| g0940203 |   曹雨   |   98  |
| g0940207 | 李红[小] |   87  |
+----------+----------+-------+
*/
```

#### 查询所有学生的学号、姓名、选修的课程名称和成绩

`string_agg`是MS2017新增的聚合函数，这里仅方便查看结果，如果数据量大，应该直接返回数据集在宿主语言里继续操作。

```sql
select id, name,
        string_agg(course_id, ', ') as course_ids,
        string_agg(score, ', ') as score_ids
        from student left join student_course on student_id = id group by id, name
/*
+----------+----------+------------------------------------------------------------------------+------------------------+
|    id    |   name   |                               course_ids                               |       score_ids        |
+----------+----------+------------------------------------------------------------------------+------------------------+
| g0140101 |  徐志超  |                                  None                                  |          None          |
| g0140102 |  王志鹏  |                                  None                                  |          None          |
| g0140103 |   李昊   |                                  None                                  |          None          |
| g0140104 |  叶梦宇  |                                  None                                  |          None          |
| g0140105 |   张威   |                                  None                                  |          None          |
| g0140106 |  唐勇睿  |                                  None                                  |          None          |
| g0140107 |   邓皓   |                                  None                                  |          None          |
| g0140201 |  王一言  |                                  None                                  |          None          |
| g0140204 |  徐江洪  |                                  None                                  |          None          |
| g0140205 |  朱玺仲  |                                  None                                  |          None          |
| g0240206 |  刘又嘉  |                                  None                                  |          None          |
| g0240301 |  袁毓堃  |                                  None                                  |          None          |
| g0240302 |  顾天飞  |                                  None                                  |          None          |
| g0240303 |   刘乐   |                                  None                                  |          None          |
| g0240304 |  赵慧琳  |                                  None                                  |          None          |
| g0240401 |  王晓庆  |                                  None                                  |          None          |
| g0240402 |  赵莹莹  |                                  None                                  |          None          |
| g0240403 |  吴珊珊  |                                  None                                  |          None          |
| g0940201 |   张虹   | dep04_b001, dep04_s001, dep04_s002, dep04_s003, dep04_s004, dep04_s005 | 88, 89, 56, 68, 47, 87 |
| g0940202 |   林红   | dep04_b001, dep04_s001, dep04_s002, dep04_s003, dep04_s004, dep04_s005 | 78, 78, 78, 98, 95, 91 |
| g0940203 |   曹雨   | dep04_b001, dep04_s001, dep04_s002, dep04_s003, dep04_s004, dep04_s005 | 88, 44, 98, 23, 78, 56 |
| g0940204 |   芮华   | dep04_b001, dep04_s001, dep04_s002, dep04_s003, dep04_s004, dep04_s005 | 56, 65, 66, 86, 67, 77 |
| g0940205 | 李红[大] | dep04_b001, dep04_s001, dep04_s002, dep04_s003, dep04_s004, dep04_s005 | 45, 52, 78, 78, 76, 76 |
| g0940206 |  林海国  | dep04_b001, dep04_s001, dep04_s002, dep04_s003, dep04_s004, dep04_s006 | 98, 92, 54, 86, 76, 88 |
| g0940207 | 李红[小] | dep04_b001, dep04_s001, dep04_s002, dep04_s003, dep04_s004, dep04_s007 | 87, 77, 87, 87, 46, 99 |
| g0940210 |   赵青   |                                  None                                  |          None          |
| g0940211 |   赵凯   |                                  None                                  |          None          |
| g0940301 |  左群声  |                               dep04_s001                               |           78           |
| g0940302 |  许小华  |                               dep04_s001                               |           89           |
| g0940303 |  张雅丽  |                                  None                                  |          None          |
+----------+----------+------------------------------------------------------------------------+------------------------+
*/
```

#### 查询计算机科学系林红同学选修的课程名称、学分和成绩(考试成绩>＝60　有学分，否则无学分)

为了防止空值造成意外的结果，用isnull函数覆盖null返回值。

```sql
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
+------------+-----------------------------------------------------------------------------------------+---------------+-------------------+
| student_id |                                       course_name                                       | course_credit |    course_score   |
+------------+-----------------------------------------------------------------------------------------+---------------+-------------------+
|  g0940202  | 计算机基础,SQL Server数据库开发技术,JAVA程序设计与开发,单片机原理,软件开发技术,网页设计 |  4,5,4,4,3,5  | 78,78,78,98,95,91 |
+------------+-----------------------------------------------------------------------------------------+---------------+-------------------+
*/
```

#### 查询每个教师的基本信息及教师类别

```sql
select teacher.*, t_type from teacher left join teacher_type on teacher_type.id = teacher.cat
        
/*
+-----------+--------+--------+---------------------+---------+--------+-------------+------------------------+-----------+-----+--------+
|     id    |  name  | gender |        birth        | dept_id |  prof  |    phone    |        address         | post_code | cat | t_type |
+-----------+--------+--------+---------------------+---------+--------+-------------+------------------------+-----------+-----+--------+
| dep01_001 | 王敬远 |   男   | 1956-09-09 00:00:00 |  dep_01 | 副教授 |   6211544   |     南京先贤路31号     |   210002  |  1  |  专职  |
| dep01_002 |  马丽  |   女   | 1973-07-09 00:00:00 |  dep_01 | 副教授 |   65431235  |   南京古北青年路35号   |   210021  |  1  |  专职  |
| dep01_003 |  包维  |   女   | 1978-07-10 00:00:00 |  dep_01 | 副教授 |   65431246  |   南京鼓山新风路78号   |   210028  |  1  |  专职  |
| dep01_004 | 蒋晓英 |   女   | 1982-07-11 00:00:00 |  dep_01 |  讲师  |   5881254   |   南京河西总统路79号   |   215828  |  2  |  兼职  |
| dep01_005 |  黄翔  |   男   | 1988-01-12 00:00:00 |  dep_01 |  讲师  |   3728543   |   南京下沙环江路2号    |   214428  |  3  |  外聘  |
| dep01_025 | 周春桃 |   女   | 1989-06-01 00:00:00 |  dep_05 |  教授  |   40123456  | 云南省景洪市解放路61号 |   100102  |  2  |  兼职  |
| dep02_001 |  康辉  |   男   | 1949-08-06 00:00:00 |  dep_02 |  教授  | 13951606754 |  南京鼓楼区长虹路3号   |   210008  |  2  |  兼职  |
| dep02_002 |  王皓  |   男   | 1987-06-13 00:00:00 |  dep_02 |  讲师  |   3728643   |   南京下沙环江路45号   |   214428  |  3  |  外聘  |
| dep02_003 | 李丽华 |   女   | 1989-03-14 00:00:00 |  dep_02 |  讲师  |   7654987   |  南京鼓楼区高邮路2号   |   210012  |  2  |  兼职  |
| dep02_004 |  罗伟  |   男   | 1989-11-15 00:00:00 |  dep_02 |  讲师  |   7342122   | 南京西霞区长寿路102号  |   219912  |  2  |  兼职  |
| dep03_001 | 董一平 |   男   | 1968-01-01 00:00:00 |  dep_03 | 副教授 |   3728543   |     南京长江路9号      |   210036  |  1  |  专职  |
| dep03_002 |  潘惠  |   女   | 1966-04-01 00:00:00 |  dep_01 |  讲师  |   5887654   |     南京长江路5号      |   210036  |  1  |  专职  |
| dep04_001 |  纪云  |   男   | 1965-09-09 00:00:00 |  dep_04 | 副教授 |   6245321   |     南京长江路3号      |   210036  |  3  |  外聘  |
| dep04_002 |  章红  |   女   | 1970-07-04 00:00:00 |  dep_04 |  教授  | 13027816022 |    南京北京西路31号    |   210043  |  2  |  兼职  |
| dep04_003 |  李伟  |   男   | 1954-06-06 00:00:00 |  dep_04 |  教授  |   3728543   |     南京先贤路3号      |   210002  |  2  |  兼职  |
| dep04_004 |  严为  |   男   | 1978-09-01 00:00:00 |  dep_04 |  助教  |   7654987   |  南京鼓楼区长虹路3号   |   210002  |  2  |  兼职  |
| dep04_005 |  乔红  |   女   | 1969-05-31 00:00:00 |  dep_04 |  讲师  |   8802888   |   南京太州青年路3号    |   210071  |  3  |  外聘  |
+-----------+--------+--------+---------------------+---------+--------+-------------+------------------------+-----------+-----+--------+
*/
```

#### 使用完全外联接查看StuSelDB数据库中每位教师的授课情况

完全外连接对应的关键词为`full join`。

```sql
select teacher_id, teacher.id, name, course_id, class_id, sem, year,
        teacher_course.id as teacher_course_id, teacher_course.address, book_id
        from teacher full join teacher_course on teacher.id = teacher_id
/*
+------------+-----------+--------+------------+----------+------+-----------+-------------------+-----------+---------------+
| teacher_id |     id    |  name  | course_id  | class_id | sem  |    year   | teacher_course_id |  address  |    book_id    |
+------------+-----------+--------+------------+----------+------+-----------+-------------------+-----------+---------------+
| dep01_001  | dep01_001 | 王敬远 | dep01_s002 |  g09402  |  1   | 2009/2010 |     110310510     | 教学楼201 | dep01_s002_01 |
| dep01_001  | dep01_001 | 王敬远 | dep01_s002 |  g10402  |  1   | 2011/2012 |     120320520     | 教学楼202 | dep01_s002_01 |
|    None    | dep01_002 |  马丽  |    None    |   None   | None |    None   |        None       |    None   |      None     |
|    None    | dep01_003 |  包维  |    None    |   None   | None |    None   |        None       |    None   |      None     |
|    None    | dep01_004 | 蒋晓英 |    None    |   None   | None |    None   |        None       |    None   |      None     |
|    None    | dep01_005 |  黄翔  |    None    |   None   | None |    None   |        None       |    None   |      None     |
|    None    | dep01_025 | 周春桃 |    None    |   None   | None |    None   |        None       |    None   |      None     |
|    None    | dep02_001 |  康辉  |    None    |   None   | None |    None   |        None       |    None   |      None     |
|    None    | dep02_002 |  王皓  |    None    |   None   | None |    None   |        None       |    None   |      None     |
|    None    | dep02_003 | 李丽华 |    None    |   None   | None |    None   |        None       |    None   |      None     |
|    None    | dep02_004 |  罗伟  |    None    |   None   | None |    None   |        None       |    None   |      None     |
|    None    | dep03_001 | 董一平 |    None    |   None   | None |    None   |        None       |    None   |      None     |
|    None    | dep03_002 |  潘惠  |    None    |   None   | None |    None   |        None       |    None   |      None     |
| dep04_001  | dep04_001 |  纪云  | dep04_s001 |  g09402  |  1   | 2012/2013 |     110320512     | 教学楼601 | dep04_s001_01 |
| dep04_001  | dep04_001 |  纪云  | dep04_s005 |  g09402  |  2   | 2011/2012 |     130310511     | 教学楼602 | dep04_s005_01 |
| dep04_002  | dep04_002 |  章红  | dep04_p001 |  g09402  |  1   | 2009/2010 |     110320234     | 教学楼302 | dep04_p001_01 |
| dep04_002  | dep04_002 |  章红  | dep04_s002 |  g09402  |  1   | 2012/2013 |     210420321     | 教学楼601 | dep04_s002_01 |
| dep04_003  | dep04_003 |  李伟  | dep04_s003 |  g09402  |  1   | 2009/2010 |     110410231     | 教学楼212 | dep04_s003_01 |
| dep04_003  | dep04_003 |  李伟  | dep04_s004 |  g09403  |  1   | 2011/2012 |     120410132     | 教学楼211 | dep04_s004_01 |
| dep04_004  | dep04_004 |  严为  | dep04_b001 |  g09403  |  2   | 2011/2012 |     310520789     | 教学楼603 | dep04_b001_01 |
| dep04_004  | dep04_004 |  严为  | dep04_s004 |  g09402  |  1   | 2011/2012 |     220521897     | 教学楼211 | dep04_s004_01 |
| dep04_005  | dep04_005 |  乔红  | dep04_s001 |  g09403  |  1   | 2011/2012 |     210512456     | 教学楼212 | dep04_s001_01 |
+------------+-----------+--------+------------+----------+------+-----------+-------------------+-----------+---------------+
*/
```

#### 查询选课程最多的学生由高到低排序

要求没选课的同学也要被选中，所以应该用`left join`

```sql
select id, name,
        count(course_id) as course_count
        from student left join student_course on student_id = id group by id, name
        order by course_count desc
/*
+----------+----------+--------------+
|    id    |   name   | course_count |
+----------+----------+--------------+
| g0940201 |   张虹   |      6       |
| g0940202 |   林红   |      6       |
| g0940203 |   曹雨   |      6       |
| g0940204 |   芮华   |      6       |
| g0940205 | 李红[大] |      6       |
| g0940206 |  林海国  |      6       |
| g0940207 | 李红[小] |      6       |
| g0940301 |  左群声  |      1       |
| g0940302 |  许小华  |      1       |
| g0940303 |  张雅丽  |      0       |
| g0940210 |   赵青   |      0       |
| g0940211 |   赵凯   |      0       |
| g0140101 |  徐志超  |      0       |
| g0140102 |  王志鹏  |      0       |
| g0140103 |   李昊   |      0       |
| g0140104 |  叶梦宇  |      0       |
| g0140105 |   张威   |      0       |
| g0140106 |  唐勇睿  |      0       |
| g0140107 |   邓皓   |      0       |
| g0140201 |  王一言  |      0       |
| g0140204 |  徐江洪  |      0       |
| g0140205 |  朱玺仲  |      0       |
| g0240206 |  刘又嘉  |      0       |
| g0240301 |  袁毓堃  |      0       |
| g0240302 |  顾天飞  |      0       |
| g0240303 |   刘乐   |      0       |
| g0240304 |  赵慧琳  |      0       |
| g0240401 |  王晓庆  |      0       |
| g0240402 |  赵莹莹  |      0       |
| g0240403 |  吴珊珊  |      0       |
+----------+----------+--------------+
*/
```

#### 查询计算机工程系的教师授课课程的选修情况

```sql
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
```

#### 查询严为老师和李红老师教授的同1门课程并列出课程名称

因为没有李红老师，因此查了乔红老师。这里没有考虑是否有重名的纪云和乔红老师。

```sql
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
```

#### 查询由严为老师授课而没有由李红老师授课的课程

因为没有李红老师，因此查了乔红老师。

```sql
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
```

#### 查询至少选修了三门课程的学生的学号和姓名

`count`是分组聚集的结果，所以不能放在`where`中，应该放在`having`中。

```sql
select id, name
        from student left join student_course on student_id = id group by id, name
        having count(course_id) >= 3
/*
+----------+----------+
|    id    |   name   |
+----------+----------+
| g0940201 |   张虹   |
| g0940202 |   林红   |
| g0940203 |   曹雨   |
| g0940204 |   芮华   |
| g0940205 | 李红[大] |
| g0940206 |  林海国  |
| g0940207 | 李红[小] |
+----------+----------+
*/
```

#### 查询选修课程号为“dep04_b001”的学生的平均成绩

```sql
select avg(score) from student_course where course_id = 'dep04_b001'
/*
+----+
|    |
+----+
| 77 |
+----+
*/
```

#### 查询所有学生的学号和其选修课程的最高成绩，要求他的选修课程中没有成绩为空的

为了防止成绩为空，增加了一个`ifnull`判断。

```sql
select student.id, max(isnull(score, -1)) from
        student left join student_course on student.id = student_id
        group by student.id
/*
+----------+----+
|    id    |    |
+----------+----+
| g0140101 | -1 |
| g0140102 | -1 |
| g0140103 | -1 |
| g0140104 | -1 |
| g0140105 | -1 |
| g0140106 | -1 |
| g0140107 | -1 |
| g0140201 | -1 |
| g0140204 | -1 |
| g0140205 | -1 |
| g0240206 | -1 |
| g0240301 | -1 |
| g0240302 | -1 |
| g0240303 | -1 |
| g0240304 | -1 |
| g0240401 | -1 |
| g0240402 | -1 |
| g0240403 | -1 |
| g0940201 | 89 |
| g0940202 | 98 |
| g0940203 | 98 |
| g0940204 | 86 |
| g0940205 | 78 |
| g0940206 | 98 |
| g0940207 | 99 |
| g0940210 | -1 |
| g0940211 | -1 |
| g0940301 | 78 |
| g0940302 | 89 |
| g0940303 | -1 |
+----------+----+
*/
```

#### 查询严为老师2011/2012学年所授“软件开发技术”课程的最高成绩及此学生的学号、姓名、班级

```sql
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
| dep04_s004 |    95    |  g0940202  | 林红 |  g09402  |
+------------+----------+------------+------+----------+
*/
```

#### 查询数据库开发技术课程用过的教材名称，作者和出版社

```sql
select course.name, book.name as book_name, author, publish
    from course left join book on book_id = book.id where course.name = N'SQL Server数据库开发技术'
/*
+--------------------------+--------------------------+--------+--------------------+
|           name           |        book_name         | author |      publish       |
+--------------------------+--------------------------+--------+--------------------+
| SQL Server数据库开发技术 | SQL Server数据库开发技术 |  成虎  | 北方交通大学出版社 |
+--------------------------+--------------------------+--------+--------------------+
*/
```

#### 查询计算机科学系讲授过“JAVA程序设计与开发”的老师姓名和职称

```sql
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
```

#### 查询所有已获“副教授”职称的女教师的--姓名、性别、学历和职称

```sql
select name, gender from teacher where id in (select id from teacher where gender=N'女' and prof = N'副教授')
/*
+------+--------+
| name | gender |
+------+--------+
| 马丽 |   女   |
| 包维 |   女   |
+------+--------+
*/
```

#### 查询开设了课程ID为*的课程的教师的相关信息

```sql
select * from teacher where id in (select teacher_id from teacher_course where course_id = 'dep01_s002')
/*
+-----------+--------+--------+---------------------+---------+--------+---------+----------------+-----------+-----+
|     id    |  name  | gender |        birth        | dept_id |  prof  |  phone  |    address     | post_code | cat |
+-----------+--------+--------+---------------------+---------+--------+---------+----------------+-----------+-----+
| dep01_001 | 王敬远 |   男   | 1956-09-09 00:00:00 |  dep_01 | 副教授 | 6211544 | 南京先贤路31号 |   210002  |  1  |
+-----------+--------+--------+---------------------+---------+--------+---------+----------------+-----------+-----+
*/
```

#### 查询选修了*号课程的学生学号、姓名和联系电话

```sql
select id, name from student where id in (select student_id from student_course where course_id = 'dep04_s002')
/*
+----------+----------+
|    id    |   name   |
+----------+----------+
| g0940201 |   张虹   |
| g0940202 |   林红   |
| g0940203 |   曹雨   |
| g0940204 |   芮华   |
| g0940205 | 李红[大] |
| g0940206 |  林海国  |
| g0940207 | 李红[小] |
+----------+----------+
*/
```

#### 查询课程考试不及格的学生的姓名、性别

```sql
select id, name from student where id in (select distinct student_id from student_course where score < 60)
/*
+----------+----------+
|    id    |   name   |
+----------+----------+
| g0940201 |   张虹   |
| g0940203 |   曹雨   |
| g0940204 |   芮华   |
| g0940205 | 李红[大] |
| g0940206 |  林海国  |
| g0940207 | 李红[小] |
+----------+----------+
*/
```

#### 查询网页设计课程不及格的学生姓名、性别和联系电话

```sql
select name, gender, address from student where id in (
select distinct student_id from student_course
where score < 60 and course_id = (select id from course where name=N'网页设计'))
/*
+------+--------+-----------------------+
| name | gender |        address        |
+------+--------+-----------------------+
| 曹雨 |   男   | 南京玄武区林荫大道4号 |
+------+--------+-----------------------+
*/
```

#### 查询选修了“计算机基础”的学生的学号和姓名

```sql
select id, name from student where id in (
select distinct student_id from student_course
where course_id = (select id from course where name=N'计算机基础'))
/*
+----------+----------+
|    id    |   name   |
+----------+----------+
| g0940201 |   张虹   |
| g0940202 |   林红   |
| g0940203 |   曹雨   |
| g0940204 |   芮华   |
| g0940205 | 李红[大] |
| g0940206 |  林海国  |
| g0940207 | 李红[小] |
+----------+----------+
*/
```

#### 查询没有选修 “计算机基础”的学生的学号和姓名

```sql
select id, name from student where id not in (
select distinct student_id from student_course
where course_id = (select id from course where name=N'计算机基础'))
/*
+----------+--------+
|    id    |  name  |
+----------+--------+
| g0140101 | 徐志超 |
| g0140102 | 王志鹏 |
| g0140103 |  李昊  |
| g0140104 | 叶梦宇 |
| g0140105 |  张威  |
| g0140106 | 唐勇睿 |
| g0140107 |  邓皓  |
| g0140201 | 王一言 |
| g0140204 | 徐江洪 |
| g0140205 | 朱玺仲 |
| g0240206 | 刘又嘉 |
| g0240301 | 袁毓堃 |
| g0240302 | 顾天飞 |
| g0240303 |  刘乐  |
| g0240304 | 赵慧琳 |
| g0240401 | 王晓庆 |
| g0240402 | 赵莹莹 |
| g0240403 | 吴珊珊 |
| g0940210 |  赵青  |
| g0940211 |  赵凯  |
| g0940301 | 左群声 |
| g0940302 | 许小华 |
| g0940303 | 张雅丽 |
+----------+--------+
*/
```

#### 查询至少选修了学号为“g9940201”的学生所选修的所有课程的学生的学号和姓名

```sql
select id, name from
student where not exists 
((select course_id from student_course where student_id = 'g0940201') except
    (select course_id from student_course where student_id = student.id))

/*
+----------+----------+
|    id    |   name   |
+----------+----------+
| g0940201 |   张虹   |
| g0940202 |   林红   |
| g0940203 |   曹雨   |
| g0940204 |   芮华   |
| g0940205 | 李红[大] |
+----------+----------+
*/
```

## 实验小结

在此次实验中，大多数是基础实验，没有什么技术含量。但每一个都认真做，认真考虑SQL语句是否与设计需求一致，不要因为马虎遗留下SQL漏洞和查询Bug。

