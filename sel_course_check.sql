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