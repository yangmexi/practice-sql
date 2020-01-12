SELECT d.Name AS Department, e.Name AS Employee, Salary
FROM Employee AS e
INNER JOIN Department AS d
ON e.DepartmentId = d.Id
WHERE (DepartmentId, Salary) IN (
		SELECT DepartmentId, MAX(Salary)
		FROM Employee
		GROUP BY DepartmentId
)
