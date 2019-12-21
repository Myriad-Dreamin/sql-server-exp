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