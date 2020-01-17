# SQL Practices

This repo covers SQL problems solutions for the purpose of upskilling, so the problems are selected and classified according to the concepts they cover, and analysis and explanation are given along with the queries. The problems are from LeetCode, Hackerrank or other sources. 

## Summary

Here listed typical SQL problems we could encounter, more detailed explanations for each topic can be found in the README files in sub-folders. 

1. [Compute Rate](https://github.com/yangmexi/practice-sql/blob/master/LeetCode/compute-rate/):
   1. Problems: [Trips and Users](https://github.com/yangmexi/practice-sql/blob/master/LeetCode/hard-problems/leetcode262.sql)
   2. Compute percentage
2. Aggregate attributes based on external columns
   1. [Joins](https://github.com/yangmexi/practice-sql/tree/master/LeetCode/joins) (inner/left/right)
3. Get ranked results within sub-groups
   1. Problems: [Department Highest Salary](https://leetcode.com/problems/department-highest-salary/), [Department Top Three Salaries](https://github.com/yangmexi/practice-sql/blob/master/LeetCode/hard-problems/leetcode185.sql)
4. Calculate Running Statistics / Manipulate Consecutive Rows
   1. [Self-joins](https://github.com/yangmexi/practice-sql/tree/master/LeetCode/self-join)
   2. [Window-function](https://github.com/yangmexi/practice-sql/tree/master/LeetCode/window-function)
   3. Problems: 

## Useful functions

1. Reformat date types
   1. `CAST('2020-01-09' AS DATE)`
2. Deal with `NULL`
   1. `IFNULL(b, a)`
   2. `COALESCE(v1, v2, ...)`: return first non-null value
3. Deal with `TIMESTAMP` Data (MySQL syntax)
   1. `DATEDIFF(d2, d1)`: difference in days (N)
   2. `TIMEDIFF(t2, t1)`: difference in time (HH:MM:SS)
   3. `TO_DAYS(d1)`: the number of days between a date and year 0 (date "0000-00-00")

## Appendix: Learning Resources

Some useful learning materials covering various SQL knowledges, from basic to expert level. 

1. Basic sytnax references: https://www.w3schools.com/sql/
2. More thorough tutorial: https://mode.com/sql-tutorial/introduction-to-sql/
3. Deeper understanding of optimizing queries: https://www.datacamp.com/community/tutorials/sql-tutorial-query

