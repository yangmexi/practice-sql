# Joins

## Left Join

Left join is a type of outer join. It keeps all records in the left table, and all matches from the right table.

One typical problem in business environment is that: you have one table of users and one table or orders. You want to know the number of orders made by all users within a certain time period. We have to use left join on users table, because: we have to keep the records that users make 0 order. We cannot use inner join here.

1. [Market Analysis I](https://leetcode.com/problems/market-analysis-i/)

   Solution: [leetcode1158.sql](https://github.com/yangmexi/practice-sql/blob/master/LeetCode/joins/leetcode1158.sql)

   This is exactly the problem we stated above. Other than using left join, another detail should be mentioned is that, to specify the time period, we have to match on multiple columns. We cannot only match on FK and then use `WHERE` to specify the time, in which way we will lose the records with `NULL` values. 

   ```mysql
   SELECT user_id AS buyer_id, join_date,
          IFNULL(COUNT(order_id), 0) AS orders_in_2019
   FROM Users AS u
   LEFT JOIN Orders AS o
   ON u.user_id = o.buyer_id 
      AND order_date BETWEEN '2019-01-01' AND '2019-12-31'  -- match on multiple attributes
   GROUP BY user_id
   ```

   