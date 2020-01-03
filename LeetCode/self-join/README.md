# Self-join

Self-join might be confusing but is very useful under various circumstances. The nice feature of joining a table to itself is that, we could do manipulations using different rows of the table at a time. As a result, most of the time, this would save us from sub-query.

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

   

