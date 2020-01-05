# Window Function

Window functions become handy when we need to calculate across table rows without grouping rows into a single row ([reference](https://mode.com/sql-tutorial/sql-window-functions/)). This is super useful when we want to calculate aggregated statistics like rolling sum and so. Besides this basic usage, it can also solve some tricky problems, in combination of other clauses.



## Problems

### Basic

Adjust the window

```mysql
SELECT id, month, Salary
FROM
(
SELECT  id, 
        month, 
		-- Every 3 months. ROWS 2 PRECEDING indicates the number of rows or values to precede the current row (1 + 2)
        SUM(salary) OVER(PARTITION BY id  ORDER BY month ROWS 2 PRECEDING) AS Salary, 
        DENSE_RANK() OVER(PARTITION BY id ORDER by month DESC) AS month_no
FROM Employee
)  src
--  exclude the most recent month
where month_no > 1
ORDER BY id , month desc
```

### Advanced

#### Identify Continuous Chunks: `ROW_NUMBER` 

Assign each row an increasing row number. This can be greatly helpful when solving problems about consecutive chunks in the table. The row numbers can be used as the marker and thus identify the changes of some target columns. Here's an example:

[Find the Start and End Number of Continuous Ranges](https://leetcode.com/problems/find-the-start-and-end-number-of-continuous-ranges/)

Solution: [leetcode1285.sql](https://github.com/yangmexi/practice-sql/blob/master/LeetCode/window-function/leetcode1285.sql)

*Give a set of numbers `Logs`, need to find out the continuous ranges by indicating the start and the end.*

```mysql
SELECT MIN(log_id) AS start_id,
       MAX(log_id) AS end_id
FROM
(SELECT log_id,
       ABS(log_id - ROW_NUMBER() OVER (ORDER BY log_id)) AS seq
from Logs) temp
GROUP BY seq
```

#### Day-to-day change: `LAG` / `LEAD`

If only focus on 1 day or 2 days, can also use self-join instead. 