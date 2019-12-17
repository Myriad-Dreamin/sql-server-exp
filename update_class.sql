create trigger update_class on class
after update
as begin if update(id) begin
    update student set class_id=(select id from inserted) where class_id=(select id from deleted)
end end