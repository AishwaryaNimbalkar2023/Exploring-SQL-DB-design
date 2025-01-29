Q) sum of total price of each order after giving discount  

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
