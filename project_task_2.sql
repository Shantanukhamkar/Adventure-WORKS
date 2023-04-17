use project_2;

#1 . Create the Salespeople table?
create table salespeople(snum int , sname varchar(20) , city varchar(25) , comm float);

insert into salespeople values (1001 ,'peel' , 'london', 0.12) ,
 (1002 , 'serres' , 'san jose' , 0.13),
 (1003 , 'axelrod' , 'new york' , 0.10),
 (1004 , 'motika' , 'london' , 0.11),
 (1007 , 'rafkin' , 'barcelona' , 0.15);
 
 select * from salespeople;
 
 #2.Create the Cust Table

create table Cust(Cnum int primary key, Cname varchar(20), City varchar(25),rating int, Snum int);
insert into cust values (2001,'Hoffman','London','100',1001),
(2002,'Giovanne','Rome','200',1003),
(2003,'Liu','San Jose','300',1002),
(2004,'Grass','Berlin','100',1002),
(2006,'Clemens','London','300',1007),
(2007,'Pereira','Rome','100', 1004),
(2008,'James','London','200',1007);
select * from cust;

#3.Create orders table ?
create table Orders(Onum int primary key, Amt float, Odate date, Cnum int, Snum int);
insert into Orders values (3001,'18.69','1994-10-03','2008',1007),
(3002,'1900.10' ,'1994-10-03','2007',1004),
(3003,'767.19','1994-10-03','2001',1001),
(3005,'5160.45','1994-10-03','2003',1002),
(3006,'1098.16','1994-10-04','2008',1007),
(3007,'75.75','1994-10-05','2004', 1002),
(3008,'4723.00','1994-10-05','2006',1001),
(3009,'1713.23','1994-10-04','2002',1003),
(3010,'1309.95','1994-10-06', '2004',1002),
(3011,'9891.88','1994-10-06','2006',1001);
select * from Orders;

#4.Write a query to match the salespeople to the customers according to the city they are living?
Select Cust.Cname, Cust.City,
Salespeople.Sname 
From Salespeople
inner join Cust
on Salespeople.City=Cust.City;

#5.Write a query to select the names of customers and the salespersons who are providing service to them?
Select Cust.Cname,
Salespeople.Sname
From Salespeople,Cust
WHERE Salespeople.Snum = Cust.Snum;

#6.	Write a query to find out all orders by customers not located in the same cities as that of their salespeople?
SELECT Onum,orders.Cnum, orders.Snum
FROM salespeople, cust, orders
WHERE cust.City <> salespeople.City
AND orders.Cnum = cust.Cnum
AND orders.Snum= salespeople.Snum;

#7.	Write a query that lists each order number followed by name of customer who made that order?
SELECT orders.Onum,cust.Cname
FROM orders,cust
WHERE orders.Cnum = cust.Cnum; 

#8.	Write a query that finds all pairs of customers having the same rating ?
Select Cust.Cname
  From Cust Group by Rating Having count(*)>1;
# OR  
  Select a.Cname, b.Cname, a.Rating
From Cust a, Cust b
Where a.Rating= b.Rating 
And a.Cnum != b.Cnum;

# 9.Write a query to find out all pairs of customers served by a single salesperson?
select a.snum,b.sname,count(*) as cust_count
    from cust a, salespeople b
    where a.snum=b.snum 
    group by a.snum;
    
    Select cname from cust
where snum in (select snum
                from cust
                group by snum
                having count(snum) > 1);
	
# 10.Write a query that produces all pairs of salespeople who are living in same city?
SELECT m.Sname,
       n.Sname,
       m.City
FROM salespeople m,
     Salespeople n
WHERE m.City=n.City
  AND m.Sname<n.Sname;
  
# 11.	Write a Query to find all orders credited to the same salesperson who services Customer 2008?
  SELECT * 
FROM orders
WHERE Snum =
    (SELECT DISTINCT Snum
     FROM orders 
     WHERE Cnum =2008);
     
#12. Write a Query to find out all orders that are greater than the average for Oct 4th
SELECT * 
FROM orders
WHERE Amt >
    (SELECT  AVG(Amt) 
     FROM orders 
     WHERE Odate ='1994-10-04');
     
#13.Write a Query to find all orders attributed to salespeople in London?
SELECT * 
FROM orders
WHERE Snum IN
    (SELECT Snum
     FROM Salespeople
     WHERE City='London');
     
#14. Write a query to find all the customers whose cnum is 1000 above the snum of Serres?
 Select Cnum, Cname 
from cust 
where Cnum > ( select Snum+1000 from salespeople where Sname = 'Serres');

# 15.Write a query to count customers with ratings above San Jose’s average rating.
Select Cnum, rating 
from cust 
 where rating > ( select avg(rating) 
  from cust where City = 'San Jose');
  
#16.Write a query to show each salesperson with multiple customers?
SELECT * FROM Salespeople
WHERE Snum IN (
   SELECT DISTINCT Snum 
   FROM Cust a 
   WHERE EXISTS (
      SELECT * 
      FROM Cust b 
      WHERE b.Snum=a.Snum
      AND b.Cname<>a.Cname));
