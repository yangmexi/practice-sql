# Write your MySQL query statement below
SELECT install_dt, COUNT(installation.player_id) AS installs,
       ROUND(COUNT(a.player_id) / COUNT(installation.player_id), 2) AS Day1_retention
FROM (
    SELECT player_id, MIN(event_date) AS install_dt
    FROM Activity
    GROUP BY player_id
) installation
LEFT JOIN Activity as a
ON installation.player_id = a.player_id AND installation.install_dt + 1 = a.event_date
GROUP BY install_dt
