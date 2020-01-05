SELECT sk.spend_date, sk.platform, IFNULL(SUM(amount), 0) AS total_amount,
       IFNULL(COUNT(DISTINCT user_id), 0) AS total_users
FROM (
    SELECT DISTINCT spend_date, 'mobile' AS platform FROM Spending
    UNION
    SELECT DISTINCT spend_date, 'desktop' AS platform FROM Spending
    UNION
    SELECT DISTINCT spend_date, 'both' AS platform FROM Spending) sk
LEFT JOIN (
    SELECT spend_date, user_id,
           CASE WHEN COUNT(*) = 1 THEN platform
                ELSE 'both' END AS platform,
           SUM(amount) AS amount
    FROM Spending
    GROUP BY spend_date, user_id
) spd
ON sk.spend_date = spd.spend_date AND sk.platform = spd.platform
GROUP BY spend_date, platform
