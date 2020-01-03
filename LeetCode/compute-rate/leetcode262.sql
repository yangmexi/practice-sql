SELECT Request_at AS Day,
       ROUND(SUM(CASE WHEN Status LIKE 'cancelled%' THEN 1 ELSE 0 END)/ COUNT(*), 2) AS 'Cancellation Rate'
FROM Trips
WHERE Client_Id IN (
    SELECT Users_Id
    FROM Users
    WHERE Role = 'client' AND Banned = 'No'
)
AND Driver_Id IN (
    SELECT Users_Id
    FROM Users
    WHERE Role = 'driver' AND Banned = 'No'
)
AND request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY Request_at
