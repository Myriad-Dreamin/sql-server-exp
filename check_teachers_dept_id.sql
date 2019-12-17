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