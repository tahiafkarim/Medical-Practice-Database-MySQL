# Medical Practice Database – Technical Documentation

## 1. Business Requirements Summary

The database was designed to support the operations of a medical practice. The system must:

- Store patient information.
- Store practitioner information, including AHPRA and Medicare numbers.
- Record practitioner availability by weekday.
- Schedule appointments in 15-minute intervals.
- Prevent double booking of practitioners.
- Prevent double booking of patients.
- Record pathology tests and pathology requests.
- Ensure each household receives only one newsletter.

---

## 2. Database Design Approach

The database was designed using relational modeling principles and normalized to Third Normal Form (3NF).

Key design decisions:

- Separate table for PractitionerType to avoid repetition.
- Separate table for Weekdays to standardize availability.
- PractitionerAvailability used as an associative table.
- Unique constraints used for Medicare and AHPRA numbers.
- Composite unique constraint used to prevent appointment double booking.

---

## 3. Entity Descriptions

### Patient
Stores patients' personal and contact details.

Primary Key:
- patient_id

Important Constraints:
- Medicare number must be unique.

---

### Practitioner
Stores doctor and nurse details.

Primary Key:
- practitioner_id

Important Constraints:
- AHPRA registration number must be unique.
- Medicare number must be unique.

---

### Appointment
Stores appointment details between the patient and the practitioner.

Business Rules:
- Appointment time must follow 15-minute intervals.
- A practitioner cannot have two appointments on the same date and time.
- A patient cannot have two appointments on the same date and time.

---

## 4. Views Implemented

### vwNurseDays
Returns nurse name, phone details, and working days.

### vwNSWPatients
Returns all patient details for patients residing in NSW.

---

## 5. Stored Procedures Implemented

### spSelect_vwNSWPatients
Retrieves NSW patients ordered by postcode.

### spInsert_vwNSWPatients
Inserts a new NSW patient using parameters.

### spModify_PractitionerMobilePhone
Updates a practitioner’s mobile number using the Practitioner ID and the new mobile number.

---

## 6. Data Import Method

Data was imported using MySQL 8.3 CLI with:

LOAD DATA INFILE

CSV files were structured with:
- Comma-separated values
- Proper date formatting
- Header row ignored during import

---

## 7. Assumptions

- Workday consists of 9 hours.
- Appointments are fixed at 15-minute intervals.
- Historical data is not maintained.
- Practitioners can be marked inactive instead of deleted.

---

## 8. Future Improvements

- Add triggers to enforce 15-minute time validation.
- Add indexing for performance optimization.
- Implement role-based access control.
- Create reporting dashboards using Power BI.
