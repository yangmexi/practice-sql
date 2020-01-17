# SQL Practices

This repo covers SQL problems solutions for the purpose of upskilling, so the problems are selected and classified according to the concepts they cover, and analysis and explanation are given along with the queries. The problems are from LeetCode, Hackerrank or other sources. 

## Summary

Here listed typical SQL problems we could encounter, more detailed explanations for each topic can be found in the README files in sub-folders. 

1. [Compute Rate](https://github.com/yangmexi/practice-sql/blob/master/LeetCode/compute-rate/):
   1. Problems: [Trips and Users](https://github.com/yangmexi/practice-sql/blob/master/LeetCode/hard-problems/leetcode262.sql), [Ads Performance](https://leetcode.com/problems/ads-performance/)
   2. Compute percentage
   3. 
2. Aggregate attributes based on external columns
   1. [Joins](https://github.com/yangmexi/practice-sql/tree/master/LeetCode/joins) (inner/left/right)
3. Get ranked results within sub-groups
   1. Problems: [Department Highest Salary](https://leetcode.com/problems/department-highest-salary/), [Department Top Three Salaries](https://github.com/yangmexi/practice-sql/blob/master/LeetCode/hard-problems/leetcode185.sql)
4. Calculate Running Statistics / Manipulate Consecutive Rows
   1. [Self-joins](https://github.com/yangmexi/practice-sql/tree/master/LeetCode/self-join)
      1. Moving average: [Restaurant Growth](https://leetcode.com/problems/restaurant-growth/)
   2. [Window-function](https://github.com/yangmexi/practice-sql/tree/master/LeetCode/window-function)
   3. Problems: 
5. Either here or there: `Union`
   1. Problems: [Friend Requests II: Who Has the Most Friends](https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/submissions/)

## Basic Concepts

### Database Normalization

**Database normalization** is the process of structuring a relational database in accordance with a series of so-called normal forms in order to reduce **data redundancy** and improve **data integrity**. ([ref](https://en.wikipedia.org/wiki/Database_normalization)). (Example: team_info, players_info, game_incident_info)

Database normalization is useful because it minimizes duplicate data in any single table, and allows for data in the database to grow independently of each other (ie. Types of car engines can grow independent of each type of car). ([ref](https://sqlbolt.com/lesson/select_queries_with_joins))

### Order of Execution

1. `FROM`, `JOIN`: Create a temporary table includes every columns and rows
2. `WHERE`: Discard rows that don't satisfy the condition
3. `GROUP BY`: Rows are grouped by the common values
4. `HAVING`: Discard grouped rows that don't satisfy the constraint
5. `SELECT`
6. `DISTINCT`: rows with duplicated values will be discarded
7. `ORDER BY`
8. `LIMIT` / `OFFSET`

### Optimize Query

Avoid:

1. `DISTINCT`: slow down the execution time
2. correlated-subquery
3. `UNION`: try to use `OUTER JOIN` to avoid it
4. If you can use `WHERE`, don't use `HAVING`

## Cheatsheets

1. Reformat date types

   1. `CAST('2020-01-09' AS DATE)`

2. Deal with `NULL`

   1. `IFNULL(b, a)`
   2. `COALESCE(v1, v2, ...)`: return first non-null value

3. Deal with `TIMESTAMP` Data (MySQL syntax)

   1. `DATEDIFF(d2, d1)`: difference in days (N)
   2. `TIMEDIFF(t2, t1)`: difference in time (HH:MM:SS)
   3. `TO_DAYS(d1)`: the number of days between a date and year 0 (date "0000-00-00")

4. String Manipulation

   1. Wildcard: `_` for single character; `%` for >= 0 characters (`LIKE` clause) 
   2. Concat strings: `CONCAT(s1, '(', s2, ...)`
   3. Substring: `SUBSTR(str, pos, length)`

5. Modify Records

   1. `UPDATE`: [Swap Salary](https://leetcode.com/problems/swap-salary/submissions/)

      ```sql
      UPDATE t1 SET col1 = col1 + 1, col2 = col1;
      
      UPDATE salary
      SET sex = CASE WHEN sex = 'm' THEN 'f' ELSE 'm' END;
      ```

## Appendix: Learning Resources

Some useful learning materials covering various SQL knowledges, from basic to expert level. 

1. Basic sytnax references: https://www.w3schools.com/sql/
2. More thorough tutorial: https://mode.com/sql-tutorial/introduction-to-sql/
3. Deeper understanding of optimizing queries: https://www.datacamp.com/community/tutorials/sql-tutorial-query

