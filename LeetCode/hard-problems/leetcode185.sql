-- Solution 1: Self-join
SELECT d.Name AS Department, e1.Name AS Employee, e1.Salary
FROM Employee AS e1
JOIN Department AS d
ON d.Id = e1.DepartmentId
LEFT JOIN Employee AS e2
ON e1.DepartmentId = e2.DepartmentId
   AND e2.Salary >= e1.Salary
GROUP BY d.Name, e1.Name
HAVING COUNT(DISTINCT e2.Salary) <= 3


-- Solution 2: Correlated Subquery

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
