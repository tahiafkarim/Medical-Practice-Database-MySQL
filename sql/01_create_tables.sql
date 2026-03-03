/* ..............Table PATIENT.............*/
create table patient(
    Patient_ID       INTEGER       NOT NULL auto_increment,
    Title            NVARCHAR(20)  NULL,
    FirstName        NVARCHAR(50)  NOT NULL default '',
    MiddleInitial    NCHAR(1)      NULL,
    LastName         NVARCHAR(50)  NOT NULL default '',
    HouseUnitLotNum  NVARCHAR(5)   NOT NULL default '',
    Street           NVARCHAR(50)  NOT NULL default '',
    Suburb           NVARCHAR(50)  NOT NULL default '',
    State            NCHAR(3)   NOT NULL default '',
    PostCode         NCHAR(4)      NOT NULL default '',
    HomePhone        NCHAR(11)     NULL,
    MobilePhone      NCHAR(11)     NULL,
    MedicareNumber   NCHAR(16)     NULL,
    DateOfBirth      DATE          NOT NULL default (CURDATE()),
    Gender           NVARCHAR(15)     NOT NULL default '',
    CONSTRAINT PK_Patient PRIMARY KEY (Patient_ID)
);

/* .............. Table PRACTITIONERTYPE.............*/
create table PractitionerType(
    PractitionerType NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_PractitionerType PRIMARY KEY (PractitionerType)
);

/* .............. Table WEEKDAYS.............*/
create table WeekDays (
    WeekDayName NVARCHAR(11) NOT NULL,
    CONSTRAINT PK_WeekDays PRIMARY KEY (WeekDayName)
);

/* ..............Table Practitioner.............*/
create table Practitioner(
    Practitioner_ID          INTEGER       NOT NULL auto_increment,
    MedicalRegistrationNumber NCHAR(11)    NOT NULL default '',
    Title                    NVARCHAR(20)  NULL,
    FirstName                NVARCHAR(50)  NOT NULL default '',
    MiddleInitial            NCHAR(1)      NULL,
    LastName                 NVARCHAR(50)  NOT NULL default '',
    HouseUnitLotNum          NVARCHAR(5)  NOT NULL default '',
    Street                   NVARCHAR(50)  NOT NULL default '',
    Suburb                   NVARCHAR(50)  NOT NULL default '',
    State                    NVARCHAR(3)   NOT NULL default '',
    PostCode                 NCHAR(4)      NOT NULL default '',
    HomePhone                NCHAR(10)      NULL,
    MobilePhone              NCHAR(10)      NULL,
    MedicareNumber           NCHAR(16)     NULL,
    DateOfBirth              DATE          NOT NULL default (CURDATE()),
    Gender                   NVARCHAR(20)     NOT NULL default '',
    PractitionerType_Ref     NVARCHAR(50)  NOT NULL default '',
    CONSTRAINT PK_Practitioner PRIMARY KEY (Practitioner_ID),
    CONSTRAINT FK_Practitioner_PractitionerType FOREIGN KEY (PractitionerType_Ref) REFERENCES PractitionerType(PractitionerType),
    CONSTRAINT AK_Practitioner_MedicalReg UNIQUE (MedicalRegistrationNumber)
);

--Modify the character length of the middleinitial field to 5
alter table Patient
modify MiddleInitial varchar(5) null;

/* ..............Table AVAILABILITY.............*/
create table Availability(
    Practitioner_Ref INTEGER NOT NULL,
    WeekDayName_Ref NVARCHAR(9) NOT NULL,
    CONSTRAINT PK_WeekDays PRIMARY KEY (WeekDayName_Ref, Practitioner_Ref),
    CONSTRAINT FK_Availability_Weekdays FOREIGN KEY (WeekDayName_Ref) REFERENCES Weekdays(WeekDayName),
    CONSTRAINT FK_Availability_Practitioner FOREIGN KEY (Practitioner_Ref) REFERENCES Practitioner(Practitioner_ID)
);

/* ..............Table APPOINTMENT.............*/
create table Appointment(
    Practitioner_Ref INTEGER      NOT NULL,
    AppDate          DATE         NOT NULL,
    AppStartTime     TIME         NOT NULL,
    Patient_Ref      INTEGER      NOT NULL,
    CONSTRAINT PK_Appointment PRIMARY KEY (Practitioner_Ref, AppDate, AppStartTime),
    CONSTRAINT FK_Appointment_Practitioner FOREIGN KEY (Practitioner_Ref) REFERENCES Practitioner(Practitioner_ID),
    CONSTRAINT FK_Appointment_Patient FOREIGN KEY (Patient_Ref) REFERENCES Patient(Patient_ID),
    CONSTRAINT AK_Appointment_PatientDateTime UNIQUE (Patient_Ref, AppDate, AppStartTime)
);

