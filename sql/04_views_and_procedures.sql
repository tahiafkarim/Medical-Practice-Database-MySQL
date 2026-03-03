--1. Create a view (called vwNurseDays) with the name and phone details of any nurse (registered or not) and the days that they work
CREATE OR REPLACE VIEW vwNurseDays AS
SELECT concat(p.firstname,' ', p.middleinitial,' ', p.lastname) AS Full_Name, 
    p.homephone, p.mobilephone,
    a.weekdayname_ref AS working_days
FROM practitioner p
JOIN availability a ON p.practitioner_ID = a.Practitioner_Ref
WHERE p.PractitionerType_Ref IN ('nurse', 'Registered nurse');
--Run it
SELECT * FROM vwNurseDays;

--2. Using your view, write a query to retrieve the name and phone number details of all nurses who are scheduled to work on a Wednesday.
SELECT Full_Name, homephone, mobilephone FROM vwNurseDays
WHERE working_days = 'Wednesday';

--3. Create a view (called vwNSWPatients) that contains all patient details for patients whose address is in NSW.
CREATE OR REPLACE VIEW vwNSWPatients AS
SELECT title, firstname, middleinitial, lastname,
   houseunitlotnum, street,suburb, state, postcode
FROM patient
WHERE state = 'NSW';
--Run it
SELECT * FROM vwNSWPatients;

--4. Create a stored procedure (called spSelect_vwNSWPatients) to retrieve all records and columns from vwNSWPatients in postcode order ascending. 
DELIMITER $$

CREATE PROCEDURE spSelect_vwNSWPatients()
BEGIN
    select * from vwNSWPatients
    order by postcode asc;
END $$

DELIMITER ; -- Returning delimeter back to ;
CALL spSelect_vwNSWPatients();

--5. Create a stored procedure (called spInsert_vwNSWPatients) to insert a new record into vwNSWPatients, using parameters for all relevant data. 
DELIMITER $$
CREATE PROCEDURE spInsert_vwNSWPatients(
    IN p_title NVARCHAR(20),
    IN p_firstname NVARCHAR(50),
    IN p_middleinitial NCHAR(1),
    IN p_lastname NVARCHAR(50),
    IN p_house NVARCHAR(5),
    IN p_street NVARCHAR(50),
    IN p_suburb NVARCHAR(50),
    IN p_state NCHAR(3),
    IN p_postcode NCHAR(4)
)
BEGIN
    INSERT INTO Patient
    (title, firstname, middleinitial, lastname,
     houseunitlotnum, street, suburb, state, postcode)
    VALUES
    (p_title, p_firstname, p_middleinitial, p_lastname,
     p_house, p_street, p_suburb, p_state, p_postcode);
END $$
DELIMITER ;

CALL spInsert_vwNSWPatients(
    'Mr', 'Mickey', 'M', 'Mouse','1', 'Smith St', 'Smithville', 'NSW', 2222);

--6. & 7. Create a stored procedure (called spModify_PractitionerMobilePhone) using the Practitioner table to change a practitioner’s mobile phone number 
DELIMITER $$
CREATE PROCEDURE spModify_PractitionerMobilePhone (
    IN p_PractitionerID INT,
    IN p_NewMobile NCHAR(15)
)
BEGIN
    UPDATE Practitioner
    SET mobilephone = p_NewMobile
    WHERE practitioner_ID = p_PractitionerID;
END $$
DELIMITER ;
--Finding Hilda Brown
SELECT Practitioner_ID, FirstName, LastName FROM Practitioner
WHERE FirstName = 'Hilda' AND LastName = 'Brown';
--Call
CALL spModify_PractitionerMobilePhone(10001, '0412345678');

--8. Manipulate the Patient table 
ALTER TABLE Patient
ADD LastContactDate DATE DEFAULT (CURDATE());

--9. Create a trigger on the Appointment table that will update LastContactDate 
DELIMITER $$
CREATE TRIGGER tr_Appointment_AfterInsert
AFTER INSERT ON Appointment  --After a row is inserted
FOR EACH ROW                 -- Everytime a row is inserted
BEGIN
    UPDATE Patient
    SET LastContactDate = CURDATE()
    WHERE Patient_ID = NEW.Patient_Ref;
END $$
DELIMITER ;

--10. Delete the view vwNurseDays from the database.
DROP VIEW vwNurseDays;

--11. Delete the stored procedure spSelect_vwNSWPatients from the database.
DROP PROCEDURE spSelect_vwNSWPatients;

