-- Queries
--1. List the first name and last name of female patients who live in St Kilda or Lidcombe
SELECT firstname,lastname, suburb FROM patient
WHERE gender = 'female' AND suburb IN ('St Kilda', 'Lidcombe');

--2. List the first name, last name, state and Medicare Number of any patients who do not live in NSW.
SELECT firstname, lastname, state, medicarenumber FROM patient
WHERE state != 'NSW';

-- 3. List each patient's first name, last name, Medicare Number and date of birth. Sort the list by date of birth, listing the youngest patients first
SELECT firstname, lastname, medicarenumber, dateofbirth FROM patient
ORDER BY dateofbirth DESC;

--4. For each practitioner, list their ID, first name, last name, the total number of days and the total number of hours 
SELECT p.practitioner_ID, p.firstname, p.lastname,
    count(a.weekdayname_ref) AS total_days,
    count(a.weekdayname_ref)*9 AS total_hours FROM practitioner p
    JOIN Availability a ON p.practitioner_ID = a.Practitioner_Ref
    GROUP BY p.practitioner_ID
    ORDER BY total_days DESC;

--5. List the Patient's first name, last name and the appointment date and time, for all appointments held on 18/09/2019 by Dr Anne Funsworth
SELECT p.firstname, p.lastname, a.AppDate, a.AppStartTime FROM appointment a
JOIN practitioner pr ON a.Practitioner_Ref = pr.practitioner_ID
JOIN patient p ON a.Patient_Ref = p.Patient_ID
WHERE 
  pr.firstname = 'Anne'
  AND pr.lastname = 'Funsworth'
  AND pr.title = 'Dr'
  AND a.AppDate = '2019-09-18';

--6. List the ID and date of birth of any patient who has not had an appointment and was born before 1950.
SELECT 
  Patient_ID, dateofbirth FROM Patient
WHERE
  Patient_ID NOT IN (
    SELECT Patient_Ref FROM Appointment
  )
  AND dateofbirth < '1950-01-01';

--7. List the patient ID, first name, last name and the number of appointments for patients who have had at least three appointments.
SELECT p.Patient_ID, p.firstname, p.lastname, count(a.Patient_Ref) AS num_appointments
FROM Patient p
JOIN appointment a ON p.Patient_ID = a.Patient_Ref
GROUP BY p.Patient_ID
HAVING num_appointments >=3
ORDER BY num_appointments DESC;

--8. List the first name, last name, gender, and the number of days since the last appointment of each patient and 23/09/2019
SELECT p.firstname, p.lastname, p.gender, 
      datediff('2019-09-23', max(a.AppDate)) AS days_since_last_app
FROM patient p
JOIN appointment a ON p.Patient_ID = a.Patient_Ref
GROUP BY p.Patient_ID
ORDER BY days_since_last_app DESC;

--9. List according to given format "Dr Mark P. Huston. 21 Fuller Street SUNSHINE, NSW 2343"
SELECT concat(
  title, ' ', firstname, ' ', middleinitial, '. ', lastname, '. ', houseunitlotnum, ' ',
  street, ' ', Upper(suburb), ', ', state, ' ', postcode) AS full_practitioner_info
FROM practitioner
ORDER BY lastname, firstname, middleinitial;

--10.	List the patient id, first name, last name and date of birth of the fifth oldest patient(s). 
SELECT Patient_ID, firstname, lastname, dateofbirth FROM patient
WHERE DateOfBirth = (
    SELECT DateOfBirth
    FROM Patient
  ORDER BY dateofbirth ASC
  LIMIT 1 OFFSET 4);

--11. 
SELECT p.Patient_ID, p.firstname, p.lastname,
date_format(a.AppDate, '%W %e %M, %Y') AS formatted_date,
date_format(a.AppStartTime, '%H:%i %p') AS formatted_time FROM patient p
JOIN appointment a ON p.Patient_ID = a.Patient_Ref
WHERE
  DAYOFWEEK(a.AppDate) = 3
  AND a.AppStartTime > '10:00:00'
ORDER BY a.AppDate, a.AppStartTime;

--12. 
  SELECT houseunitlotnum, street, suburb, state, postcode FROM Patient
  UNION
  SELECT houseunitlotnum, street, suburb, state, postcode FROM Practitioner
ORDER BY postcode;

