# Self-join

Self-join might be confusing but is very useful under various circumstances. The nice feature of joining a table to itself is that, we could do manipulations using different rows of the table at a time. As a result, most of the time, this would save us from sub-query or using window functions.

## Typical Usage

Here are some **typical use case** of self-join: 

1. Calculate Aggregated Statistics:

   1. Calculate Running Statistics:

      [Game Play Analysis III](https://leetcode.com/problems/game-play-analysis-iii/), [Find Cumulative Salary of an Employee](https://leetcode.com/problems/find-cumulative-salary-of-an-employee/)

   2. Use Aggregate Statistics to Filter:

      [Employees Earning More Than Their Managers](https://leetcode.com/problems/employees-earning-more-than-their-managers/); [Department Top Three Salaries](https://leetcode.com/problems/department-top-three-salaries/); 

2. Working on Consecutive Rows:

   1. Two Next Rows:

   2. More than two: 

      [Consecutive Numbers](https://leetcode.com/problems/consecutive-numbers/), [Human Traffic of Stadium](https://leetcode.com/problems/human-traffic-of-stadium/)

## Problems
### Basic

The most basic way of self-join is to join and then use WHERE clause to only select the desired rows out of the complete result of self-join (Cartesian product). 

Alternatively, this type of problems can also be solved by `JOIN`, and many people may think that type of query is more structured and more readable. 

1. [Employees Earning More Than Their Managers](https://leetcode.com/problems/employees-earning-more-than-their-managers/)    

   *Given the `Employee` table, we need to find out those employees who earn more than their managers.*

   Solution: [leetcode181.sql](https://github.com/yangmexi/practice-sql/blob/master/LeetCode/self-join/leetcode181.sql)

   ```mysql
   SELECT e1.Name AS Employee
   FROM Employee AS e1, Employee AS e2
   WHERE e1.ManagerId = e2.Id
   AND e1.Salary > e2.Salary
   ```

2. [Consecutive Numbers](https://leetcode.com/problems/consecutive-numbers/)

   *Given the `Logs` table, need to find all numbers that appear at least three times consecutively.*

   Methods other than self-join would be redundant here, since we need to compare the record across 3 rows to get the valid result. Self-join the table itself 3 times is much easier.

   Solution: [leetcode180.sql](https://github.com/yangmexi/practice-sql/blob/master/LeetCode/self-join/leetcode180.sql)

   ```mysql
   SELECT DISTINCT l1.Num AS ConsecutiveNums
   FROM Logs l1, Logs l2, Logs l3 
   WHERE l1.Id = l2.Id + 1 AND l2.Id = l3.Id + 1 
   AND l1.Num = l2.Num AND l2.Num = l3.Num AND l3.Num = l1.Num;
   ```

### Advanced

Using two attributes to join the table to itself is rather easy to understand, and it's very similar to normal joins. However, one convenient and common usage of self-join is to join on the same column! By this method, we could easily calculate running statistics without using Window Functions. 

1. [Game Play Analysis III](https://leetcode.com/problems/game-play-analysis-iii/)

   *Given the `Activity` table, need to reports for each player and date, how many games played **so far** by the player.* 

   This is a typical problem of running stats. Here, by joining to the same column, we could use `a1.event_date` as the ruler, and `a2.event_date` would be used to select all records before each `a1.event_date`. Then, to calculate the running stats, we only need to aggregate  `a2.games_played` for each player and also the `event_date` on `a1`.

   Solution: [leetcode534.sql](https://github.com/yangmexi/practice-sql/blob/master/LeetCode/self-join/leetcode534.sql)

   ```mysql
   SELECT a1.player_id, a1.event_date, SUM(a2.games_played) AS games_played_so_far
   FROM Activity AS a1,
        Activity AS a2
   WHERE a1.player_id = a2.player_id
   AND a1.event_date >= a2.event_date
   GROUP BY a1.player_id, a1.event_date
   ```

   Some similar problems: [Running Total for Different Genders](https://leetcode.com/problems/running-total-for-different-genders/), [Last Person to Fit in the Elevator](https://leetcode.com/problems/last-person-to-fit-in-the-elevator/), etc.

### Hard

Take one step further, we could use self-join and place restriction on the aggregated statistics of the joined table. In other words, for each row, we could compare its attributes to some aggregated statistics to decide wheter keep or drop it. This type of problems is more complicated to think of a efficient solution. 

1. [Department Top Three Salaries](https://leetcode.com/problems/department-top-three-salaries/)

   Solution: [leetcode185.sql](https://github.com/yangmexi/practice-sql/blob/master/LeetCode/hard-problems/leetcode185.sql)

   By joinning a table when the salary is higher than each row, we could count the number of salary that is higher, in other words, we can know the ranking of each salary in its department (by `GROUP BY`). Consequently, window function of `DENSE_RANK` can also solve this problem.

   This solution is efficient because when only SELECT once. This problem also can be solved by correlated subquey.

   ```mysql
   SELECT d.Name AS Department, e1.Name AS Employee, e1.Salary
   FROM Employee AS e1
   JOIN Department AS d
   ON d.Id = e1.DepartmentId
   LEFT JOIN Employee AS e2
   ON e1.DepartmentId = e2.DepartmentId  -- combination within department
      AND e2.Salary >= e1.Salary  -- only count when salary is higher
   GROUP BY d.Name, e1.Name
   HAVING COUNT(DISTINCT e2.Salary) <= 3  -- select by # salary is higher
   -- have to be inclusive: or the first one will be eliminated
   ```

2. [Human Traffic of Stadium](https://leetcode.com/problems/human-traffic-of-stadium/)

   Solution: [leetcode601.sql](https://github.com/yangmexi/practice-sql/blob/master/LeetCode/hard-problems/leetcode601.sql)

   Notice how we deal with the boundary here: keep both table 1 as first/second/third day, then use `DISTINCT`.

   ```mysql
   SELECT DISTINCT *
   FROM
   (SELECT s1.id, s1.visit_date, s1.people
   FROM stadium AS s1, stadium AS s2, stadium AS s3
   WHERE s1.people >= 100 AND s2.people >= 100 AND s3.people >= 100
   AND ((s1.id + 1 = s2.id AND s1.id + 2 = s3.id)
        OR (s1.id - 1 = s2.id AND s1.id + 1 = s3.id)
        OR (s1.id - 2 = s3.id AND s1.id - 1 = s2.id)
       )) temp
   ORDER BY id
   ```

   