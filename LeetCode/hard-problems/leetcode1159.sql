-- solution: left join

SELECT u.user_id AS seller_id,
       CASE WHEN u.favorite_brand = i.item_brand THEN 'yes'
       ELSE 'no' END AS 2nd_item_fav_brand
FROM Users AS u
LEFT JOIN
(SELECT o1.seller_id, o1.item_id, o1.order_date
FROM Orders AS o1, Orders AS o2
WHERE o1.seller_id = o2.seller_id AND o2.order_date < o1.order_date
GROUP BY o1.seller_id, o1.order_date
HAVING COUNT(o2.order_id) = 1) sec_order
ON u.user_id = sec_order.seller_id
LEFT JOIN Items AS i
ON sec_order.item_id = i.item_id
;


-- solution: correlated query
SELECT user_id AS seller_id,
        (CASE WHEN favorite_brand = (
                            SELECT i.item_brand
                            FROM Orders o LEFT JOIN Items i
                            ON o.item_id = i.item_id
                            WHERE o.seller_id = u.user_id
                            ORDER BY o.order_date
                            LIMIT 1 OFFSET 1
                                  ) THEN "yes"
              ELSE "no" END
         ) AS "2nd_item_fav_brand"
FROM Users u
