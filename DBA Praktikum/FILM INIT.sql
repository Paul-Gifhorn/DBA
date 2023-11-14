CREATE SCHEMA filmDB;
SET search_path TO filmDB;

DROP TABLE IF EXISTS bewertung CASCADE;
DROP TABLE IF EXISTS film CASCADE;
DROP TABLE IF EXISTS nutzer CASCADE;

CREATE TABLE film (
 film_id INT PRIMARY KEY,
 titel VARCHAR(255),
 jahr INT, 
 regisseur VARCHAR(255)
);
CREATE TABLE nutzer (
 nutzer_id INT PRIMARY KEY,
 name VARCHAR(255)
);
 CREATE TABLE bewertung (
 film_id INT,
 nutzer_id INT,
 punkte INT,
 datum DATE,
 CONSTRAINT pk PRIMARY KEY(film_id,nutzer_id),
 CONSTRAINT film_fk FOREIGN KEY (film_id) REFERENCES film(film_id) ON UPDATE CASCADE,
 CONSTRAINT nutzer_fk FOREIGN KEY (nutzer_id) REFERENCES nutzer(nutzer_id) ON UPDATE CASCADE
);

INSERT INTO film(film_id, titel, jahr, regisseur) VALUES 
(101,'Die Verurteilten',1994,'Frank Darabont'),
(102,'Der Pate',1972,'Francis Ford Coppola'),
(103,'Pulp Fiction',1994,'Quentin Tarantino'),
(104,'Schindlers Liste',1993,'Steven Spielberg'),
(105,'Fight Club',1999,'David Fincher'),
(106,'Forrest Gump',1994,'Robert Zemeckis'),
(107,'Django Unchained',2012,'Quentin Tarantino'),
(108,'Der Herr der Ringe - Die Gefährten',2001,'Peter Jackson');

INSERT INTO nutzer(nutzer_id,name) VALUES 
('201', 'Müller'),
('202', 'Schmidt'),
('203', 'Schneider'),
('204', 'Fischer'),
('205', 'Weber'),
('206', 'Meyer'),
('207', 'Wagner'),
('208', 'Becker');

INSERT INTO bewertung(nutzer_id,film_id,punkte,datum) VALUES 
(201,101,1,TO_DATE('2020-07-01', 'YYYY-MM-DD')),
(201,105,5,TO_DATE('2020-07-03', 'YYYY-MM-DD')),
(202,108,3,TO_DATE('2020-07-10', 'YYYY-MM-DD')),
(203,102,4,TO_DATE('2020-07-01', 'YYYY-MM-DD')),
(203,105,2,TO_DATE('2020-07-10', 'YYYY-MM-DD')),
(203,107,4,TO_DATE('2020-07-06', 'YYYY-MM-DD')),
(204,101,3,TO_DATE('2020-07-01', 'YYYY-MM-DD')),
(205,106,4,NULL),
(206,106,4,TO_DATE('2020-05-06', 'YYYY-MM-DD')),
(207,101,5,TO_DATE('2020-05-10', 'YYYY-MM-DD')),
(207,102,1,TO_DATE('2020-05-03', 'YYYY-MM-DD')),
(208,104,2,TO_DATE('2020-05-06', 'YYYY-MM-DD')),
(208,107,3,NULL),
(208,108,2,TO_DATE('2020-05-03', 'YYYY-MM-DD'));
