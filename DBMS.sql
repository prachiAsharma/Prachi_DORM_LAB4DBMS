DROP SCHEMA IF EXISTS eCommerce;
CREATE SCHEMA eCommerce;
USE eCommerce;
CREATE TABLE supplier(
SUPP_ID	INT Primary key,
SUPP_NAME varchar(50) NOT NULL,
SUPP_CITY varchar(50) NOT NULL,
SUPP_PHONE	varchar(50) NOT NULL
);
CREATE TABLE customer(
CUS_ID	INT Primary Key,
CUS_NAME	VARCHAR(20) NOT NULL,
CUS_PHONE	varchar(10) NOT NULL,
CUS_CITY	VARCHAR(30) NOT NULL,
CUS_GENDER	CHAR
);
CREATE TABLE category(
CAT_ID	INT Primary Key,
CAT_NAME	VARCHAR(20) NOT NULL
);
CREATE TABLE product(
PRO_ID	INT Primary Key,
PRO_NAME	VARCHAR(20) NOT NULL DEFAULT "Dummy",
PRO_DESC	VARCHAR(60),
CAT_ID INT ,
FOREIGN Key (CAT_ID ) REFERENCES category (CAT_ID)
);
CREATE TABLE supplier_pricing(
PRICING_ID	INT Primary Key,
PRO_ID	INT,
FOREIGN KEY (PRO_ID) REFERENCES product(PRO_ID),
SUPP_ID	INT ,
foreign key  (SUPP_ID) REFERENCES supplier(SUPP_ID),
SUPP_PRICE	INT DEFAULT 0
);

CREATE TABLE Oorder(
ORD_ID	INT PRIMARY KEY,
ORD_AMOUNT	INT NOT NULL,
ORD_DATE	DATE NOT NULL,
CUS_ID INT,
FOREIGN KEY (CUS_ID) REFERENCES customer(CUS_ID),
PRICING_ID	INT,
FOREIGN KEY(PRICING_ID) REFERENCES supplier_pricing (PRICING_ID)
);
CREATE TABLE rating(
RAT_ID	INT PRIMARY KEY,
ORD_ID	INT,
FOREIGN KEY(ORD_ID) REFERENCES Oorder(ORD_ID),
RAT_RATSTARS INT NOT NULL
);
INSERT INTO supplier VALUES(1,'RajeshRetails','Delhi',1234567890),(2,'ApparioLtd','Mumbai',2589631470),(3,'Knomeproduct','Banglore',9785462315),(4,'BansalRetails','Kochi',8975463285),(5,'MittalLtd','Lucknow',7898456532);
COMMIT;

INSERT INTO  customer VALUES 
(1,'AAKASH',9999,'DELHI','M'),
(2,'AMAN',9785,'NOIDA','M'),
(3,'NEHA',9999,'MUMBAI','F'),
(4,'MEGHA',9994,'KOLKATA','F'),
(5,'PULKIT',7895,'LUCKNOW','M');
COMMIT;

INSERT INTO category VALUES 
(1,'BOOKS'),
(2,'GAMES'),
(3,'GROCERIES'),
(4,'ELECTRONICS'),
(5,'CLOTHES');
COMMIT;

INSERT INTO product VALUES
(1,'GTA V',	'Windows 7 and above with i5 processor and 8GB RAM',2),
(2,'TSHIRT','SIZE-L with Black, Blue and White variations',	5),
(3,'ROG LAPTOP','Windows 10 with 15inch screen, i7 processor, 1TB SSD',4),
(4,'OATS','Highly Nutritious from Nestle',3),
(5,'HARRY POTTER','Best Collection of all time by J.K Rowling',1),
(6,'MILK','1L Toned MIlk',3),
(7,'Boat Earphones','1.5Meter long Dolby Atmos',4),
(8,'Jeans','Stretchable Denim Jeans with various sizes and color',5),
(9,'Project IGI','compatible with windows 7 and above',2),
(10,'Hoodie','Black GUCCI for 13 yrs and above',5),
(11,'Rich Dad Poor Dad','Written by RObert Kiyosaki',1),
(12,'Train Your Brain','By Shireen Stephen',1);
COMMIT;

INSERT INTO Supplier_pricing VALUES
(1,	1,2,1500),
(2,3,5,30000),
(3,5,1,3000),
(4,2,3,2500),
(5,4,1,1000);
COMMIT;

INSERT INTO Oorder VALUES
(101,1500,'2021-10-06',2,1),
(102,1000,'2021-10-12',3,5),
(103,30000,'2021-09-16',5,2),
(104,1500,'2021-10-05',1,1),
(105,3000,'2021-08-16',4,3),
(106,1450,'2021-08-18',1,9),
(107,789,'2021-09-01',3,7),
(108,780,'2021-09-07',5,6),
(109,3000,'2021-00-10',5,3),
(110,2500,'2021-09-10',2,4),
(111,1000,'2021-09-15',4,5),
(112,789,'2021-09-16',4,7),
(113,31000,'2021-09-16',1,8),
(114,1000,'2021-09-16',3,5),		
(115,3000,'2021-09-16',5,3),
(116,99,'2021-09-17',2,14);
COMMIT;

SET FOREIGN_KEY_CHECKS=0;

INSERT INTO rating VALUES 
(1,101,4),
(2,102,3),
(3,103,1),
(4,104,2),
(5,105,4),
(6,106,3),
(7,107,4),
(8,108,4),
(9,109,3),
(10,110,5),
(11,111,3),
(12,112,4),
(13,113,2),
(14,114,1),
(15,115,1),
(16,116,0);		
COMMIT;

-- 3)	Display the total number of customers based on gender who have placed orders of worth at least Rs.3000

select count(*), c.CUS_GENDER from customer as c inner join `oorder` as o on c.CUS_ID = o.CUS_ID 
where o.ORD_AMOUNT>=3000 group by c.CUS_GENDER;


-- 4)	Display all the orders along with product name ordered by a customer having Customer_Id=2

select supplier.SUPP_NAME, product.PRO_NAME, supplier_pricing.PRICING_ID, `oorder`.ORD_ID, customer.CUS_NAME from `Oorder` 
inner join customer on `oorder`.CUS_ID=customer.CUS_ID 
inner join supplier_pricing on `oorder`.PRICING_ID=supplier_pricing.PRICING_ID
inner join supplier on supplier.SUPP_ID=supplier_pricing.SUPP_ID
inner join product on supplier_pricing.PRO_ID=product.PRO_ID
where `oorder`.CUS_ID=2;


-- 5)	Display the Supplier details who can supply more than one product.

select s.SUPP_NAME, count(p.PRO_NAME) as product_count from supplier as s inner join supplier_pricing as sp on s.SUPP_ID=sp.SUPP_ID
inner join product as p on p.PRO_ID=sp.PRO_ID group by s.SUPP_NAME having count(p.PRO_NAME)>1;


-- 6)	Find the least expensive product from each category and print the table with category id, name, product name and price of the product

select p.PRO_NAME, min(sp.SUPP_PRICE), sp.SUPP_ID from product as p inner join supplier_pricing as sp on p.PRO_ID=sp.PRO_ID
group by p.PRO_ID;

select * from supplier where SUPP_ID=5;
select PRO_ID, min(SUPP_PRICE) from supplier_pricing group by PRO_ID, SUPP_ID;

select cat.CAT_ID, cat.CAT_NAME, p.PRO_NAME, sp.SUPP_PRICE from category as cat
inner join product as p on cat.CAT_ID=p.CAT_ID
inner join supplier_pricing as sp on sp.PRO_ID=p.PRO_ID
group by cat.CAT_NAME having min(sp.SUPP_PRICE);


-- 7)	Display the Id and Name of the Product ordered after “2021-10-05”.

select PRICING_ID from `Oorder` where ORD_DATE > '2021-10-05';
select PRO_ID from supplier_pricing where PRICING_ID in (select PRICING_ID from `Oorder` where ORD_DATE > '2021-10-05');
select PRO_ID, PRO_NAME from product where PRO_ID in (select PRO_ID from supplier_pricing where PRICING_ID in (select PRICING_ID from `Oorder` where ORD_DATE > '2021-10-05'));


-- 8)	Display customer name and gender whose names start or end with character 'A'.

select CUS_NAME, CUS_GENDER from customer where CUS_NAME like "A%" or CUS_NAME like "%A";

-- 9)	Create a stored procedure to display supplier id, name, rating and Type_of_Service. For Type_of_Service, If rating =5, print “Excellent Service”,If rating >4 print “Good Service”, If rating >2 print “Average Service” else print “Poor Service”.

select `Oorder`.PRICING_ID, avg(rating.RAT_RATSTARS) as rating, case 
when avg(rating.RAT_RATSTARS)=5 then 'Excellent Service'
when avg(rating.RAT_RATSTARS)>4 then 'Good Service'
when avg(rating.RAT_RATSTARS)>2 then 'Average Service'
else 'Poor Service' end as Type_of_Service from `Oorder` 
inner join rating where `Oorder`.ORD_ID=rating.ORD_ID group by `Oorder`.PRICING_ID;
