use project_2;

#2.Create the Dept Table as below 

create table Dept(Deptno int primary key , 
dname varchar(25),
loc varchar(25)
);

insert into Dept values (10 , 'operations' , 'boston') ,
(20 , 'research' , 'dallas') ,
(30 , 'sales' , 'chicago') , 
(40 , 'accounting' , 'new york');

select * from Dept;

#1.	Create the Employee Table as per the Below Data Provided

create table employee (empno int primary key ,
ename varchar(20),
job varchar(25) default 'clerk',
mgr int,
hiredate date,
sal int check(sal>0),
commision int, 
deptno int, foreign key (Deptno) references Dept(Deptno)
);

insert into employee(empno,ename,job,mgr,hiredate,sal,commision,deptno) 
values (7369,'smith','clerk',7902,'1890-12-17',800,null,20),
(7499,'Allen','Salesman',7698,'1981-02-20',1600,300,20),
(7521,'Ward','Salesman',7698,'1981-02-22',1250,500,30),
(7566,'Jones','Manager',7839,'1981-04-02',1975,null,20),
(7654,'Martin','Salesman',7698,'1981-09-28',1250,1400,30),
(7698,'Blake','Manager',7839,'1981-05-01',2850,null,30),
(7782,'Clark','Manager',7839,'1981-06-09',2450,null,10),
(7788,'Scott','Analyst',7566,'1987-04-19',3000,null,20),
(7839,'King','Presedent',null,'1981-11-17',5000,null,10),
(7844,'Turner','Salesman',7698,'1981-09-08',1500,0,30),
(7876,'Adams','Clerk',7788,'1987-05-23',100,null,20),
(7900,'James','Clerk',7698,'1981-12-03',950,null,30),
(7902,'Ford','Analyst',7566,'1981-12-03',3000,null,20),
(7934,'Miller','Clerk',7782,'1982-01-23',1300,null,10);

select * from employee;

#3.	List the Names and salary of the employee whose salary is greater than 1000
 
select ename , sal from employee where sal>1000;

#4.	List the details of the employees who have joined before end of September 81 

select ename from employee where hiredate < '1981-09-30';

#5.	List Employee Names having I as second character.

select ename from employee where ename like '_i%';

#6.	List Employee Name, Salary, Allowances (40% of Sal), P.F. (10 % of Sal) and Net Salary. Also assign the alias name for the columns

select ename,sal,
sal/100*40  as allowances ,
sal/100*10 as PF,
sal+sal/100*40+sal/100*10 as net_salary 
from employee;

#7. List Employee Names with designations who does not report to anybody

select ename , job from employee where mgr is null;

#8.	List Empno, Ename and Salary in the ascending order of salary.

select empno , ename , sal from employee order by  sal asc;

#9.	How many jobs are available in the Organization 

select count(job) as 'available_job' from employee;

#10. Determine total payable salary of salesman category

select sum(sal) from employee where job ='salesman';

#11.	List average monthly salary for each job within each department   

select deptno,job,avg(sal) from employee group by job,deptno order by sal asc;

#12. Use the Same EMP and DEPT table used in the Case study to Display EMPNAME, SALARY and DEPTNAME in which the employee is working.

select e.empno,e.ename as empname,e.sal,d.dname as deptname from employee as e join dept as d on (e.Deptno=d.Deptno);

#13. Create the Job Grades Table as below

create table job_grades (grade varchar(2) , lowest_sal int , highest_sal int);
insert into job_grades values ('A' , 0 , 999) , 
('B' , 1000 , 1999), ('C' , 2000 , 2999) ,
('D' , 3000 , 3999) , ('E' , 4000 , 5000);

select * from job_grades;

#14. Display the last name, salary and  Corresponding Grade.

select e.ename , e.sal , j.grade
 FROM employee e
   JOIN job_grades j
     ON e.sal BETWEEN j.lowest_sal AND j.highest_sal;
     
#15. Display the Emp name and the Manager name under whom the Employee works in the below format .

select t2.ename,t1.ename from employee as t1 join employee as t2 on (t1.empno=t2.mgr); 

#16 .Display Empname and Total sal where Total Sal (sal + Comm)

select ename, sal+commision as total_sal from employee group by empno;

#17. Display Empname and Sal whose empno is a odd number

select empno,ename from employee where mod(empno,2)=1;

# 18. Display Empname , Rank of sal in Organisation , Rank of Sal in their department

select ename as employee,sal as salary, rank() over (order by sal desc) as overall_rank,rank() over (partition by deptno order by sal desc) as deptwise_rank from employee;

#19. Display Top 3 Empnames based on their Salary

select empno, ename, sal from employee order by sal desc limit 3;

#20. Display Empname who has highest Salary in Each Department.

SELECT ename,deptno, max(SAL) FROM EMPLOYEE group by deptno;