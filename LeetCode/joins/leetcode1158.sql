Write your MySQL query statement below
SELECT user_id AS buyer_id, join_date,
       IFNULL(COUNT(order_id), 0) AS orders_in_2019
FROM Users AS u
LEFT JOIN Orders AS o
ON u.user_id = o.buyer_id AND order_date BETWEEN '2019-01-01' AND '2019-12-31'
GROUP BY user_id
