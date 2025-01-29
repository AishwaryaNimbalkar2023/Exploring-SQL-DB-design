Q1)get the final marksheet of all student;note that the marksheet should include marks obtained in the final attempted exam with the grade
   SELECT batch,rollno,courseid,marks,
    CASE
        WHEN marks >= 75 THEN 'O'
        WHEN marks >= 65 THEN 'A'
        WHEN marks >= 55 THEN 'B'
        WHEN marks >= 50 THEN 'C'
        WHEN marks >= 45 THEN 'D'
        WHEN marks >= 40 THEN 'E'
        ELSE 'F'
    END AS Grade
FROM
    examresults group by batch,rollno,courseid ;
	

2. get the list of those students who have exhausted the maximum number of allowed attempts and still have not passed

SELECT batch,rollno from examresults where marks<=39 group by batch,rollno HAVING count(distinct(examid))=8;


3. get the list of those students who have not exhausted the maximum number of allowed attempts and still have not passed

select batch,rollno from examresults where marks >39
 group by batch,rollno 
 having count(distinct(examid))<=7 and count(distinct(courseid))<20;

4. get the list of those students who have not exhausted the maximum number of allowed attempts and have passed

select batch,rollno from examresults where marks>39
 group by batch,rollno 
 having count(distinct(examid))<=7 and count(distinct(courseid))=20;

5. get the list of those students who have passed all their subjects in the first attempt only

 SELECT batch,rollno from examresults where marks>39 
 group by batch,rollno having count(distinct(examid))=1 and count(distinct(courseid))=20;
 
6. get the list of those students who have passed all their subjects in less than 4 attempts

SELECT batch,rollno from examresults where marks>39
 group by batch,rollno having count(distinct(examid))<4 and count(distinct(courseid))=20;

7. get the list of those students who have obtained at least a C grade in at least 7 subjects

SELECT batch,rollno from examresults where marks>50 group by batch,rollno HAVING count(distinct(courseid))>=7;


8. get the list of those students who have obtained at least a C grade in at least 8 subjects 
by exhausting 4 attempts at most per subject

SELECT batch,rollno from examresults
 where marks>50 group by batch,rollno
 HAVING count(distinct(courseid))>=8 and count(distinct(examid))<=4;

9. get the list of those students who have obtained at least a C grade in at least 9 subjects
 by exhausting 50 attempts at most in total across all subjects

 SELECT batch,rollno from examresults 
 where marks>50
 group by batch,rollno
 HAVING count(distinct(courseid))>=9 and count(distinct(examid))=50;
 
10. prepare the list of student-wise fees obtained

11. prepare the list of batch-wise fees obtained



12. prepare the list of top high scoring 1% students

SELECT batch,rollno,sum(marks) as mark FROM examresults where marks>39
 group by batch,rollno having count(DISTINCT(examid))<=8 and count(courseid)=20 
order by mark desc limit 1;
 

13. order the batches according to descending order of marks
 scored by the students of that batch (note that this is tricky)

select batch,rollno,sum(marks) from examresults 
where examid=batch group by batch,examid,rollno 
order by batch,sum(marks) desc; 
	
14. get all exams in which at least 15 or more students failed in at least 12 subjects

select batch,examid from examresults where marks<=39 group by batch,examid
having count(distinct(rollno))>=15 and count(distinct(courseid))>=12;
 
 

 
 
 
 
 
 




