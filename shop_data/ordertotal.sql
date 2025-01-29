Q.1) total amount of each order

select o.ordid,o.orddate, sum(od.qty*pp.price) as total
from orders o,orderdetails od,productprice pp where o.orddate=pp.proddate and pp.prodid=od.prodid and 
o.ordid=od.ordid group by o.orddate,o.ordid;




insert into productprice(prodid,proddate,price)values(1,'2023-5-1',20);
insert into productprice(prodid,proddate,price)values(2,'2023-5-1',35);
insert into productprice(prodid,proddate,price)values(3,'2023-5-1',40);
insert into productprice(prodid,proddate,price)values(4,'2023-5-1',90);
insert into productprice(prodid,proddate,price)values(5,'2023-5-1',60)
insert into productprice(prodid,proddate,price)values(6,'2023-5-1',100);
insert into productprice(prodid,proddate,price)values(7,'2023-5-1',55)
insert into productprice(prodid,proddate,price)values(1,'2023-6-1',30);
insert into productprice(prodid,proddate,price)values(2,'2023-6-1',25);
insert into productprice(prodid,proddate,price)values(3,'2023-6-1',45);
insert into productprice(prodid,proddate,price)values(4,'2023-6-1',95);
insert into productprice(prodid,proddate,price)values(5,'2023-6-1',70);
insert into productprice(prodid,proddate,price)values(6,'2023-6-1',120);
insert into productprice(prodid,proddate,price)values(7,'2023-6-1',50);
select * from productprice;




insert into orderdetails(ordid,prodid,qty) values(1,1,2);
insert into orderdetails(ordid,prodid,qty) values(1,2,1);
insert into orderdetails(ordid,prodid,qty) values(1,4,5);
insert into orderdetails(ordid,prodid,qty) values(1,7,2);
insert into orderdetails(ordid,prodid,qty) values(1,6,6);
insert into orderdetails(ordid,prodid,qty) values(2,1,2);
insert into orderdetails(ordid,prodid,qty) values(2,2,10);
insert into orderdetails(ordid,prodid,qty) values(2,3,4);
insert into orderdetails(ordid,prodid,qty) values(2,5,8);
insert into orderdetails(ordid,prodid,qty) values(2,1,2);
insert into orderdetails(ordid,prodid,qty) values(2,7,15);
select * from orderdetails;
delete from orderdetails;

insert into orders(ordid,orddate)values(1,'2023-5-1');
insert into orders(ordid,orddate)values(2,'2023-6-1');



 
