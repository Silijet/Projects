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
