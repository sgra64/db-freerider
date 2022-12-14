DROP SCHEMA IF EXISTS FREERIDER_DB;

CREATE SCHEMA IF NOT EXISTS FREERIDER_DB;
USE FREERIDER_DB;


DROP TABLE IF EXISTS CUSTOMER;
CREATE TABLE CUSTOMER (
  ID INT NOT NULL,
  NAME VARCHAR(60) DEFAULT NULL,
  CONTACT VARCHAR(60) DEFAULT NULL,
  STATUS ENUM('Active', 'InRegistration', 'Terminated') DEFAULT NULL,
  PRIMARY KEY (ID)
);


DROP TABLE IF EXISTS VEHICLE;
CREATE TABLE VEHICLE (
  ID INT NOT NULL,
  /* --complete schema based on ERD-diagram */
  /* -- */
  PRIMARY KEY (ID)
);


DROP TABLE IF EXISTS RESERVATION;
CREATE TABLE RESERVATION (
  ID INT NOT NULL,
  CUSTOMER_ID INT NOT NULL,
  /* --complete schema based on ERD-diagram */
  /* -- */
  PRIMARY KEY (ID),
  /* --complete schema based on ERD-diagram */
  /* -- */
  KEY IDX_CUSTOMER_ID (CUSTOMER_ID),
  CONSTRAINT CUSTOMER_ID FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER (ID)
  /* -- */
);
