CREATE DATABASE PROJECT;
USE PROJECT;
CREATE TABLE EMPLOYEE(
            EMPLOYEE_ID INT(4) NOT NULL PRIMARY KEY DEFAULT 0,
            EMPLOYEE_NAME VARCHAR(10),
            JOB VARCHAR(9),
            MGR INT(4),
		    HIRE_DATE DATE,
            SALARY DECIMAL(7,2),
            COMM DECIMAL(7,2),
            DEPT_NO INT(2) 
            );

CREATE TABLE DEPARTMENT(
		    DEPT_NO INT(2) NOT NULL PRIMARY KEY DEFAULT 0,
            DEPT_NAME VARCHAR(14),
            LOCATION VARCHAR(13)
            );

CREATE TABLE STUDENT(
            R_NO INT(2) NOT NULL PRIMARY KEY DEFAULT 0,
            SNAME VARCHAR(14),
            CITY VARCHAR(20),
            STATE VARCHAR(20)
            );
            
CREATE TABLE EMPLOYEE_LOG(
            EMPLOYEE_ID INT(4) NOT NULL,
            LOG_DATE DATE,
            NEW_SALARY INT(10),
            ACTION_ VARCHAR(20)
            );
INSERT INTO DEPARTMENT
VALUES(10,"ACCOUNTING","NEWYORK"),
	  (20,"RESEARCH","DALLAS"),
      (30,"SALES","CHICAGO"),
      (40,"OPERATIONS","BOSTON");

SELECT DEPT_NAME,DEPT_NO FROM DEPARTMENT;

INSERT INTO EMPLOYEE
VALUES(7369,"SMITH","CLERK",7902,"1980-12-17",800.00,NULL,20),
      (7499,"ALLEN","SALESMAN",7698,"1981-02-20",1600.00,300.00,30),
      (7521,"WARD","SALESMAN",7698,"1981-02-22",1250.00,500.00,30),
      (7566,"JONES","MANAGER",7839,"1981-04-02",2975.00,NULL,20),
      (7654,"MARTIN","SALESMAN",7698,"1981-09-28",1250.00,1400.00,30),
      (7698,'BLAKE','MANAGER', 7839, '1981-05-01', 2850.00, NULL, 30),
	  (7782,'CLARK','MANAGER', 7839, '1981-06-09', 2450.00, NULL, 10),
      (7788,'SCOTT','ANALYST', 7566, '1987-06-11', 3000.00, NULL, 20),
      (7839,'KING','PRESIDENT', NULL, '1981-11-17', 5000.00, NULL, 10),
      (7844,'TURNER',"SALESMAN", 7698, '1981-08-09', 1500.00, 0.00, 30),
      (7876,'ADAMS','CLERK', 7788, '1987-07-13', 1100.00, NULL, 20),
	  (7900,'JAMES','CLERK', 7698, '1981-03-12', 950.00, NULL, 30),
      (7902,'FORD','ANALYST', 7566, '1981-03-12', 3000.00, NULL, 20),
      (7934,'MILLER','CLERK', 7782, '1982-01-23', 1300.00, NULL, 10);
      
/* Q1 Select unique job from EMP table.*/


SELECT DISTINCT  JOB FROM EMPLOYEE; 


/* Q2 List the details of the emps in asc order of the Dptnos and desc of Jobs?*/

SELECT * FROM EMPLOYEE
ORDER BY DEPT_NO ASC,
         JOB DESC;

/* Q3 . Display all the unique job groups in the descending order?*/

SELECT DISTINCT JOB FROM EMPLOYEE
ORDER BY JOB DESC;

/* Q4 List the emps who joined before 1981.*/

SELECT * FROM EMPLOYEE
WHERE HIRE_DATE < "1981-01-01";

/* Q5 List the Empno, Ename, Sal, Daily sal of all emps in the asc order of 
Annsal.*/
SELECT EMPLOYEE_ID,
	   EMPLOYEE_NAME,
       SALARY,
       (SALARY/30) AS DAILY_SALARY,
       (SALARY*12) AS ANNUAL_SALARY
FROM EMPLOYEE
ORDER BY ANNUAL_SALARY ASC;   

/* Q6 List the Empno, Ename, Sal, Exp of all emps working for Mgr 7369.*/

SELECT EMPLOYEE_ID,
       EMPLOYEE_NAME,
       SALARY,
       DATEDIFF(CURRENT_DATE(),HIRE_DATE) AS EXPERIENCE
FROM EMPLOYEE
WHERE MGR = 7698;       
         
/* Q7 Display all the details of the emps who’s Comm. Is more than their Sal?*/

SELECT * FROM EMPLOYEE
WHERE COMM > SALARY;

/* Q8 List the emps who are either ‘CLERK’ or ‘ANALYST’ in the Desc order.*/

SELECT * FROM EMPLOYEE
WHERE  JOB IN("CLERK","ANALYST")
ORDER BY JOB DESC;

/* Q9 List the emps Who Annual sal ranging from 22000 and 45000.*/

SELECT 
    EMPLOYEE_ID,
    EMPLOYEE_NAME,
    JOB,
    (SALARY * 12) AS ANNUAL_SALARY
FROM
    EMPLOYEE
WHERE
    (SALARY * 12) BETWEEN 22000 AND 45000;
         
	     
/* Q10 List the Enames those are starting with ‘S’ and with five characters.*/

SELECT EMPLOYEE_NAME FROM EMPLOYEE
WHERE EMPLOYEE_NAME LIKE "S____";   


/* Q11 List the emps whose Empno not starting with digit78.*/

SELECT * FROM EMPLOYEE
WHERE EMPLOYEE_ID NOT LIKE ("78%");            
            
/* Q12 List all the Clerks of Deptno 20.*/

SELECT * FROM EMPLOYEE 
WHERE JOB = "CLERK" AND DEPT_NO = 20;            
            
/* Q13 List the Emps who are senior to their own MGRS.*/            
            
SELECT E.EMPLOYEE_ID AS EMP_ID,
	   E.EMPLOYEE_NAME AS EMP_NAME,
       E.HIRE_DATE AS EMP_HIREDATE,
       M.EMPLOYEE_ID AS MANAGER_ID,
       M.EMPLOYEE_NAME AS MANAGER_NAME,
       M.HIRE_DATE AS MANAGER_HIREDATE
FROM EMPLOYEE E
JOIN EMPLOYEE M
 ON E.MGR = M.EMPLOYEE_ID
WHERE E.HIRE_DATE>M.HIRE_DATE;
       
/* Q14 4. List the Emps of Deptno 20 who’s Jobs are same as Deptno10.*/

SELECT EMPLOYEE_ID,
       EMPLOYEE_NAME,
       JOB,
       DEPT_NO
FROM EMPLOYEE
WHERE DEPT_NO = 20 AND 
      JOB  IN(SELECT DISTINCT JOB
             FROM EMPLOYEE
             WHERE DEPT_NO = 10);

/* Q15 List the Emps who’s Sal is same as FORD or SMITH in desc order of Sal.*/

SELECT EMPLOYEE_ID,
       EMPLOYEE_NAME,
       JOB,
       DEPT_NO,
       SALARY
FROM EMPLOYEE
WHERE SALARY IN(SELECT SALARY
				FROM EMPLOYEE
				WHERE EMPLOYEE_NAME IN("FORD","SMITH")
                )
ORDER BY SALARY DESC;                

/* Q16 List the emps whose jobs same as SMITH or ALLEN.*/

SELECT EMPLOYEE_ID,
       EMPLOYEE_NAME,
       DEPT_NO,
       JOB
FROM EMPLOYEE
WHERE JOB IN(SELECT JOB 
             FROM EMPLOYEE 
             WHERE EMPLOYEE_NAME IN("SMITH","ALLEN")
             );
      
/* Q17 Any jobs of deptno 10 those that are not found in deptno 20.*/

SELECT DEPT_NO,
       JOB 
FROM EMPLOYEE
WHERE DEPT_NO=10 AND 
      JOB NOT IN(SELECT JOB 
                 FROM EMPLOYEE
                 WHERE DEPT_NO = 20
                 );
 
/* Q18 Find the highest sal of EMP table.*/

SELECT MAX(SALARY)
FROM EMPLOYEE;

/* Q19 Find details of highest paid employee.*/

SELECT * 
FROM EMPLOYEE
WHERE SALARY = ( SELECT MAX(SALARY)
                 FROM EMPLOYEE
                 );
       
/* Q20 Find the total sal given to the MGR.*/

SELECT SUM(SALARY) AS TOTAL_SALARY
FROM EMPLOYEE
WHERE JOB = "MANAGER";

/* Q21 . List the emps whose names contains ‘A’.*/

SELECT * 
FROM EMPLOYEE
WHERE EMPLOYEE_NAME LIKE "%A%";
            
/* Q22 . Find all the emps who earn the minimum Salary for each job wise in
ascending order.*/

SELECT * 
FROM EMPLOYEE E
WHERE SALARY = ( SELECT MIN(SALARY)
                 FROM EMPLOYEE
                 WHERE JOB = E.JOB
                 )
ORDER BY JOB ASC,
	     SALARY ASC;
                 
/* Q23 . List the emps whose sal greater than Blake’s sal.*/

SELECT * 
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMPLOYEE_NAME = "BLAKE"
                );

/* Q24 Create view v1 to select ename, job, dname, loc whose deptno are
same.*/

CREATE VIEW V1 AS
SELECT E.EMPLOYEE_NAME,
       E.JOB,
       D.DEPT_NAME,
       D.LOCATION
FROM EMPLOYEE E
INNER JOIN  DEPARTMENT D
ON E.DEPT_NO=D.DEPT_NO;   
       
 SELECT * FROM V1;      

/* Q25 Create a procedure with dno as input parameter to fetch ename and
dname.*/

DELIMITER $$
CREATE PROCEDURE GET_ENAME_DNAME(IN DNO INT)
BEGIN 
	  SELECT E.EMPLOYEE_NAME AS ENAME,
             D.DEPT_NAME AS DNAME
      FROM EMPLOYEE E
      INNER JOIN DEPARTMENT D
      ON E.DEPT_NO = D.DEPT_NO
      WHERE E.DEPT_NO = DNO;
END$$

DELIMITER ;      
CALL GET_ENAME_DNAME(10);

/* Q26 Add column Pin with bigint data type in table student*/

ALTER TABLE STUDENT
ADD PIN BIGINT ;

/* Q27 Modify the student table to change the sname length from 14 to 40.*/

ALTER TABLE STUDENT
MODIFY COLUMN SNAME VARCHAR(40);



/* Q28 Create trigger to insert data in emp_log table whenever any update of sal 
in EMP table. You can set action as ‘New Salary’.*/


DELIMITER $$
CREATE TRIGGER NEW_SALARY
AFTER UPDATE ON EMPLOYEE
FOR EACH ROW 
BEGIN
     IF OLD.SALARY<>NEW.SALARY THEN
     INSERT INTO EMPLOYEE_LOG(EMPLOYEE_ID,LOG_DATE,NEW_SALARY,ACTION_)
     VALUES(NEW.EMPLOYEE_ID,NOW(),NEW.SALARY,"NEW SALARY");
     END IF;
END$$
DELIMITER ;	
     
UPDATE EMPLOYEE
SET SALARY = 2000
WHERE EMPLOYEE_ID = 7369;        

SELECT * FROM EMPLOYEE_LOG;









                 
            
