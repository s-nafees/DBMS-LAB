Enter password: *****
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 16
Server version: 8.0.36 MySQL Community Server - GPL

Copyright (c) 2000, 2024, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> CREATE DATABASE MEAL;
Query OK, 1 row affected (0.00 sec)

mysql> USE MEAL;
Database changed

mysql> CREATE TABLE Customer (
    ->     CustomerID INT PRIMARY KEY,
    ->     Name VARCHAR(50),
    ->     PhoneNumber VARCHAR(15),
    ->     DeliveryAddress VARCHAR(100)
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql> CREATE TABLE Driver (
    ->     DriverID INT PRIMARY KEY,
    ->     Name VARCHAR(50),
    ->     PhoneNumber VARCHAR(15),
    ->     AvailabilityStatus VARCHAR(20)
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql> CREATE TABLE OrderTable (
    ->     OrderID INT PRIMARY KEY,
    ->     CustomerID INT,
    ->     DriverID INT,
    ->     OrderTime DATETIME,
    ->     TotalPrice DECIMAL(10, 2),
    ->     DeliveryStatus VARCHAR(20),
    ->     FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    ->     FOREIGN KEY (DriverID) REFERENCES Driver(DriverID)
    -> );
Query OK, 0 rows affected (0.02 sec)

mysql> CREATE TABLE Meal (
    ->     MealID INT PRIMARY KEY,
    ->     MealName VARCHAR(50),
    ->     Price DECIMAL(10, 2),
    ->     RestaurantID INT
    -> );
Query OK, 0 rows affected (0.02 sec)

mysql> CREATE TABLE Restaurant (
    ->     RestaurantID INT PRIMARY KEY,
    ->     Name VARCHAR(50),
    ->     Location VARCHAR(50),
    ->     PhoneNumber VARCHAR(15)
    -> );
Query OK, 0 rows affected (0.02 sec)

mysql> CREATE TABLE OrderMeal (
    ->     OrderID INT,
    ->     MealID INT,
    ->     Quantity INT,
    ->     PRIMARY KEY (OrderID, MealID),
    ->     FOREIGN KEY (OrderID) REFERENCES OrderTable(OrderID),
    ->     FOREIGN KEY (MealID) REFERENCES Meal(MealID)
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql> CREATE TABLE MealRating (
    ->     RatingID INT PRIMARY KEY,
    ->     MealID INT,
    ->     CustomerID INT,
    ->     RatingScore INT,
    ->     RatingRemarks VARCHAR(255),
    ->     FOREIGN KEY (MealID) REFERENCES Meal(MealID),
    ->     FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
    -> );
Query OK, 0 rows affected (0.05 sec)

mysql> INSERT INTO Customer (CustomerID, Name, PhoneNumber, DeliveryAddress) VALUES
    -> (101, 'Alice Smith', '555-1234', '123 Elm St, City A'),
    -> (102, 'Bob Johnson', '555-5678', '456 Oak St, City B'),
    -> (103, 'Charlie Lee', '555-8765', '789 Pine St, City C'),
    -> (104, 'Diana Brown', '555-4321', '321 Maple St, City D'),
    -> (105, 'Emma White', '555-1122', '654 Birch St, City E');
Query OK, 5 rows affected (0.00 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Driver (DriverID, Name, PhoneNumber, AvailabilityStatus) VALUES
    -> (201, 'Mike Green', '555-2134', 'Available'),
    -> (202, 'Sara Lee', '555-3245', 'Not Available'),
    -> (203, 'John Black', '555-4356', 'Available'),
    -> (204, 'Lily White', '555-5467', 'Available'),
    -> (205, 'James Brown', '555-6578', 'Not Available');
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> INSERT INTO OrderTable (OrderID, CustomerID, DriverID, OrderTime, TotalPrice, DeliveryStatus) VALUES
    -> (1, 101, 201, '2024-12-30 10:00:00', 30.00, 'Delivered'),
    -> (2, 102, 202, '2024-12-30 11:00:00', 40.00, 'Delivered'),
    -> (3, 103, 203, '2024-12-30 12:00:00', 25.00, 'In Progress'),
    -> (4, 104, 204, '2024-12-30 13:00:00', 50.00, 'Delivered'),
    -> (5, 105, 201, '2024-12-31 10:00:00', 35.00, 'Pending'),
    -> (6, 102, 202, '2024-12-31 11:30:00', 45.00, 'Delivered'),
    -> (7, 101, 201, '2024-12-31 15:00:00', 20.00, 'Delivered');
Query OK, 7 rows affected (0.01 sec)
Records: 7  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Meal (MealID, MealName, Price, RestaurantID) VALUES
    -> (301, 'Pepperoni Pizza', 12.00, 1),
    -> (302, 'Veggie Burger', 8.00, 2),
    -> (303, 'Biryani', 15.00, 3),
    -> (304, 'Paneer Tikka', 10.00, 4),
    -> (305, 'Caesar Salad', 7.00, 5);
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Restaurant (RestaurantID, Name, Location, PhoneNumber) VALUES
    -> (1, 'Pizza Palace', 'City A', '555-7890'),
    -> (2, 'Burger Barn', 'City B', '555-2345'),
    -> (3, 'Biryani House', 'City C', '555-6789'),
    -> (4, 'Indian Spice', 'City D', '555-1234'),
    -> (5, 'Green Garden', 'City E', '555-5678');
Query OK, 5 rows affected (0.00 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> INSERT INTO OrderMeal (OrderID, MealID, Quantity) VALUES
    -> (1, 301, 2),
    -> (1, 302, 1),
    -> (2, 303, 1),
    -> (2, 304, 2),
    -> (3, 305, 3),
    -> (4, 301, 1),
    -> (5, 303, 2),
    -> (6, 302, 3),
    -> (7, 305, 1);
Query OK, 9 rows affected (0.01 sec)
Records: 9  Duplicates: 0  Warnings: 0

mysql> INSERT INTO MealRating (RatingID, MealID, CustomerID, RatingScore, RatingRemarks) VALUES
    -> (1, 301, 101, 4, 'Good, but could be hotter.'),
    -> (2, 302, 102, 5, 'Delicious! Will order again.'),
    -> (3, 303, 103, 3, 'The taste was average.'),
    -> (4, 304, 104, 5, 'Perfect, very flavorful.'),
    -> (5, 305, 105, 4, 'Fresh and light, great salad.');
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM Customer;
+------------+-------------+-------------+----------------------+
| CustomerID | Name        | PhoneNumber | DeliveryAddress      |
+------------+-------------+-------------+----------------------+
|        101 | Alice Smith | 555-1234    | 123 Elm St, City A   |
|        102 | Bob Johnson | 555-5678    | 456 Oak St, City B   |
|        103 | Charlie Lee | 555-8765    | 789 Pine St, City C  |
|        104 | Diana Brown | 555-4321    | 321 Maple St, City D |
|        105 | Emma White  | 555-1122    | 654 Birch St, City E |
+------------+-------------+-------------+----------------------+
5 rows in set (0.00 sec)

mysql> SELECT * FROM Driver;
+----------+-------------+-------------+--------------------+
| DriverID | Name        | PhoneNumber | AvailabilityStatus |
+----------+-------------+-------------+--------------------+
|      201 | Mike Green  | 555-2134    | Available          |
|      202 | Sara Lee    | 555-3245    | Not Available      |
|      203 | John Black  | 555-4356    | Available          |
|      204 | Lily White  | 555-5467    | Available          |
|      205 | James Brown | 555-6578    | Not Available      |
+----------+-------------+-------------+--------------------+
5 rows in set (0.00 sec)

mysql> SELECT * FROM OrderTable;
+---------+------------+----------+---------------------+------------+----------------+
| OrderID | CustomerID | DriverID | OrderTime           | TotalPrice | DeliveryStatus |
+---------+------------+----------+---------------------+------------+----------------+
|       1 |        101 |      201 | 2024-12-30 10:00:00 |      30.00 | Delivered      |
|       2 |        102 |      202 | 2024-12-30 11:00:00 |      40.00 | Delivered      |
|       3 |        103 |      203 | 2024-12-30 12:00:00 |      25.00 | In Progress    |
|       4 |        104 |      204 | 2024-12-30 13:00:00 |      50.00 | Delivered      |
|       5 |        105 |      201 | 2024-12-31 10:00:00 |      35.00 | Pending        |
|       6 |        102 |      202 | 2024-12-31 11:30:00 |      45.00 | Delivered      |
|       7 |        101 |      201 | 2024-12-31 15:00:00 |      20.00 | Delivered      |
+---------+------------+----------+---------------------+------------+----------------+
7 rows in set (0.00 sec)

mysql> SELECT * FROM Meal;
+--------+-----------------+-------+--------------+
| MealID | MealName        | Price | RestaurantID |
+--------+-----------------+-------+--------------+
|    301 | Pepperoni Pizza | 12.00 |            1 |
|    302 | Veggie Burger   |  8.00 |            2 |
|    303 | Biryani         | 15.00 |            3 |
|    304 | Paneer Tikka    | 10.00 |            4 |
|    305 | Caesar Salad    |  7.00 |            5 |
+--------+-----------------+-------+--------------+
5 rows in set (0.00 sec)

mysql> SELECT * FROM Restaurant;
+--------------+---------------+----------+-------------+
| RestaurantID | Name          | Location | PhoneNumber |
+--------------+---------------+----------+-------------+
|            1 | Pizza Palace  | City A   | 555-7890    |
|            2 | Burger Barn   | City B   | 555-2345    |
|            3 | Biryani House | City C   | 555-6789    |
|            4 | Indian Spice  | City D   | 555-1234    |
|            5 | Green Garden  | City E   | 555-5678    |
+--------------+---------------+----------+-------------+
5 rows in set (0.00 sec)

mysql> SELECT * FROM OrderMeal;
+---------+--------+----------+
| OrderID | MealID | Quantity |
+---------+--------+----------+
|       1 |    301 |        2 |
|       1 |    302 |        1 |
|       2 |    303 |        1 |
|       2 |    304 |        2 |
|       3 |    305 |        3 |
|       4 |    301 |        1 |
|       5 |    303 |        2 |
|       6 |    302 |        3 |
|       7 |    305 |        1 |
+---------+--------+----------+
9 rows in set (0.00 sec)

mysql> SELECT * FROM MealRating;
+----------+--------+------------+-------------+-------------------------------+
| RatingID | MealID | CustomerID | RatingScore | RatingRemarks                 |
+----------+--------+------------+-------------+-------------------------------+
|        1 |    301 |        101 |           4 | Good, but could be hotter.    |
|        2 |    302 |        102 |           5 | Delicious! Will order again.  |
|        3 |    303 |        103 |           3 | The taste was average.        |
|        4 |    304 |        104 |           5 | Perfect, very flavorful.      |
|        5 |    305 |        105 |           4 | Fresh and light, great salad. |
+----------+--------+------------+-------------+-------------------------------+
5 rows in set (0.00 sec)

mysql> SELECT
    ->     d.DriverID,
    ->     d.Name AS DriverName,
    ->     COUNT(o.OrderID) AS TotalOrders,
    ->     DATE(o.OrderTime) AS DeliveryDate
    -> FROM
    ->     OrderTable o
    -> JOIN
    ->     Driver d
    -> ON
    ->     o.DriverID = d.DriverID
    -> WHERE
    ->     o.DeliveryStatus = 'Delivered'
    -> GROUP BY
    ->     d.DriverID, d.Name, DATE(o.OrderTime)
    -> ORDER BY
    ->     TotalOrders DESC
    -> LIMIT 1;
+----------+------------+-------------+--------------+
| DriverID | DriverName | TotalOrders | DeliveryDate |
+----------+------------+-------------+--------------+
|      201 | Mike Green |           1 | 2024-12-30   |
+----------+------------+-------------+--------------+
1 row in set (0.00 sec)

mysql> ALTER TABLE Meal ADD Type VARCHAR(50);
Query OK, 0 rows affected (0.03 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> UPDATE Meal
    -> SET Type = CASE
    ->     WHEN MealName = 'Biryani' THEN 'Biryani'
    ->     ELSE 'Other'
    -> END;
Query OK, 5 rows affected (0.01 sec)
Rows matched: 5  Changed: 5  Warnings: 0

mysql> CREATE VIEW HighestRatedBiryani AS
    -> SELECT
    ->     m.MealID,
    ->     m.MealName,
    ->     m.Type AS MealType,
    ->     AVG(r.RatingScore) AS AverageRating
    -> FROM
    ->     Meal m
    -> JOIN
    ->     MealRating r
    -> ON
    ->     m.MealID = r.MealID
    -> WHERE
    ->     m.Type = 'Biryani'
    -> GROUP BY
    ->     m.MealID, m.MealName, m.Type
    -> ORDER BY
    ->     AverageRating DESC;
Query OK, 0 rows affected (0.00 sec)

mysql> select *from HighestRatedBiryani;
+--------+----------+----------+---------------+
| MealID | MealName | MealType | AverageRating |
+--------+----------+----------+---------------+
|    303 | Biryani  | Biryani  |        3.0000 |
+--------+----------+----------+---------------+
1 row in set (0.00 sec)

mysql> UPDATE Meal
    -> SET Price = Price * 1.10
    -> WHERE MealID IN (
    ->     SELECT om.MealID
    ->     FROM OrderMeal om
    ->     JOIN MealRating r ON om.MealID = r.MealID
    ->     WHERE r.RatingScore < 4
    ->     GROUP BY om.MealID
    ->     HAVING SUM(om.Quantity) < 2
    -> );
Query OK, 0 rows affected (0.00 sec)
Rows matched: 0  Changed: 0  Warnings: 0

mysql> SELECT * FROM Meal;
+--------+-----------------+-------+--------------+---------+
| MealID | MealName        | Price | RestaurantID | Type    |
+--------+-----------------+-------+--------------+---------+
|    301 | Pepperoni Pizza | 12.00 |            1 | Other   |
|    302 | Veggie Burger   |  8.00 |            2 | Other   |
|    303 | Biryani         | 15.00 |            3 | Biryani |
|    304 | Paneer Tikka    | 10.00 |            4 | Other   |
|    305 | Caesar Salad    |  7.00 |            5 | Other   |
+--------+-----------------+-------+--------------+---------+
5 rows in set (0.00 sec)

mysql>
