-- Loading CSV Files
-- 1. WeekDays (no FKs)
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.3/Uploads/19_WeekDaysData.csv'
into table WeekDays
fields terminated by ','
optionally enclosed by "'"
lines terminated by '\r\n';

-- 2. PractitionerType (no FKs)
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.3/Uploads/17_PractitionerTypeData.csv'
INTO TABLE PractitionerType
FIELDS TERMINATED BY ','
ENCLOSED BY "'"
LINES TERMINATED BY '\r\n';


-- 3. Patient 
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.3/Uploads/15_PatientData.csv'
INTO TABLE Patient
fields terminated by ', '
Optionally enclosed by ''''
lines terminated by '\r\n';

-- 4. Practitioner
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.3/Uploads/16_PractitionerData.csv'
INTO TABLE Practitioner
FIELDS TERMINATED BY ', '
OPTIONALLY ENCLOSED BY ''''
LINES TERMINATED BY '\r\n';

-- 5. Availability
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.3/Uploads/13_AvailabilityData.csv'
INTO TABLE Availability
FIELDS TERMINATED BY ', '
OPTIONALLY ENCLOSED BY "'"
LINES TERMINATED BY '\r\n';


-- 6. Appointment
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.3/Uploads/12_AppointmentData.csv'
INTO TABLE Appointment  
FIELDS TERMINATED BY ', '
optionally ENCLOSED BY "'"
LINES TERMINATED BY '\r\n';
