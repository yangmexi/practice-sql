# Subquery

## In `WHERE` Clause

Using subquery in WHERE clause, we can add conditions of the result of some complex queries.
For Example, a typical business problem is: within each category, which records are the first/second/third/... place?

1. [Department Highest Salary](https://leetcode.com/problems/department-highest-salary/)

   ```sql
   SELECT d.Name AS Department, e.Name AS Employee, Salary
   FROM Employee AS e
   INNER JOIN Department AS d
   ON e.DepartmentId = d.Id
   WHERE (DepartmentId, Salary) IN (
       SELECT DepartmentId, MAX(Salary)
       FROM Employee
       GROUP BY DepartmentId
   )
   ```

2. [Department Top Three Salaries](https://leetcode.com/problems/department-top-three-salaries/) **Hard**

   This is a hard problem. Because we need to choose the 1-3 top records within every category, we cannot simply use `MAX` function as the previous problem. 

   To choose multiple rows after `GROUP BY`, there're some options: 

   1. use [Window-function](https://github.com/yangmexi/practice-sql/tree/master/LeetCode/window-function) instead of `GROUP BY` to do complex aggregation; 
   2. use [Self-joins](https://github.com/yangmexi/practice-sql/tree/master/LeetCode/self-join) to generate multiple rows for one record, with the combination of salaries.
   3. use a correlated subquery in `WHERE` clause to get mulitple rows for each record

   **Correlated subquery** is different from those simple sub-query that can run in standalone. A correlated subquery is **evaluated once for each row** processed by the parent statement. Consequently, this is a computationally expensive subquery run you have to run `SELECT` statement for `N +1` times. Most of the time, you can use `INNER JOIN` and some constraints to get rid of it (see link of `self-joins`). ([ref](https://www.geeksforgeeks.org/sql-correlated-subqueries/))

   Here, for the purpose of learning, gives one solution using correlated subquery:

   ```sql
   SELECT
       d.Name AS 'Department', e1.Name AS 'Employee', e1.Salary
   FROM
       Employee e1
           JOIN
       Department d ON e1.DepartmentId = d.Id
   WHERE
       3 > (SELECT
               COUNT(DISTINCT e2.Salary)
           FROM
               Employee e2
           WHERE
               e2.Salary > e1.Salary
                   AND e1.DepartmentId = e2.DepartmentId
           )
   ;
   ```

   