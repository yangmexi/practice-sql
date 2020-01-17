# Compute Rate

This type of problems is unsolvable to me at the first time I met them. How can we compute the rate by summing over partial rows and divided it by the result of all rows? How to work on multiple parts of the table at the same time?

Actually, the solution is quite simple and brilliant. `CASE` statement is used to create a dummy variable and the manipulations are done to it. 

## Problems

1. [Immediate Food Delivery II]()

   Notice:

   1. you have to `SUM` the `CASE` statement;
   2. Find the earliest record for each user: subquery in  `WHERE`
   
   ```mysql
   SELECT ROUND(100 * (SUM(customer_pref_delivery_date = order_date)/ COUNT(*) ), 2) AS immediate_percentage
   FROM Delivery
   WHERE (customer_id, order_date) IN (
       SELECT customer_id, MIN(order_date) AS first_day
       FROM Delivery
       GROUP BY customer_id
   )
   ```
   
2. [Trips and Users](https://leetcode.com/problems/trips-and-users/) (**Hard**)

   Solution: [leetcode262.sql](https://github.com/yangmexi/practice-sql/blob/master/LeetCode/compute-rate/leetcode262.sql)

   This is a rather simple 'Hard' problem. 

   ```mysql
   SELECT Request_at AS Day, 
          ROUND(SUM(CASE WHEN Status LIKE 'cancelled%' THEN 1 ELSE 0 END)/ COUNT(*), 2) AS 'Cancellation Rate'
   FROM Trips
   WHERE Client_Id IN (
       SELECT Users_Id
       FROM Users
       WHERE Role = 'client' AND Banned = 'No'
   )
   AND Driver_Id IN (
       SELECT Users_Id
       FROM Users
       WHERE Role = 'driver' AND Banned = 'No'
   )
   AND request_at BETWEEN '2013-10-01' AND '2013-10-03'
   GROUP BY Request_at
   ```

3. Compute Percentage of Each Group

   Using the nice property of Window Function to get the total sum for each row, then calculate the percentage directly

   ```mysql
   -- calculate COUNT(*) first, then execute the window function SUM() OVER()
   SELECT Grade, COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS percentage
   FROM MyTable
   GROUP BY Grade
   ```

   
