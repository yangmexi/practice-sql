SELECT deptemp.month AS pay_month, department_id,
       CASE WHEN deptemp.salary > temp.salary THEN 'higher'
            WHEN deptemp.salary < temp.salary THEN 'lower'
            ELSE 'same' END AS comparison
FROM
(SELECT LEFT(pay_date, 7) AS month, department_id, AVG(amount) AS salary
 FROM salary s
 JOIN employee e
 ON s.employee_id = e.employee_id
 GROUP BY department_id, month
) deptemp
LEFT JOIN
(SELECT LEFT(pay_date, 7) AS month, AVG(amount) AS salary
FROM salary
GROUP BY month) temp
ON deptemp.month = temp.month
