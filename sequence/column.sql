Q.2)Write a query that will put fields alternatively from t4 into t5.1 row of t4 in first column t51,2nd in second column t52 and so on


 INSERT INTO t5(t51,t52,t53,t54)
 SELECT CASE WHEN ROW_NUMBER() OVER () % 4 = 1 THEN t4.f4 END AS t51,
    CASE WHEN ROW_NUMBER() OVER () % 4 = 2 THEN t4.f4 END AS t52,
    CASE WHEN ROW_NUMBER() OVER () % 4 = 3 THEN t4.f4 END AS t53,
    CASE WHEN ROW_NUMBER() OVER () % 4 = 0 THEN t4.f4 END as t54
FROM t4;

select * from t5;
delete from t5;
	
	
INSERT INTO t5(t51,t52,t53,t54)
SELECT 
MAX(CASE WHEN rn % 4 = 1 THEN f4 END) AS t51,
MAX(CASE WHEN rn % 4 = 2 THEN f4 END) AS t52,
MAX(CASE WHEN rn % 4 = 3 THEN f4 END) AS t53,
MAX(CASE WHEN rn % 4 = 0 THEN f4 END) AS t54
FROM (SELECT f4, ROW_NUMBER() OVER () AS rn FROM t4) AS numbered
GROUP BY (rn-1)/4;

select * from t5;

delete from t5;

