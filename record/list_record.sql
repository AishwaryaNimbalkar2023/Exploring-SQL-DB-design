Q.1)Schema 
create two tables
Objects - #id, count
List - #id, #srno

Write a trigger to insert count number of records with increasing serial numbers into the List table after a record is inserted into the Objects table.
e.g. if the record ('xyz', 3) is inserted into the Objects table, the trigger must insert 3 records in the List table as follows:
('xyz', 1)
('xyz', 2)
('xyz', 3)
e.g. if the record ('pqr', 7) is inserted into the Objects table, the trigger must insert 7 records in the List table as follows:

('pqr', 1)
('pqr', 2)
('pqr', 3)
('pqr', 4)
('pqr', 5)
('pqr', 6)
('pqr', 7)


---->
create trigger list_record after insert on object
BEGIN
insert into list(id,cnt)
with RECURSIVE cnt(x) as
(select 1 union all select x+1 from cnt limit new.cnt)
select new.id,x from cnt;
end;

insert into object(id,cnt)values('xyz',4);

select * from object;

select * from list;

insert into object(id,cnt) values('pqr',7);

select * from object;

select * from list;
