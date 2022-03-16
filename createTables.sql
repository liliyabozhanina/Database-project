/* Relational Schemas
Clinics (code, name, compartmentCode)
Compartments (code, name, phoneNumber)
Registry staff (code, name, address, phoneNumber, compartmentCodes, compartmentPhones, patientName, patientEGN, patientBirthDate, patientFile)
Doctors (code, name, address, specialization, compartmentName, compartmentPhones)
Patients (EGN, name, birthDate, phoneNumber, file)
Discount Cards (code, dateOfIssue, validity, patientName, patientEGN, patientBirthDate)
Medication (code, name, expiryDate)
*/

SET SCHEMA FN71873;

DROP TABLE Clinics;
DROP TABLE Compartments;
DROP TABLE RegistryStaff;
DROP TABLE Doctors;
DROP TABLE Patients;
DROP TABLE DiscountCards;
DROP TABLE Medication;

--Clinics (code, name, compartmentCode)
CREATE TABLE Clinics (
    CODE VARCHAR(10) NOT NULL CONSTRAINT PK_CLINICS PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL,
    COMPARTMENTCODE VARCHAR(10) NOT NULL CONSTRAINT FK_CLINICS_COMPARTMENTS REFERENCES COMPARTMENTS(CODE)
);

--Compartments (code, name, phoneNumber)
CREATE TABLE Compartments (
    CODE VARCHAR(10) NOT NULL CONSTRAINT PK_COMPARTMENTS PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL,
    PHONENUMBER VARCHAR(10)
);

--Registry staff (code, name, address, phoneNumber, compartmentCodes, compartmentPhones, patientName, patientEGN, patientBirthDate, patientFile)
CREATE TABLE RegistryStaff (
    CODE VARCHAR(10) NOT NULL CONSTRAINT PK_REGISTRYSTAFF PRIMARY KEY,
    NAME VARCHAR(50),
    ADDRESS VARCHAR(200),
    PHONENUMBER VARCHAR(10),
    COMPARTMENTPHONES VARCHAR(10) CONSTRAINT FK_REGISTRYSTAFF_COMPARTMENTS REFERENCES COMPARTMENTS(PHONENUMBER),
    PATIENTNAME VARCHAR(50) NOT NULL FK_REGISTRYSTAFF_PATIENTS REFERENCES PATIENTS(NAME),
    PATIENTEGN VARCHAR(10) NOT NULL FK_REGISTRYSTAFF_PATIENTS REFERENCES PATIENTS(EGN),
    PATIENTBIRTHDATE DATE FK_REGISTRYSTAFF_PATIENTS REFERENCES PATIENTS(BIRTHDATE),
    PATIENTFILE VARCHAR(1000) REGISTRYSTAFF_PATIENTS REFERENCES PATIENTS(FILE)
);

--Doctors (code, name, address, compartmentName, compartmentPhones)
CREATE TABLE Doctors (
    CODE VARCHAR(10) NOT NULL CONSTRAINT PK_DOCTORS PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL,
    ADDRESS VARCHAR(200),
    SPECIALIZATION VARCHAR(30),
    COMPARTMENTNAME VARCHAR(50) NOT NULL FK_DOCTORS_COMPARTMENTS REFERENCES COMPARTMENTS(NAME),
    COMPARTMENTPHONES VARCHAR(10) FK_DOCTORS_COMPARTMENTS REFERENCES COMPARTMENTS(PHONENUMBER)
);

ALTER TABLE DOCTORS
ADD SALARY DOUBLE;

--Patients (EGN, name, birthDate, phoneNumber, file)
CREATE TABLE Patients (
    EGN VARCHAR(10) NOT NULL CONSTRAINT PK_PATIENTS PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL,
    BIRTHDATE DATE,
    PHONENUMBER VARCHAR(10),
    FILE VARCHAR(1000)
);

--Discount Cards (code, dateOfIssue, validity, patientName, patientEGN, patientBirthDate)
CREATE TABLE DiscountCards (
    CODE VARCHAR(10) NOT NULL CONSTRAINT PK_DISCOUNTCARDS PRIMARY KEY,
    DATEOFISSUE DATE NOT NULL,
    VALIDITY DATE,
    PATIENTNAME VARCHAR(50) NOT NULL FK_DISCOUNTCARDS_PATIENTS REFERENCES PATIENTS(NAME),
    PATIENTEGN VARCHAR(10) NOT NULL FK_DISCOUNTCARDS_PATIENTS REFERENCES PATIENTS(EGN),
    PATIENTBIRTHDATE DATE NOT NULL FK_DISCOUNT_PATIENTS REFERENCES PATIENTS(BIRTHDATE)
);

--Medication (code, name, expiryDate)
CREATE TABLE Medication (
    CODE VARCHAR(10) NOT NULL CONSTRAINT PK_MEDICATION PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL,
    EXPIRITYDATE DATE NOT NULL
);
