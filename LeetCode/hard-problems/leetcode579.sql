-- solution: self-join

SELECT e1.Id, MAX(e2.Month) AS month, SUM(e2.Salary) AS salary
FROM Employee AS e1, Employee AS e2
WHERE e1.Id = e2.Id AND e2.Month BETWEEN (e1.Month - 3) AND (e1.Month - 1)
GROUP BY e1.Id, e1.Month
ORDER BY e1.Id, e1.Month DESC

-- solution: window function

SELECT id, month, Salary
FROM
(
SELECT  id,
				month,
		-- Every 3 months. ROWS 2 PRECEDING indicates the number of rows or values to precede the current row (1 + 2)
				SUM(salary) OVER(PARTITION BY id ORDER BY month ROWS 2 PRECEDING) as Salary,
				DENSE_RANK() OVER(PARTITION BY id ORDER by month DESC) month_no
FROM Employee
)  src
--  exclude the most recent month
where month_no > 1
ORDER BY id , month desc
