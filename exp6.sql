drop proc if exists sel_course_check
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
execute sel_course_check 'g0940211'
/*
+----------------+
|     result     |
+----------------+
| 赵凯，还需选课 |
+----------------+
*/
drop proc if exists show_tea
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
drop trigger if exists check_teachers_dept_id
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
insert into teacher(id, dept_id) values ('not_exists_id', 'not_exists_dept')
/* 验证触发器约束 <class 'pymssql.OperationalError'> 50000 该部门不存在，禁止插入！DB-Lib error message 20018, severity 16:
General SQL Server error: Check messages from the SQL Server
 */
drop trigger if exists update_class
create trigger update_class on class
after update
as begin if update(id) begin
    update student set class_id=(select id from inserted) where class_id=(select id from deleted)
end end
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
