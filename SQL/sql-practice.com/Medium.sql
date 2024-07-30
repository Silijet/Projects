--1. Show unique birth years from patients and order them by ascending.
SELECT 	distinct year(birth_date)
FROM 	patients
WHERE 	1=1
ORDER BY YEAR(birth_date) ASC

--2. Show unique first names from the patients table which only occurs once in the list.
--For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. If only 1 person is named 'Leo' then include them in the output.
SELECT   first_name
FROM     patients
GROUP BY first_name
HAVING 	count(*) = 1

--3. Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.
SELECT patient_id, first_name
FROM   patients
WHERE  first_name like 's%' 
AND    first_name like '%s'
AND    len(first_name)>=6

--4. Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
--Primary diagnosis is stored in the admissions table.
SELECT  patients.patient_id, first_name, last_name
FROM 	  patients
JOIN admissions ON 
	patients.patient_id = admissions.patient_id
WHERE   diagnosis = 'Dementia'

--5. Display every patient's first_name. Order the list by the length of each name and then by alphabetically.
SELECT	first_name
FROM    patients
ORDER BY len(first_name), first_name asc

--6. Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.
SELECT
  sum(CASE WHEN gender = 'M' THEN 1 end) as 'male_count',
  sum(CASE WHEN gender = 'F' THEN 1 end) as 'female_count' 
FROM patients;

--ALTERNATE SOLUTION
SELECT
	(SELECT * FROM patients WHERE gender = 'M') as 'male_patients'
	,(SELECT * FROM patients WHERE gender = 'F') as 'female_patients'

--7. Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. 
--Show results ordered ascending by allergies then by first_name then by last_name.
SELECT 	first_name,last_name,allergies
FROM 	patients
WHERE 	allergies in ('Penicillin','Morphine')
ORDER BY allergies,first_name,last_name

--8. Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
SELECT
  patient_id,
  diagnosis
FROM admissions
GROUP BY
  patient_id,
  diagnosis
HAVING COUNT(*) > 1
	
--9. Show the city and the total number of patients in the city.
--Order from most to least patients and then by city name ascending.
SELECT 	city, count(*) as 'number_of_patients'
FROM 	patients
GROUP BY city
ORDER BY number_of_patients DESC, city ASC

--10. Show first name, last name and role of every person that is either patient or doctor.
--The roles are either "Patient" or "Doctor"
SELECT 	first_name, last_name, "Patient" AS 'Role'
FROM 	patients
UNION ALL --Allows duplicate values
SELECT 	first_name, last_name, "Doctor" AS 'Role'
FROM 	doctors

--11. Show all allergies ordered by popularity. Remove 'NKA' and NULL values from query.
SELECT 	allergies, COUNT(*) as 'Number'
FROM 	patients
WHERE 	allergies != 'NKA'
AND 	allergies is not null 
ORDER BY Number DESC 

--12. Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
SELECT
  first_name
  ,last_name
  ,birth_date
FROM patients
WHERE
  YEAR(birth_date) BETWEEN 1970 AND 1979
ORDER BY birth_date ASC;

--13. We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order
--EX: SMITH,jane
SELECT
  CONCAT(UPPER(last_name), ',', LOWER(first_name)) AS new_name_format
FROM patients
ORDER BY first_name DESC;

--14. Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
--province_id | sum of height
SELECT
  province_id,
  SUM(height) AS s_h
FROM patients
GROUP BY province_id
HAVING s_h >= 7000

--15. Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
SELECT
  MAX(weight) - MIN(weight)
FROM patients
WHERE last_name = 'Maroni';

--16. Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.
SELECT
  DISTINCT(DAY(admission_date)) AS 'day_number',
  COUNT(*) AS 'number_of_admissions'
FROM admissions
GROUP BY day_number
ORDER BY number_of_admissions DESC

--17. Show the all columns for patient_id 542's most recent admission_date.
SELECT 	*
FROM	admissions
WHERE 	patient_id = '542'
ORDER BY 
	admission_date DESC
LIMIT 1

--ALTERNATE SOLUTIONS
--Utilizing MAX(admission_date) is clever
SELECT *
FROM admissions
WHERE patient_id = 542
GROUP BY patient_id
HAVING
  admission_date = MAX(admission_date);

SELECT *
FROM admissions
GROUP BY patient_id
HAVING
  patient_id = 542
  AND max(admission_date)

--18. Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
--1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
--2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.
--NOTES
--patient_id | attending_doctor_id | diagnosis
--patient_id must be odd, attending_doctor_id in (1, 5, 19)
--or
--attending_doctor_id like %2% length(patient_id) = 3
SELECT
  patient_id
  ,attending_doctor_id
  ,diagnosis
FROM admissions
WHERE
	(attending_doctor_id IN (1, 5, 19) AND patient_id % 2 > 0)
  OR 	(attending_doctor_id LIKE '%2%' AND len(patient_id) = 3)

--19. Show first_name, last_name, and the total number of admissions attended for each doctor.
--Note: Every admission has been attended by a doctor.
SELECT
  doc.first_name
  ,doc.last_name
  ,COUNT(*) as 'total_admissions'
FROM 	admissions adm
JOIN	doctors doc ON
	(adm.attending_doctor_id = doc.doctor_id)
GROUP BY
	doc.first_name,doc.last_name

--20. For each doctor, display their id, full name, and the first and last admission date they attended.
--doctor_id | first_name + last_name | first_admission | last_admission
SELECT
  d.doctor_id,
  a.first_name || ' ' || a.last_name AS 'full_name', --CONCAT(d.first_name,' ',d.last_name)
  min(admission_date) AS 'first_admission',
  max(admission_date) AS 'last_admission'
FROM admissions a
  JOIN doctors d ON a.attending_doctor_id = d.doctor_id
GROUP BY
	doctor_id

--21. Display the total amount of patients for each province. Order by descending.
--province | total_patients
SELECT
	province_name
	,COUNT(*) AS 'total_patients'
FROM
	province_names pn
JOIN 	patients p ON pn.province_id = p.province_id
GROUP BY
	province_name
ORDER BY COUNT(*) DESC

--22. For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.
SELECT
	p.first_name || ' ' || p.last_name as 'patient_full_name'
	,a.diagnosis
	,d.first_name || ' ' || d.last_name as 'doctor_full_name'
FROM 	patients
JOIN 	admissions 
	ON admissions.patient_id = patients.patient_id
JOIN 	doctors 
	ON doctors.doctor_id = admissions.attending_doctor_id

--23. Display the first name, last name and number of duplicate patients based on their first name and last name.
SELECT
  first_name,
  last_name,
  COUNT(*) AS 'duplicates'
FROM patients
GROUP BY
  first_name, last_name
HAVING COUNT(*) > 1


/*24. Display patient's full name,
height in the unit feet rounded to 1 decimal,
weight in the unit pounds rounded to 0 decimals,
birth_date,
gender non abbreviated.

Convert CM to feet by dividing by 30.48.
Convert KG to pounds by multiplying by 2.205.*/
SELECT
	first_name || ' ' || last_name
    	,round((height / 30.48),1)
    	,round((weight * 2.205),0)
    	,birth_date
    	,CASE 
    		WHEN gender = 'F' THEN 'Female'
        	WHEN gender = 'M' THEN 'Male'
        END AS 'gender'
FROM
	patients

--25. Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. 
--(Their patient_id does not exist in any admissions.patient_id rows.)
--patient_id | first name | last name
SELECT
  patients.patient_id,
  first_name,
  last_name
FROM patients p
LEFT OUTER JOIN admissions a ON --LEFT OUTER JOIN is not supported in their webapp. This is just doing a LEFT JOIN so that's why the WHERE statement is necessary.
	(p.patient_id = a.patient_id)
WHERE a.admission_date IS NULL

--ALTERNATE SOLUTION
SELECT
  patients.patient_id,
  first_name,
  last_name
from patients
where patients.patient_id not in (
    select admissions.patient_id
    from admissions
  )
