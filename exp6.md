## 数据库实验第六次实验 - 存储过程与触发器的创建实验

Myriad Dreamin 2017211279 2017211301

## 实验目的

+ 熟悉并掌握SQL SERVER中存储过程和触发器的概念。
+ 通过SQL SERVER管理平台和Transact-SQL语句创建存储过程和触发器的方法和
步骤。
+ 掌握存储过程和触发器的执行方法。
+ 掌握存储过程和触发器的删除方法。

## 实验平台及环境

- 系统: Ubuntu18.04 LTS
- 环境: Docker 18.09.7
- 数据库版本: Microsoft SQL Server 2017

## 实验内容
+ 存储过程：
	+ 定义存储过程，查询“学生”表中学号=g0940211的学生的姓名和已选课程门数，若选课门数在3门以上，输出“XX，已经完成了选课”；否则输出“XX，还需选课”。 
	+ 定义存储过程，用于查询“学生选课”数据库中所有教师的姓名、性别、职称和所授课的课程名称。
	+ 修改存储过程
		+ 修改存储过程dbo.ShowTeaCourse,用于查询“学生选课”数据库中所有副教授职称的教师的姓名、性别、职称和所授课的课程名称。
	+ 删除该存储过程。
+ 触发器:
	+ 创建INSERT触发器，如果向教师表中插入记录时，检查该记录的院系编号在表中是否存在。如果不存在，则不允许插入。
		
		+ 测试
	+ 创建UPDATEClass触发器，当对班级信息表主键"班级号"进行修改时，应对学生表中相应的"班级号"也进行修改。
	+ 定义触发器，向学生表插入一条记录时，将所有学生的学号值加1，并对其进行测试。
	
	​    

## 实验步骤

#### 编写实验脚本

完整的实验脚本如下：

```python
    with SqlServer(database_name, auto_commit=True) as server:
        q = wk(server)
        server.drop_procedure("sel_course_check")
        with open('sel_course_check.sql', encoding='utf-8') as f:
            proc = f.read()
        server.just_exec(proc)
        q("""execute sel_course_check 'g0940211'""")

        server.drop_procedure("show_tea")
        with open('show_tea.sql', encoding='utf-8') as f:
            proc = f.read()
        server.just_exec(proc)
        q("""execute show_tea""")

        with open('alter_show_tea.sql', encoding='utf-8') as f:
            proc = f.read()
        server.just_exec(proc)
        q("""execute show_tea""")

        # 删除存储过程

        server.drop_trigger("check_teachers_dept_id")
        with open('check_teachers_dept_id.sql', encoding='utf-8') as f:
            trigger = f.read()
        server.just_exec(trigger)
        # q("""execute show_tea""")

        try:
            server.just_exec("""insert into teacher(id, dept_id) values ('not_exists_id', 'not_exists_dept')""")
        except Exception as e:
            # pymssql.OperationalError().args
            print("/* 验证触发器约束", type(e), e.args[0], e.args[1].decode('utf-8'), "*/")


        server.drop_trigger("update_class")
        with open('update_class.sql', encoding='utf-8') as f:
            trigger = f.read()
        server.just_exec(trigger)

        server.just_exec("""update class set id='test' where id='g09403' """)

        q("""select id, class_id from student""")

        server.just_exec("""update class set id='g09403' where id='test' """)

        q("""select id, class_id from student""")
```

###### 定义存储过程，查询“学生”表中学号=g0940211的学生的姓名和已选课程门数，若选课门数在3门以上，输出“XX，已经完成了选课”；否则输出“XX，还需选课”。 

先删除可能存在的过程名称

```sql
drop proc if exists sel_course_check
```

`sql_course_check.sql`内容如下：

```sql
create procedure sel_course_check
    @student_id varchar(20)
as
begin
    declare @name nvarchar(15), @cnt int
    declare stu_cs cursor local scroll for
    select name from student where id = @student_id
    open stu_cs
    fetch next from stu_cs into @name
    if @@FETCH_STATUS = 0 begin
        select @cnt=count(1) from student_course where student_id = @student_id
        if @cnt > 3 begin
            select @name + N'，已经完成了选课' as result
        end
        else begin
            select @name + N'，还需选课' as result
        end
        -- select @name + N'选了' +
        --     convert(varchar(19), @cnt) + N'门课' as result
    end
    else begin
        select N'Fetch状态: ' + convert(varchar(19), @@FETCH_STATUS) + N', 指定学生不存在' as result
    end
end
```

其中包括如下逻辑

+ 如果存在对应`id`的同学，则继续
    + 如果查到的`@cnt`大于3，则返回他完成了选课
    + 否则返回没有完成选课。
+ 否则返回错误让宿主语言捕获。

测试如下：

```sql
execute sel_course_check 'g0940211'
/*
+----------------+
|     result     |
+----------------+
| 赵凯，还需选课 |
+----------------+
*/
```

![1576908471053](C:\Users\Kamiyoru\AppData\Roaming\Typora\typora-user-images\1576908471053.png)

###### 定义存储过程，用于查询“学生选课”数据库中所有教师的姓名、性别、职称和所授课的课程名称
先删除可能存在的过程名称

```sql
drop proc if exists show_tea
```

`show_tea.sql`的内容如下：

```sql
create procedure show_tea
as
begin
    declare @teacher_id varchar(20)
    declare @teacher_name nvarchar(20)
    declare @teacher_gender nvarchar(2)
    declare @teacher_prof nvarchar(5)
    declare stu_cs cursor local scroll for
    select id, name, gender, prof from teacher
    open stu_cs
    fetch next from stu_cs into @teacher_id, @teacher_name, @teacher_gender, @teacher_prof
    while @@FETCH_STATUS = 0 begin
        select @teacher_id, @teacher_name as name, @teacher_gender as gender, @teacher_prof as prof
        select course_id, name from teacher_course
            left join course on course_id = course.id where teacher_id=@teacher_id
        fetch next from stu_cs into @teacher_id, @teacher_name, @teacher_gender, @teacher_prof
    end
end
```

调用过程

```sql
execute show_tea
/*
+-----------+--------+--------+--------+
|           |  name  | gender |  prof  |
+-----------+--------+--------+--------+
| dep01_001 | 王敬远 |   男   | 副教授 |
+-----------+--------+--------+--------+
+------------+----------------+
| course_id  |      name      |
+------------+----------------+
| dep01_s002 | 网络技术与实践 |
| dep01_s002 | 网络技术与实践 |
+------------+----------------+
+-----------+------+--------+--------+
|           | name | gender |  prof  |
+-----------+------+--------+--------+
| dep01_002 | 马丽 |   女   | 副教授 |
+-----------+------+--------+--------+
+-----------+------+
| course_id | name |
+-----------+------+
+-----------+------+
+-----------+------+--------+--------+
|           | name | gender |  prof  |
+-----------+------+--------+--------+
| dep01_003 | 包维 |   女   | 副教授 |
+-----------+------+--------+--------+
+-----------+------+
| course_id | name |
+-----------+------+
+-----------+------+
+-----------+--------+--------+------+
|           |  name  | gender | prof |
+-----------+--------+--------+------+
| dep01_004 | 蒋晓英 |   女   | 讲师 |
+-----------+--------+--------+------+
+-----------+------+
| course_id | name |
+-----------+------+
+-----------+------+
+-----------+------+--------+------+
|           | name | gender | prof |
+-----------+------+--------+------+
| dep01_005 | 黄翔 |   男   | 讲师 |
+-----------+------+--------+------+
+-----------+------+
| course_id | name |
+-----------+------+
+-----------+------+
+-----------+--------+--------+------+
|           |  name  | gender | prof |
+-----------+--------+--------+------+
| dep01_025 | 周春桃 |   女   | 教授 |
+-----------+--------+--------+------+
+-----------+------+
| course_id | name |
+-----------+------+
+-----------+------+
+-----------+------+--------+------+
|           | name | gender | prof |
+-----------+------+--------+------+
| dep02_001 | 康辉 |   男   | 教授 |
+-----------+------+--------+------+
+-----------+------+
| course_id | name |
+-----------+------+
+-----------+------+
+-----------+------+--------+------+
|           | name | gender | prof |
+-----------+------+--------+------+
| dep02_002 | 王皓 |   男   | 讲师 |
+-----------+------+--------+------+
+-----------+------+
| course_id | name |
+-----------+------+
+-----------+------+
+-----------+--------+--------+------+
|           |  name  | gender | prof |
+-----------+--------+--------+------+
| dep02_003 | 李丽华 |   女   | 讲师 |
+-----------+--------+--------+------+
+-----------+------+
| course_id | name |
+-----------+------+
+-----------+------+
+-----------+------+--------+------+
|           | name | gender | prof |
+-----------+------+--------+------+
| dep02_004 | 罗伟 |   男   | 讲师 |
+-----------+------+--------+------+
+-----------+------+
| course_id | name |
+-----------+------+
+-----------+------+
+-----------+--------+--------+--------+
|           |  name  | gender |  prof  |
+-----------+--------+--------+--------+
| dep03_001 | 董一平 |   男   | 副教授 |
+-----------+--------+--------+--------+
+-----------+------+
| course_id | name |
+-----------+------+
+-----------+------+
+-----------+------+--------+------+
|           | name | gender | prof |
+-----------+------+--------+------+
| dep03_002 | 潘惠 |   女   | 讲师 |
+-----------+------+--------+------+
+-----------+------+
| course_id | name |
+-----------+------+
+-----------+------+
+-----------+------+--------+--------+
|           | name | gender |  prof  |
+-----------+------+--------+--------+
| dep04_001 | 纪云 |   男   | 副教授 |
+-----------+------+--------+--------+
+------------+--------------------------+
| course_id  |           name           |
+------------+--------------------------+
| dep04_s001 | SQL Server数据库开发技术 |
| dep04_s005 |         网页设计         |
+------------+--------------------------+
+-----------+------+--------+------+
|           | name | gender | prof |
+-----------+------+--------+------+
| dep04_002 | 章红 |   女   | 教授 |
+-----------+------+--------+------+
+------------+--------------------+
| course_id  |        name        |
+------------+--------------------+
| dep04_p001 |   C语言程序设计    |
| dep04_s002 | JAVA程序设计与开发 |
+------------+--------------------+
+-----------+------+--------+------+
|           | name | gender | prof |
+-----------+------+--------+------+
| dep04_003 | 李伟 |   男   | 教授 |
+-----------+------+--------+------+
+------------+--------------+
| course_id  |     name     |
+------------+--------------+
| dep04_s003 |  单片机原理  |
| dep04_s004 | 软件开发技术 |
+------------+--------------+
+-----------+------+--------+------+
|           | name | gender | prof |
+-----------+------+--------+------+
| dep04_004 | 严为 |   男   | 助教 |
+-----------+------+--------+------+
+------------+--------------+
| course_id  |     name     |
+------------+--------------+
| dep04_b001 |  计算机基础  |
| dep04_s004 | 软件开发技术 |
+------------+--------------+
+-----------+------+--------+------+
|           | name | gender | prof |
+-----------+------+--------+------+
| dep04_005 | 乔红 |   女   | 讲师 |
+-----------+------+--------+------+
+------------+--------------------------+
| course_id  |           name           |
+------------+--------------------------+
| dep04_s001 | SQL Server数据库开发技术 |
+------------+--------------------------+
*/
```

###### 修改存储过程dbo.ShowTeaCourse,用于查询“学生选课”数据库中所有副教授职称的教师的姓名、性别、职称和所授课的课程名称。

`alter_show_tea.sql`内容如下：

```sql
alter procedure show_tea
as
begin
    declare @teacher_id varchar(20)
    declare @teacher_name nvarchar(20)
    declare @teacher_gender nvarchar(2)
    declare @teacher_prof nvarchar(5)
    declare stu_cs cursor local scroll for
    select id, name, gender, prof from teacher where prof=N'副教授'
    open stu_cs
    fetch next from stu_cs into @teacher_id, @teacher_name, @teacher_gender, @teacher_prof
    while @@FETCH_STATUS = 0 begin
        select @teacher_id, @teacher_name as name, @teacher_gender as gender, @teacher_prof as prof
        select course_id, name from teacher_course
            left join course on course_id = course.id where teacher_id=@teacher_id
        fetch next from stu_cs into @teacher_id, @teacher_name, @teacher_gender, @teacher_prof
    end
end
```

与`show_tea`不同的地方周，创建游标的时候，添加了一个条件`where prof=N'副教授'`

调用结果如下：

```sql
execute show_tea
/*
+-----------+--------+--------+--------+
|           |  name  | gender |  prof  |
+-----------+--------+--------+--------+
| dep01_001 | 王敬远 |   男   | 副教授 |
+-----------+--------+--------+--------+
+------------+----------------+
| course_id  |      name      |
+------------+----------------+
| dep01_s002 | 网络技术与实践 |
| dep01_s002 | 网络技术与实践 |
+------------+----------------+
+-----------+------+--------+--------+
|           | name | gender |  prof  |
+-----------+------+--------+--------+
| dep01_002 | 马丽 |   女   | 副教授 |
+-----------+------+--------+--------+
+-----------+------+
| course_id | name |
+-----------+------+
+-----------+------+
+-----------+------+--------+--------+
|           | name | gender |  prof  |
+-----------+------+--------+--------+
| dep01_003 | 包维 |   女   | 副教授 |
+-----------+------+--------+--------+
+-----------+------+
| course_id | name |
+-----------+------+
+-----------+------+
+-----------+--------+--------+--------+
|           |  name  | gender |  prof  |
+-----------+--------+--------+--------+
| dep03_001 | 董一平 |   男   | 副教授 |
+-----------+--------+--------+--------+
+-----------+------+
| course_id | name |
+-----------+------+
+-----------+------+
+-----------+------+--------+--------+
|           | name | gender |  prof  |
+-----------+------+--------+--------+
| dep04_001 | 纪云 |   男   | 副教授 |
+-----------+------+--------+--------+
+------------+--------------------------+
| course_id  |           name           |
+------------+--------------------------+
| dep04_s001 | SQL Server数据库开发技术 |
| dep04_s005 |         网页设计         |
+------------+--------------------------+
*/
```

###### 删除该存储过程。

```sql
drop proc if exists show_tea
```

###### 创建INSERT触发器，如果向教师表中插入记录时，检查该记录的院系编号在表中是否存在。如果不存在，则不允许插入。

先drop掉可能已经存在的触发器

```sql
drop trigger if exists check_teachers_dept_id
```

`check_teachers_dept_id.sql`内容如下：

```sql
create trigger check_teachers_dept_id on teacher
instead of insert
as begin
    if not exists(select id from department where id = (select dept_id from inserted))
    begin
        RaisError(N'该部门不存在，禁止插入！', 16, 1)
    end
    else
    begin
        insert into teacher select * from inserted
    end
end
```

其中`instead of`使用后将完全替代`insert`的`functional`，因此才会在这里将`inserted`表的行列全部插入到teacher表中

测试如下：

```sql
insert into teacher(id, dept_id) values ('not_exists_id', 'not_exists_dept')
```

python返回错误：

```python
<class 'pymssql.OperationalError'> 50000 该部门不存在，禁止插入！DB-Lib error message 20018, severity 16:
General SQL Server error: Check messages from the SQL Server
```

###### 创建UPDATEClass触发器，当对班级信息表主键"班级号"进行修改时，应对学生表中相应的"班级号"也进行修改。

先drop掉可能已经存在的触发器

```sql
drop trigger if exists update_class
```

`update_class.sql`内容如下：

```sql
create trigger update_class on class
after update
as begin if update(id) begin
    update student set class_id=(select id from inserted) where class_id=(select id from deleted)
end end
```

这里有点小问题，如果是SQL Server，那么触发器是没有`before hook`的，因此无法做到完美的避开外键检查。这里只好`drop`掉外键以后再使用此触发器。

测试如下：

```sql
update class set id='test' where id='g09403' 
select id, class_id from student
/*
+----------+----------+
|    id    | class_id |
+----------+----------+
| g0140101 |  g01401  |
| g0140102 |  g01401  |
| g0140103 |  g01401  |
| g0140104 |  g01401  |
| g0140105 |  g01401  |
| g0140106 |  g01401  |
| g0140107 |  g01401  |
| g0140201 |  g01402  |
| g0140204 |  g01402  |
| g0140205 |  g01402  |
| g0240206 |  g01402  |
| g0240301 |  g01403  |
| g0240302 |  g01403  |
| g0240303 |  g01403  |
| g0240304 |  g01403  |
| g0240401 |  g01404  |
| g0240402 |  g01404  |
| g0240403 |  g01404  |
| g0940201 |  g09402  |
| g0940202 |  g09402  |
| g0940203 |  g09402  |
| g0940204 |  g09402  |
| g0940205 |  g09402  |
| g0940206 |  g09402  |
| g0940207 |  g09402  |
| g0940210 |  g09402  |
| g0940211 |  g09402  |
| g0940301 |   test   |
| g0940302 |   test   |
| g0940303 |   test   |
+----------+----------+
*/
update class set id='g09403' where id='test' 
select id, class_id from student
/*
+----------+----------+
|    id    | class_id |
+----------+----------+
| g0140101 |  g01401  |
| g0140102 |  g01401  |
| g0140103 |  g01401  |
| g0140104 |  g01401  |
| g0140105 |  g01401  |
| g0140106 |  g01401  |
| g0140107 |  g01401  |
| g0140201 |  g01402  |
| g0140204 |  g01402  |
| g0140205 |  g01402  |
| g0240206 |  g01402  |
| g0240301 |  g01403  |
| g0240302 |  g01403  |
| g0240303 |  g01403  |
| g0240304 |  g01403  |
| g0240401 |  g01404  |
| g0240402 |  g01404  |
| g0240403 |  g01404  |
| g0940201 |  g09402  |
| g0940202 |  g09402  |
| g0940203 |  g09402  |
| g0940204 |  g09402  |
| g0940205 |  g09402  |
| g0940206 |  g09402  |
| g0940207 |  g09402  |
| g0940210 |  g09402  |
| g0940211 |  g09402  |
| g0940301 |  g09403  |
| g0940302 |  g09403  |
| g0940303 |  g09403  |
+----------+----------+
*/
```

## 实验小结

因为在操作数据库上我还是很有经验的，所以在实验中并没有遇到什么问题。

此次实验中我复习了触发器和调用过程的编写。调用过程和触发器在理论上减少了通信成本，可以有小幅度的优化。

至此，所有数据库实验均已做完，我对这六个实验给出的总体意见是，可以考虑综合多种关系型数据库，提炼一个大致的实验要求，使得实验不拘泥于`sql server`一个数据库产品。也可以考虑新置一到两个额外的实验用于让同学们接触和熟练`no sql/new sql`产品的理念和具体上手操作。