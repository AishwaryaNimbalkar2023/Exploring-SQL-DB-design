
Q.1)bill of customer in each month

select custid,startdate,enddate,sum(total)as total from(select c.custid,cd.startdate,cd.enddate,sum(pd.price*od.qty) as total
from orders o,orderdetails od,productdetails pd,customer c,custorderdate cd
where pd.prodid=od.prodid and o.ordid=od.ordid 
and c.custid=od.custid and o.orddate=pd.prodate 
and cd.custid=od.custid and  o.orddate BETWEEN cd.startdate and cd.enddate
GROUP BY c.custid,o.orddate)as custtotal group by custid,startdate,enddate;

Q.2)bill of customer in each month after giving discount

select payment.custid,payment.startdate,payment.enddate,payment.total_amount from
(select bill.custid,bill.startdate,bill.enddate,bill.total_amount from
(select ct.custid,ct.startdate,ct.enddate,ct.total,
cs.mintotal,ROW_NUMBER() OVER( partition by ct.custid,ct.startdate,ct.enddate ORDER BY cs.mintotal DESC) AS row_number,
(ct.total-ct.total*cs.discount/100)as total_amount
from(select custid,startdate,enddate,sum(total)as total from
 (select c.custid,cd.startdate,cd.enddate,sum(pd.price*od.qty) as total
from orders o,orderdetails od,productdetails pd
 ,customer c,custorderdate cd
where pd.prodid=od.prodid and o.ordid=od.ordid 
and c.custid=od.custid and o.orddate=pd.prodate 
and cd.custid=od.custid and  o.orddate BETWEEN cd.startdate and cd.enddate
GROUP BY c.custid,o.orddate)as custtotal group by custid,startdate,enddate)as ct
INNER JOIN custdiscount cs ON cs.custid = ct.custid 
group by ct.custid,ct.startdate,ct.enddate,cs.mintotal having ct.total>=cs.mintotal)as bill 
where row_number=1 group by bill.custid,bill.startdate,bill.enddate
union
select bill.custid,bill.startdate,bill.enddate,bill.total_amount from
(select ct.custid,ct.startdate,ct.enddate,ct.total as total_amount,
cs.mintotal,ROW_NUMBER() OVER( partition by ct.custid,ct.startdate,ct.enddate ORDER BY cs.mintotal DESC) AS row_number
from(select custid,startdate,enddate,sum(total)as total from
 (select c.custid,cd.startdate,cd.enddate,sum(pd.price*od.qty) as total
from orders o,orderdetails od,productdetails pd,customer c,custorderdate cd
where pd.prodid=od.prodid and o.ordid=od.ordid 
and c.custid=od.custid and o.orddate=pd.prodate 
and cd.custid=od.custid and  o.orddate BETWEEN cd.startdate and cd.enddate
GROUP BY c.custid,o.orddate)as custtotal group by custid,startdate,enddate)as ct
INNER JOIN custdiscount cs ON cs.custid = ct.custid 
group by ct.custid,ct.startdate,ct.enddate,cs.mintotal having ct.total<cs.mintotal)as bill 
where row_number=1 group by bill.custid,bill.startdate,bill.enddate)as payment
group by payment.custid,payment.startdate,payment.enddate;

Q.3) total amount of each order

select o.ordid,o.orddate, sum(od.qty*pp.price) as total
from orders o,orderdetails od,productprice pp where o.orddate=pp.proddate and pp.prodid=od.prodid and 
o.ordid=od.ordid group by o.orddate,o.ordid;


Q.4) sum of total price of each order after giving discount  

select payment.ordid,payment.orddate,sum(amount) as total from(	 	
select bill.ordid,bill.orddate,sum(total_amount) as amount from	
(SELECT o.ordid,o.orddate,od.prodid,od.qty,pp.price,pq.minqty,pq.discount,
ROW_NUMBER() OVER(PARTITION BY od.prodid, 
o.ordid ORDER BY pq.minqty DESC) AS row_number,
(od.qty * pp.price - od.qty * pp.price * pq.discount/100) AS total_amount  
from orders o,orderdetails od,productprice pp,prodqtydiscount pq
where o.orddate=pp.proddate and pp.prodid=od.prodid and o.ordid=od.ordid 
and pq.prodid=od.prodid and pq.prodid=pp.prodid
GROUP BY o.ordid, o.orddate, od.prodid, od.qty, pp.price, pq.minqty, pq.discount
HAVING od.qty >= pq.minqty)as bill where row_number=1 group by bill.ordid,bill.orddate
union
select bill.ordid,bill.orddate,sum(total_amount) as amount from
(SELECT o.ordid,o.orddate,od.prodid,od.qty,pp.price,pq.minqty,pq.discount,
ROW_NUMBER() OVER(PARTITION BY od.prodid, o.ordid ORDER BY pq.minqty DESC) AS row_number,
od.qty*pp.price as total_amount 
from orders o,orderdetails od,productprice pp,prodqtydiscount pq
where o.orddate=pp.proddate and pp.prodid=od.prodid and o.ordid=od.ordid 
and pq.prodid=od.prodid and pq.prodid=pp.prodid
GROUP BY o.ordid, o.orddate, od.prodid
HAVING qty<min(minqty))as bill where row_number=1 group by bill.ordid,bill.orddate)as payment
 group by payment.ordid,payment.orddate;	

