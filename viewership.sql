--Təkrarlanan id-yoxdur
SELECT *
FROM (
SELECT user_id, COUNT(user_ID) OVER(PARTITION BY user_id) as cnt
FROM viewership)
WHERE cnt>1
--Id standart 36 xanalıqdır. Yalnışlıq yoxdur.
SELECT  LENGTH(user_id) as uzunluq
FROM viewership
GROUP BY uzunluq
-- Session ID 36 xanaliqdir standartdir.
SELECT LENGTH(session_id) as sess_uzunluq
FROM viewership
GROUP BY sess_uzunluq
-- Tekrarlanan session_id yoxdur.
SELECT *
FROM(
 SELECT session_id, COUNT(session_id) OVER(PARTITION BY session_id) AS say
 FROM viewership)
WHERE say>1
--DEVICE Tipi təmizdir.
SELECT device_type
FROM viewership
GROUP BY device_type