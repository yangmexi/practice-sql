SELECT DISTINCT *
FROM
(SELECT s1.id, s1.visit_date, s1.people
FROM stadium AS s1, stadium AS s2, stadium AS s3
WHERE s1.people >= 100 AND s2.people >= 100 AND s3.people >= 100
AND ((s1.id + 1 = s2.id AND s1.id + 2 = s3.id)
     OR (s1.id - 1 = s2.id AND s1.id + 1 = s3.id)
     OR (s1.id - 2 = s3.id AND s1.id - 1 = s2.id)
    )) temp
ORDER BY id
