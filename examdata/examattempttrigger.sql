Q.1) if students give exam and they passed in exam then they can't attempted exam again write trigger for that

trigger1)
       CREATE TRIGGER attempt_exam
       BEFORE UPDATE OF mark ON yearsubstud
       BEGIN
   SELECT CASE
   WHEN EXISTS(select rollno,subcode from yearsubstud 
   WHERE rollno = NEW.rollno AND subcode = NEW.subcode AND old.mark>=40) THEN
   RAISE(ABORT, 'you have already passed')
   END;
   END;



trigger 2)
     CREATE TRIGGER mark_update 
     before INSERT ON yearsubstud 
     BEGIN 
     SELECT CASE 
        WHEN (SELECT COUNT(*) FROM yearsubstud WHERE rollno = NEW.rollno AND subcode = NEW.subcode AND mark > 40) > 0 
        THEN 
        RAISE(ABORT, 'Your attempts are finished') 
        END;
        END;


drop trigger attempt_exam;

update yearsubstud set mark=49 where rollno=1 and subcode=101;

update yearsubstud set mark=65 where rollno=2 and subcode=101;

update yearsubstud set mark=68 where rollno=2 and subcode=102;

insert into subjects(subcode,subname)values(102,'dbms');

insert into yearsubstud(years,rollno,subcode,mark)values(2020,1,102,32);
delete from yearsubstud where rollno=1 and subcode=102;
select * from yearsubstud;

insert into yearsubstud(years,rollno,subcode,mark)values(2020,1,101,82);
delete from yearsubstud where rollno=1 and mark=82;
insert into students(rollno,name)values(3,'dipali');

insert into yearsubstud(years,rollno,subcode,mark)values(2020,2,102,27);

delete from yearsubstud where mark=32; 

drop trigger marks_update;
































