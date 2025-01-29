
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


