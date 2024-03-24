CREATE TABLE Salespeople (
    snum INT PRIMARY KEY,
    sname VARCHAR(50),
    city VARCHAR(50),
    commission DECIMAL(8, 2)
);

CREATE TABLE Orders (
    onum INT PRIMARY KEY,
    odate DATE,
    snum INT,
    amt DECIMAL(10, 2),
    FOREIGN KEY (snum) REFERENCES Salespeople(snum)
);

CREATE TABLE Customers (
    cnum INT PRIMARY KEY,
    cname VARCHAR(50),
    city VARCHAR(50),
    rating INT,
    snum INT,
    FOREIGN KEY (snum) REFERENCES Salespeople(snum)
);
-- Inserting data into Salespeople table
INSERT INTO Salespeople (snum, sname, city, commission) VALUES
(1, 'John Doe', 'Pune', 0.12),
(2, 'Jane Smith', 'Mumbai', 0.12),
(3, 'Michael Johnson', 'Delhi', 0.12),
(4, 'Emily Brown', 'Pune', 0.12),
(5, 'David Lee', 'Chennai', 0.12);

-- Inserting data into Orders table
INSERT INTO Orders (onum, odate, snum, amt) VALUES
(101, '2024-02-01', 1, 500.00),
(102, '2024-02-05', 2, 750.00),
(103, '2024-02-10', 3, 1000.00),
(104, '2024-02-15', 4, 600.00),
(105, '2024-02-20', 5, 900.00);

-- Inserting data into Customers table
INSERT INTO Customers (cnum, cname, city, rating, snum) VALUES
(201, 'ABC Corporation', 'Mumbai', 120, 2),
(202, 'XYZ Enterprises', 'Pune', 90, 4),
(203, 'LMN Industries', 'Chennai', 150, 5),
(204, 'PQR Limited', 'Delhi', 80, 3),
(205, 'RST Corporation', 'Mumbai', 110, 2);

SELECT sname, city FROM Salespeople WHERE city = 'Pune';

SELECT DISTINCT snum FROM Orders;

SELECT * FROM Customers WHERE city = 'Mumbai' AND rating > 100;

SELECT * FROM Customers WHERE city IN ('Pune', 'Mumbai');

SELECT * FROM Customers WHERE city != 'Pune' OR rating <= 100;

SELECT * FROM Customers WHERE NOT (rating <= 100 AND city != 'Nagar');

SELECT sname FROM Salespeople WHERE sname LIKE 'G_A%';

SELECT * FROM Customers WHERE city IS NULL;

SELECT onum, o.snum, (amt * 0.12) AS commission 
FROM Orders o 
JOIN Salespeople s ON o.snum = s.snum;

SELECT COUNT(DISTINCT snum) AS unique_snum_count FROM Orders;

SELECT COUNT(*) AS order_count FROM Orders WHERE odate = '2024-02-05';

SELECT MAX(blnc + amt) AS max_outstanding_amount FROM Orders;

SELECT onum, odate FROM Orders ORDER BY odate;

SELECT city, MAX(rating) AS highest_rating FROM Customers GROUP BY city;

SELECT odate, SUM(amt) AS total_orders 
FROM Orders 
GROUP BY odate 
ORDER BY total_orders DESC;

ALTER TABLE Orders ADD COLUMN current_bal DECIMAL(10, 2);

UPDATE Salespeople SET commission = commission + 200;

SELECT o.onum, c.cname 
FROM Orders o 
JOIN Customers c ON o.snum = c.snum;

SELECT o.onum, (o.amt * s.commission) AS commission_amount 
FROM Orders o 
JOIN Salespeople s ON o.snum = s.snum 
JOIN Customers c ON o.snum = c.snum 
WHERE c.rating > 100;

SELECT * 
FROM Orders 
WHERE snum IN (SELECT snum FROM Customers WHERE cname = 'Gopal');

SELECT c.cname, c.rating 
FROM Customers c 
WHERE c.cnum IN (
    SELECT o.snum 
    FROM Orders o 
    GROUP BY o.snum 
    HAVING AVG(o.amt) > (
        SELECT AVG(amt) 
        FROM Orders
    )
);

SELECT cname, city, 
    CASE 
        WHEN rating >= 200 THEN 'High Rating' 
        ELSE 'Low Rating' 
    END AS rating_status
FROM Customers
UNION
SELECT sname, city, 
    CASE 
        WHEN commission >= 200 THEN 'High Commission' 
        ELSE 'Low Commission' 
    END AS rating_status
FROM Salespeople;

SELECT sname AS name, snum AS number 
FROM Salespeople 
WHERE snum IN (
    SELECT snum 
    FROM Orders 
    GROUP BY snum 
    HAVING COUNT(*) > 1
)
UNION
SELECT cname AS name, cnum AS number 
FROM Customers 
WHERE cnum IN (
    SELECT snum 
    FROM Orders 
    GROUP BY snum 
    HAVING COUNT(*) > 1
)
ORDER BY name;


-- Check data type of snum column in Salespeople table
DESC Salespeople;

-- Check data type of snum column in Orders table
DESC Orders;

-- Check existing values in snum column of Salespeople table
SELECT snum FROM Salespeople;

SELECT s.sname AS name, s.snum AS number
FROM Salespeople s
JOIN Orders o ON s.snum = o.snum
GROUP BY s.snum, s.sname
HAVING COUNT(o.onum) > 1
UNION
SELECT c.cname AS name, c.cnum AS number
FROM Customers c
JOIN Orders o ON c.cnum = o.cnum
GROUP BY c.cnum, c.cname
HAVING COUNT(o.onum) > 1
ORDER BY name;

CREATE VIEW Customers_Highest_Ratings AS
SELECT *
FROM Customers
WHERE rating = (SELECT MAX(rating) FROM Customers);

CREATE VIEW Salespeople_Count_By_City AS
SELECT city, COUNT(*) AS salespeople_count
FROM Salespeople
GROUP BY city;