#CREATE DATABASE programming_project;

USE programming_project;

CREATE TABLE flight_data  
(
ORIGIN					CHAR(3),
ORIGIN_CITY_NAME		VARCHAR(50),
ORIGIN_STATE_ABR		CHAR(2),
ORIGIN_WAC				INT
);

INSERT INTO flight_data VALUES
("WAS", "Washington DC", "WD", 21),
("OKL", "Oklahoma", "OK", 12);

SELECT * FROM flight_data;