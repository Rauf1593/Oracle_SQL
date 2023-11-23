--Iller arasi itki: Yoxdur
SELECT f
FROM (
SELECT year-LAG(year) OVER(ORDER BY year) AS f
FROM us_crimes)
WHERE f!=1
--Total uyumu illərə görə ortalama 2 dəfə azaldılıb.
SELECT total,
	(violent+property+murder+forcible_rape+robbery+aggravated_assault+burglary+larceny_theft+vehicle_theft)/2 as umumi
FROM us_crimes
--Ortalamadan yüksək dövrlərə görə artım sorğusu
WITH orta_yuksek as (
SELECT year
FROM us_crimes
WHERE total> (SELECT AVG(total)
			 FROM us_crimes)), baslama AS (
 SELECT year,
	CASE 
		WHEN (year-LAG(year) OVER(ORDER BY year) = 1)
		THEN 0 
	    ELSE 1 END basla
 FROM orta_yuksek), bas_tarix AS (
	SELECT year,
		ROW_NUMBER() OVER(ORDER BY year) as nom_b
	FROM baslama
	WHERE basla=1), qurtarma AS (
		SELECT year,
		 	CASE
				WHEN (year-LEAD(year) OVER(ORDER BY year)= -1)
				THEN 0
				ELSE 1 END qurtar
		FROM orta_yuksek), qurt_tarix AS (
		SELECT year,
			ROW_NUMBER() OVER(ORDER BY year) nom_q
		FROM qurtarma
		WHERE qurtar=1
		)
SELECT bas_tarix.year as start_date ,
		qurt_tarix.year as end_date
FROM bas_tarix
JOIN qurt_tarix ON bas_tarix.nom_b=qurt_tarix.nom_q;

-- Ortalamadan aşağı dövrlərə görə azalım sorğusu
WITH orta_yuksek as (
SELECT year
FROM us_crimes
WHERE total< (SELECT AVG(total)
			 FROM us_crimes)), baslama AS (
 SELECT year,
	CASE 
		WHEN (year-LAG(year) OVER(ORDER BY year) = 1)
		THEN 0 
	    ELSE 1 END basla
 FROM orta_yuksek), bas_tarix AS (
	SELECT year,
		ROW_NUMBER() OVER(ORDER BY year) as nom_b
	FROM baslama
	WHERE basla=1), qurtarma AS (
		SELECT year,
		 	CASE
				WHEN (year-LEAD(year) OVER(ORDER BY year)= -1)
				THEN 0
				ELSE 1 END qurtar
		FROM orta_yuksek), qurt_tarix AS (
		SELECT year,
			ROW_NUMBER() OVER(ORDER BY year) nom_q
		FROM qurtarma
		WHERE qurtar=1
		)
SELECT bas_tarix.year as start_date ,
		qurt_tarix.year as end_date
FROM bas_tarix
JOIN qurt_tarix ON bas_tarix.nom_b=qurt_tarix.nom_q;

