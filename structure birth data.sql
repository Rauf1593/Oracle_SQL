select *
from(
SELECT tarix,
	LEAD(tarix) over(order by tarix),
LEAD(tarix) over(order by tarix)-tarix as d_if
from
	(SELECT 
	TO_DATE(date_of_month || '-' || month || '-' || year, 'DD-MM-YYYY') as tarix,
	BIRTHS,
	MALE,
	FEMALE,
	ASIAN,
	BLACK
FROM PUBLIC.US_BIRTHS) main)m_2
where d_if>1