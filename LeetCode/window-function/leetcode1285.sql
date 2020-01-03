/*
Logs table:
+------------+
| log_id     |
+------------+
| 1          |
| 2          |
| 3          |
| 7          |
| 8          |
| 10         |
+------------+
*/

SELECT MIN(log_id) AS start_id,
       MAX(log_id) AS end_id
FROM
(
  SELECT log_id,
         ABS(log_id - ROW_NUMBER() OVER (ORDER BY log_id)) AS seq
FROM Logs) temp
GROUP BY seq
