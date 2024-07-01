--1. Show first name, last name, and gender of patients whose gender is 'M'

SELECT  first_name, last_name, gender
FROM	  patients
WHERE	  gender = 'M'

--2. Show first name and last name of patients who does not have allergies. (null)

SELECT	first_name,last_name
FROM	  patients
WHERE	  allergies is null

--3. Show first name of patients that start with the letter 'C'

SELECT  first_name
FROM	  patients
WHERE	  first_name like 'C%'

--4. Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)

SELECT	first_name,last_name
FROM	patients
WHERE	weight between 100 and 120

--5. Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'

Update	patients
SET 	  allergies = 'NKA'
WHERE	  allergies is null;

--6. Show first name and last name concatinated into one column to show their full name.

SELECT 	concat(first_name,' ',last_name)
FROM   	patients;

SELECT 	first_name || ' ' || last_name
FROM  	patients;

--7. Show first name, last name, and the full province name of each patient.
SELECT 	first_name, last_name, province_name
FROM   	patients a
JOIN    province_names b on a.province_id = b.province_id;

--8. Show how many patients have a birth_date with 2010 as the birth year.
SELECT  count(*)
FROM    patients a
WHERE   birth_date like '2010%';

--9. Show the first_name, last_name, and height of the patient with the greatest height.
SELECT 	first_name, last_name, height
FROM 	patients a
ORDER BY height desc
LIMIT 1

--10. Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000
SELECT	*
FROM	  patients a
WHERE   patient_id in (1,45,534,879,1000)

--11. Show the total number of admissions
SELECT 	count(*)
FROM  	admissions

--12. Show all the columns from admissions where the patient was admitted and discharged on the same day.
SELECT 	*
FROM  	admissions
WHERE  	admission_date = discharge_date

--13. Show the patient id and the total number of admissions for patient_id 579.
SELECT 	patient_id, count(*)
FROM   	admissions
WHERE 	patient_id = 579

--14. Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
SELECT	distinct(city)
FROM  	patients
WHERE 	province_id = 'NS'

--15. Write a query to find the first_name, last name and birth date of patients who has height greater than 160 and weight greater than 70
SELECT	first_name,last_name,birth_date
FROM  	patients
WHERE 	height > 160
AND   	weight > 70

--16. Write a query to find list of patients first_name, last_name, and allergies where allergies are not null and are from the city of 'Hamilton'
SELECT  first_name,last_name,allergies
FROM    patients
WHERE   1=1
AND     allergies is not null
AND   	city = 'Hamilton'
