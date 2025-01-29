Q.1)retrieve the joining days of all employee

select empid,min(day) from attendance group by empid;

Q.2) retrieve the employee(s) who have joined the latest

 select empid from(select empid,min(day) as min from attendance 
 group by empid) where min in(select max(min) from(select min(day) as min from attendance group by empid));

Q.3)retrieve the number of working days of all employees
 select empid, count(day) as day from attendance group by empid;

Q.4)retrieve the days on which at least one present employee worked 9 or more hours
SELECT day
FROM attendance
GROUP BY day
HAVING max((strftime('%H', departTime) * 3600 + strftime('%M', departTime) * 60 + strftime('%S', departTime)) -
 (strftime('%H', arrivalTime) * 3600 + strftime('%M', arrivalTime) * 60 + strftime('%S', arrivalTime))) >= 9 * 3600;


Q.5)retrieve the days on which no present employee worked less than 8 SELECT
hours day
FROM attendance
GROUP BY day
HAVING SUM( (strftime('%H', departTime) * 3600 + strftime('%M', departTime) * 60 + strftime('%S', departTime)) -
 (strftime('%H', arrivalTime) * 3600 + strftime('%M', arrivalTime) * 60 + strftime('%S', arrivalTime))) >= 8 * 3600;


Q.6)retrieve the employees which were absent the most

select empid from (select empid,count(day) as count_day from attendance group by empid) where count_day in(select min(count_day) from(select count(day) as count_day from attendance group by empid));

Q.7)retrieve the employees which were absent the least

select empid from (select empid,count(day) as count_day from attendance group by empid) where count_day in(select max(count_day) from(select count(day) as count_day from attendance group by empid));

Q.8)retrieve the employees which have worked the most

select empid from(SELECT empid, SUM((strftime('%H', departTime) * 3600 + strftime('%M', departTime) * 60 + strftime('%S', departTime)) -
(strftime('%H', arrivalTime) * 3600 + strftime('%M', arrivalTime) * 60 + strftime('%S', arrivalTime))) AS total_work
FROM attendance
GROUP BY empid
ORDER BY total_work DESC
LIMIT 1);

