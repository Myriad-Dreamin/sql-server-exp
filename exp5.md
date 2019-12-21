## 数据库实验第五次实验 - 数据库完整性与安全性实验

Myriad Dreamin 2017211279 2017211301

## 实验目的

- 通过对完整性规则的定义实现，熟悉了解SQL SERVER中完整性保证的规则和实现方法，加深对数据完整性的理解。
- 通过对安全性相关内容的定义，熟悉了解SQL SERVER中安全性的内容和实现方法，加深对数据库安全性的理解

## 实验平台及环境

- 系统: Ubuntu18.04 LTS
- 环境: Docker 18.09.7
- 数据库版本: Microsoft SQL Server 2017

## 实验内容


+ 完整性实验与要求：
    + 分别定义数据库中各基础表的主、外键，实现实体完整性约束及参照完整性约束；
    + 向学生表插入具有相同学号的数据，验证其实体完整性约束；
    + 向学生表中插入一条数据，班级号是学生表的外键，验证参照完整性约束。
    + 安全性实验内容与要求：
+ 登陆管理
    + 将Windows账户中的用户LUXQ添加到SQL Sever登陆中，默认数据库为StudentDB；
    + 创建名为teacher的SQL登陆，密码为123321，默认数据库为master，强制实施密码策略；
    + 修改SQL登录名teacher的登录密码为789987；
    + 禁用名为teacher的登陆；
    + 删除teacher登录名。
+ 用户管理
    + 创建名为 teacher的登录名，在学生选课数据库中，创建用户professor与teacher登录名对应；
    + 在学生选课数据库中创建用户professor,将其名称改为professor2；
    + 删除StudentDB数据库中用户professor2；
    + 在学生选课数据库中，创建用户professor,其对应登录名为teacher，并将教师表权限授予professor；
    + 在学生选课数据库中，拒绝用户professor查看教师表权限；
用Enterprise Manager或Transact_SQL语句完成以上内容。

## 实验步骤

#### 完整性实验的实验方式

使用下列脚本完成本实验：

```python


from sql_server import SqlServer
from sql_func import fc, wk
import pymssql

if __name__ == '__main__':
    database_name = 'student_source'

    with SqlServer(database_name, auto_commit=True) as server:
        
        server.drop_foreign_key("course", "fk_book_id_on_course")
        server.just_exec("""
insert into book(id, name) select id, 'auto_generated' from (
    (select book_id as id from course) except (select id from book)) as ids
        """)
        # 省略后续内容，基本相同
```

其中`drop_foreign_key`是封装的调用过程。如下：

```python
    def drop_foreign_key(self, table, foreign_key):
        return self.just_exec("""
if exists(select constraint_name from information_schema.key_column_usage where constraint_name='%s')
alter table %s drop constraint %s
        """ % (foreign_key, table, foreign_key))
```

为省事，没有使用`prepare`语句防止sql注入。但是可以完成实验需求。

#### 完整性实验的具体过程

###### 主键的完整性约束

主键的完整性约束已经在创建表的时候被添加上了，但是也可以在创建表以后使用`alter`语句修改。
下面是各个表已经被添加的主键：

###### 外键的完整性约束。

外键的完整性约束对应数据库理论的参照完整性约束.如果需要添加一个外键需要满足以下需求:

+ 操作表存在并拥有对应表的权限
+ 外键名称实体不存在
+ 外键约束在已有数据上成立

创建`course`表上`book_id`的外键约束：

先检查如果已经有该约束了，直接`drop`掉。

```sql
if exists(select constraint_name from information_schema.key_column_usage where constraint_name='fk_book_id_on_course')
alter table course drop constraint fk_book_id_on_course
```

为了防止添加外键约束失败，创建无用的填充条目。

```sql
insert into book(id, name) select id, 'auto_generated' from (
    (select book_id as id from course) except (select id from book)) as ids
```

为`course`表上`book_id`创建外键约束。

```sql        
alter table course add constraint fk_book_id_on_course foreign key(book_id) references book(id)
```

创建`class_course`表上`class_id`的外键约束：

先检查如果已经有该约束了，直接`drop`掉。

```sql
if exists(select constraint_name from information_schema.key_column_usage where constraint_name='fk_class_id_on_class_course')
alter table class_course drop constraint fk_class_id_on_class_course
```

为了防止添加外键约束失败，创建无用的填充条目。

```sql
insert into class(id, dept_id, address) select id, 'dep_05', 'auto_generated' from (
    (select class_id as id from class_course) except (select id from class)) as ids
```

为`course`表上`class_id`创建外键约束。

```sql
alter table class_course add constraint fk_class_id_on_class_course foreign key(class_id) references class(id)
```

创建`class_course`表上`course_id`的外键约束：


先检查如果已经有该约束了，直接`drop`掉。

```sql
if exists(select constraint_name from information_schema.key_column_usage where constraint_name='fk_course_id_on_class_course')
alter table class_course drop constraint fk_course_id_on_class_course
```

为了防止添加外键约束失败，创建无用的填充条目。

```sql
insert into course(id, book_id, name) select id, 'dep01_s001_01', 'auto_generated' from (
    (select course_id as id from class_course) except (select id from course)) as ids
```

为`class_course`表上`course_id`创建外键约束。

```sql
alter table class_course add constraint fk_course_id_on_class_course foreign key(course_id) references course(id)
```

创建`student`表上`class_id`的外键约束：

先检查如果已经有该约束了，直接`drop`掉。

```sql
if exists(select constraint_name from information_schema.key_column_usage where constraint_name='fk_class_id_on_student')
alter table student drop constraint fk_class_id_on_student
```

为了防止添加外键约束失败，创建无用的填充条目。

```sql
insert into class(id, dept_id, address) select id, 'dep_05', 'auto_generated' from (
    (select class_id as id from student) except (select id from class)) as ids
```

为`student`表上`class_id`创建外键约束。

```sql
alter table student add constraint fk_class_id_on_student foreign key(class_id) references class(id)
```

创建`student_course`表上`course_id`的外键约束：

先检查如果已经有该约束了，直接`drop`掉。

```sql
if exists(select constraint_name from information_schema.key_column_usage where constraint_name='fk_course_id_on_student_course')
alter table student_course drop constraint fk_course_id_on_student_course
```

为`student_course`表上`course_id`创建外键约束。

```sql
alter table student_course add constraint fk_course_id_on_student_course foreign key(course_id) references course(id)
```

创建`student_course`表上`student_id`的外键约束：

先检查如果已经有该约束了，直接`drop`掉。

```sql
if exists(select constraint_name from information_schema.key_column_usage where constraint_name='fk_student_id_on_student_course')
alter table student_course drop constraint fk_student_id_on_student_course
```

为`student_course`表上`student_id`创建外键约束。

```sql
alter table student_course add constraint fk_student_id_on_student_course foreign key(student_id) references student(id)
```

创建`teacher`表上`dept_id`的外键约束：

先检查如果已经有该约束了，直接`drop`掉。

```sql
if exists(select constraint_name from information_schema.key_column_usage where constraint_name='fk_dept_id_on_teacher')
alter table teacher drop constraint fk_dept_id_on_teacher
```

为`teacher`表上`dept_id`创建外键约束。

```sql
alter table teacher add constraint fk_dept_id_on_teacher foreign key(dept_id) references department(id)
```

创建`class`表上`dept_id`的外键约束：

先检查如果已经有该约束了，直接`drop`掉。

```sql
if exists(select constraint_name from information_schema.key_column_usage where constraint_name='fk_dept_id_on_class')
alter table class drop constraint fk_dept_id_on_class
```

为`class`表上`dept_id`创建外键约束。

```sql
alter table class add constraint fk_dept_id_on_class foreign key(dept_id) references department(id)
```

创建`teacher`表上`cat`的外键约束：

先检查如果已经有该约束了，直接`drop`掉。

```sql
if exists(select constraint_name from information_schema.key_column_usage where constraint_name='fk_cat_on_teacher')
alter table teacher drop constraint fk_cat_on_teacher
```

为`teacher`表上`cat`创建外键约束。

```sql
alter table teacher add constraint fk_cat_on_teacher foreign key(cat) references teacher_type(id)
```

创建`teacher_course`表上`teacher_id`的外键约束：

先检查如果已经有该约束了，直接`drop`掉。

```sql
if exists(select constraint_name from information_schema.key_column_usage where constraint_name='fk_teacher_id_on_teacher_course')
alter table teacher_course drop constraint fk_teacher_id_on_teacher_course
```

为`teacher_course`表上`teacher_id`创建外键约束。

```sql
alter table teacher_course add constraint fk_teacher_id_on_teacher_course foreign key(teacher_id) references teacher(id)
```

创建`teacher_course`表上`course_id`的外键约束：

先检查如果已经有该约束了，直接`drop`掉。

```sql
if exists(select constraint_name from information_schema.key_column_usage where constraint_name='fk_course_id_on_teacher_course')
alter table teacher_course drop constraint fk_course_id_on_teacher_course
```

为`teacher_course`表上`course_id`创建外键约束。

```sql
alter table teacher_course add constraint fk_course_id_on_teacher_course foreign key(course_id) references course(id)
```

创建`teacher_course`表上`class_id`的外键约束：

先检查如果已经有该约束了，直接`drop`掉。

```sql
if exists(select constraint_name from information_schema.key_column_usage where constraint_name='fk_class_id_on_teacher_course')
alter table teacher_course drop constraint fk_class_id_on_teacher_course
```

为`teacher_course`表上`class_id`创建外键约束。

```sql
alter table teacher_course add constraint fk_class_id_on_teacher_course foreign key(class_id) references class(id)
```

创建`teacher_course`表上`book_id`的外键约束：

先检查如果已经有该约束了，直接`drop`掉。

```sql
if exists(select constraint_name from information_schema.key_column_usage where constraint_name='fk_book_id_on_teacher_course')
alter table teacher_course drop constraint fk_book_id_on_teacher_course
```

为`teacher_course`表上`book_id`创建外键约束。

```sql
alter table teacher_course add constraint fk_book_id_on_teacher_course foreign key(book_id) references book(id)
```

###### 验证实体完整性约束

通过一个简单的插入语句验证已经添加的实体完整性约束。

```sql
insert into student(id) values ('g0940201')
```

python返回错误：

```python
<class 'pymssql.IntegrityError'> (2627, b"Violation of PRIMARY KEY constraint 'PK__student__3213E83F4544E73F'. Cannot insert duplicate key in object 'dbo.student'. The duplicate key value is (g0940201).DB-Lib error message 20018, severity 14:\nGeneral SQL Server error: Check messages from the SQL Server\n")
```

###### 验证参照完整性约束

通过一个简单的插入语句验证已经添加的参照完整性约束。


```sql
insert into student(id, class_id) values ('not_exists_id', 'not_exists_class')
```

python返回错误：

```python
<class 'pymssql.IntegrityError'> (547, b'The INSERT statement conflicted with the FOREIGN KEY constraint "fk_class_id_on_student". The conflict occurred in database "student_source", table "dbo.class", column \'id\'.DB-Lib error message 20018, severity 16:\nGeneral SQL Server error: Check messages from the SQL Server\n')
```

#### 安全性实验

创建名为`teacher`的SQL登陆，密码为`123321`，默认数据库为`master`，强制实施密码策略。因为`123321`的密码强度过低，无法通过数据库检查，所以改为`123321aA`，实际不影响实验正确性。

```sql
create login teacher with password=N'123321aA', default_database=student_source
```

修改SQL登录名`teacher`的登录密码为`789987`。

```sql
alter login teacher with password=N'789987aA'
```

禁用名为`teacher`的登陆

```sql
alter login teacher disable
```

删除`teacher`登录名

```sql
drop login teacher
```

重新创建`teacher`登录用户。

```sql
create login teacher with password=N'123321aA', default_database=student_source
```

创建名为 `teacher`的登录名，在学生选课数据库中，创建用户`professor`与`teacher`登录名对应。

```sql
create user professor for login teacher with default_schema=dbo
```

在学生选课数据库中创建用户`professor`,将其名称改为`professor2`

```sql
alter user professor with name=professor2
```

删除`StudentDB`数据库中用户`professor2`

```sql
drop user professor2
```

在学生选课数据库中，重新创建用户`professor`与`teacher`登录名对应。

```sql
create user professor for login teacher with default_schema=dbo
```

在学生选课数据库中，创建用户`professor`,其对应登录名为`teacher`，并将教师表权限授予`professor`

```sql
grant all on teacher to professor
```

在学生选课数据库中，拒绝用户`professor`查看教师表权限

```sql
revoke select on teacher to professor
```

进行实验后的清除用户处理。

```sql
drop user professor
drop login teacher
```


## 实验小结

在本次实验中学会了数据库用户的管理。同时认识到了外键的限制之严格。

当我们想要为一列加上外键时，需要对其做额外的处理。这时候有两种解决办法，一种是直接添加`NULL`因为外键不对`NULL`检查。另外一种办法是，强行增加一条无用的行再在外键列中填入对应的索引值。

使用`NULL`值有可能埋下祸端。拒绝`NULL`可能避免一些奇怪的错误和逻辑错误，所以本实验避免FK错误时采用了第二种方式。这也不是好的办法，但终归解决了外键的问题。

本次实验的主要收获是上手编写了`TSQL`增加了编写语句的熟练度。

我对本次实验给出的建议是，希望能够更合理地编写数据，适当减少一些合理外键产生冲突。在编写外键时，我发现一共十几个外键有近一半都产生了冲突。但也可以适当保留一到两个，让学生能够获得发现并解决外键冲突的经验。