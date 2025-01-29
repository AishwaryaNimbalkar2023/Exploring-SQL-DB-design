Q.1)Write a query that will put f11, f21, f31 fields alternatively in sequence in t4. Assume the f11, f21, f31 fields are to be sorted in ascending order.

insert into t1(f11,f12)values(1,10);
insert into t1(f11,f12)values(4,11);
insert into t1(f11,f12)values(7,12);
insert into t1(f11,f12)values(10,13);
select * from t1;

insert into t2(f21,f22)values(2,14);
insert into t2(f21,f22)values(5,15);
insert into t2(f21,f22)values(8,16);
insert into t2(f21,f22)values(11,17);
select * from t2;

insert into t3(f31,f32)values(3,18);
insert into t3(f31,f32)values(6,19);
insert into t3(f31,f32)values(9,20);
insert into t3(f31,f32)values(12,21);
select * from t3;


create view temp as select f11 AS field, ROW_NUMBER() OVER (ORDER BY f11) AS RowNum FROM t1
    UNION ALL
    SELECT f21 AS Field, ROW_NUMBER() OVER (ORDER BY f21) AS RowNum FROM t2
    UNION ALL
    SELECT f31 AS Field, ROW_NUMBER() OVER (ORDER BY f31) AS RowNum FROM t3;
	
select * from temp;
	
insert into t4(f4) select field from temp order by rownum;

select * from t4;
	
