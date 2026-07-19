/*CREATE TABLE Orders_Lead_lag_Practice (
    OrderID INT,
    CustomerID INT,
    OrderDate DATE,
    Amount DECIMAL(10,2)
);

INSERT INTO Orders_Lead_lag_Practice VALUES
(1,101,'2024-01-10',500),
(2,101,'2024-02-15',700),
(3,101,'2024-03-20',650),
(4,102,'2024-01-05',900),
(5,102,'2024-02-18',850),
(6,103,'2024-01-08',400),
(7,103,'2024-04-12',600);*/


--Question 1 - Show each order along with the previous order amount of the same customer.
--select *,lag(Amount)over(partition by CustomerID order by  OrderId)as previous_amount from Orders_Lead_lag_Practice

--Question 2 - Show the next order amount for every customer.
--select *,lead(Amount)over(partition by CustomerID order by  OrderId)as previous_amount from Orders_Lead_lag_Practice

--Question 3 - Find how much the customer spent more or less compared to the previous order.
--select *,(amount - lag(Amount)over(partition by CustomerID order by  OrderId))as diff_amount from Orders_Lead_lag_Practice

--Question 4 - Find customers whose current order amount is less than their previous order.
--with cte as  (select *,(amount - lag(Amount)over(partition by CustomerID order by  OrderId))as diff_amount from Orders_Lead_lag_Practice)
--select CustomerID,OrderDate,Amount,diff_amount as amount from cte where diff_amount <0

--Question 5 - Find the number of days between consecutive orders.
with cte as ( select *,DATEDIFF(day,lag(OrderDate)over(partition by CustomerID order by  OrderId),OrderDate)as Days_gap from Orders_Lead_lag_Practice)
select CustomerID,OrderDate,Amount,Days_gap from  cte where Days_gap is not null
