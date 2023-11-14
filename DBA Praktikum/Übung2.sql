SET search_path TO ausleihe;

Select * from buchex
Select * from leser
Select * from ausleihe 
Select * from ausleihhistorie

Insert Into Leser (LID,Lesername,GebJahr)
Values(1,'Schmidt',1950);
Insert Into Leser (LID,Lesername,GebJahr)
Values(2,'Mueller',1954);

Insert Into BuchEx (ISBN,ExplNR,Titel,Autorname)
Values ('A',1,'Java','Krause');
Insert Into BuchEx (ISBN,ExplNR,Titel,Autorname)
Values ('A',2,'Java','Krause');
Insert Into BuchEx (ISBN,ExplNR,Titel,Autorname)
Values ('B',1,'XML','Mueller');

Insert Into Ausleihe (ISBN,ExplNR,Datum,LeserID)
Values('A',1,'2022-10-13',1);
Insert Into Ausleihe (ISBN,ExplNR,Datum,LeserID)
Values('B',1,'2022-10-16',1);

-- 2.
Delete from Leser where(LID=1)
-- Kann nicht gelöscht werden, weil der die LeserId ein Fremd-
-- schlüssel in einer anderen Tabelle ist.

Delete from Leser where(Lesername = 'Mueller')
-- Funktioniert

Delete from BuchEx where(ISBN = 'A' and ExplNr = 1 and Titel = 'Java' and Autorname = 'Krause')
-- Funktioniert 

Delete from Ausleihe where (ISBN = 'A' and ExplNr = 1)
-- Funktioniert

-- 3.

alter Table Leser add constraint unique_Leser unique(Lesername)
alter Table Leser add constraint Altersgrenze check(1900 < GebJahr  and GebJahr < 2010)

Create Table Ausleihhistorie (
	Datum Date,
	LeserId integer
);

CREATE FUNCTION trigger_function() -- Eigentliche Funktion
RETURNS TRIGGER
LANGUAGE plpgsql -- plpsql = Procedural Language/PostgreSQL
AS $$
BEGIN
 -- TRIGGER LOGIC
	Insert Into AusleihHistorie (Datum,LeserId)
	Values(old.Datum,old.LeserId);
RETURN NEW;
END;
$$;

CREATE TRIGGER AusleiheTrigger
  AFTER Delete on Ausleihe

  FOR EACH ROW 
 EXECUTE PROCEDURE trigger_function();
END; 



CREATE FUNCTION trigger_function() -- Eigentliche Funktion
RETURNS TRIGGER
LANGUAGE plpgsql -- plpsql = Procedural Language/PostgreSQL
AS $$
BEGIN
 -- TRIGGER LOGIC
	Insert Into AusleihHistorie (Datum,LeserId)
	Values(old.Datum,old.LeserId);
RETURN NEW;
END;
$$;
-- d)

Select Autorname, BuchEx.ISBN from BuchEx join Ausleihe on BuchEx.ISBN = Ausleihe.ISBN


--4a)
CREATE VIEW ausgeliehen(ISBN,ExplNr,Titel) AS
SELECT DISTINCT ausleihe.ISBN,ausleihe.ExplNr,Titel
FROM ausleihe INNER JOIN BuchEx ON ausleihe.ISBN = BuchEx.ISBN;

select * from ausgeliehen

--4b)
CREATE VIEW unausgeliehen(ISBN,Autorname) AS
SELECT buchex.ISBN,BuchEx.autorname
FROM buchex
WHERE buchex.ISBN NOT IN (select ISBN from ausleihe);

select * from unausgeliehen

--4c)
CREATE VIEW AusleihAnzahl(ISBN,Anzahl_Exemplare) AS
SELECT ausleihe.ISBN,COUNT(ISBN)
FROM ausleihe
GROUP BY ISBN;

select * from AusleihAnzahl

--4d)
SELECT * FROM AusleihAnzahl
WHERE Anzahl_Exemplare = (
   SELECT MAX (Anzahl_Exemplare)
   FROM AusleihAnzahl
);

--4e)
SELECT * FROM AusleihAnzahl
WHERE Anzahl_Exemplare = 0;