
CREATE SCHEMA LAB1;

USE LAB1;

CREATE TABLE THEMEPARK(
    PARK_CODE VARCHAR(10) not NULL primary key,
    PARK_NAME VARCHAR(35) not NULL,
    PARK_CITY VARCHAR(50) not NULL,
    PARK_COUNTRY CHAR(2) not NULL
);

create table EMPLOYEE( 
    EMP_NUM NUMERIC(4) PRIMARY KEY NOT NULL, 
    EMP_TITLE varchar(4), 
    EMP_LNAME varchar(15) not null, 
    EMP_FNAME varchar(15) not null, 
    EMP_DOB DATE NOT NULL, 
    EMP_HIRE_DATE DATE NOT NULL, 
    EMP_AREACODE varchar(4) NOT NULL, 
    EMP_PHONE varchar(12) NOT NULL, 
    PARK_CODE varchar(10) NOT NULL, 
    FOREIGN KEY (PARK_CODE) REFERENCES themepark(PARK_CODE)
    );

create table TICKET(
    TICKET_NO NUMERIC(10) NOT NUll PRIMARY KEY,
    TICKET_PRICE NUMERIC(4,2) NOT NULL,
    TICKET_TYPE varchar(10) not null,
    PARK_CODE varchar(10) not null,
    FOREIGN KEY (PARK_CODE) REFERENCES themepark(PARK_CODE)
    );

CREATE TABLE ATTRACTION(
    ATTRACT_NO NUMERIC(10) NOT NULL PRIMARY KEY,
    PARK_CODE varchar(10) NOT NULL,
    ATTRACT_NAME varchar(35) NOT NULL,
    ATTRACT_AGE NUMERIC(3) NOT NULL,
    ATTRACT_CAPACITY NUMERIC(3) NOT NULL,
    FOREIGN KEY (PARK_CODE) REFERENCES themepark(PARK_CODE)
    );

create table HOUR(
    EMP_NUM NUMERIC(4) NOT NULL,
    ATTRACT_NO NUMERIC(10) NOT NULL,
    HOURS_PER_AT_TRACT NUMERIC(2) NOT NULL,
    HOUR_RATE NUMERIC(4,2) NOT NULL,
    DATE_WORKED DATE NOT NULL,
    PRIMARY KEY (EMP_NUM,ATTRACT_NO),
    FOREIGN KEY (EMP_NUM) REFERENCES employee(EMP_NUM),
    FOREIGN KEY (ATTRACT_NO) REFERENCES attraction(ATTRACT_NO)
    );   