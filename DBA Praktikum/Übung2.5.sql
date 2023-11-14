SET search_path TO filmDB;


create view aktuelle_bewertung (film_id,titel,punkte,datum) As 
select film.film_id, film.titel ,bewertung.punkte, bewertung.datum 
from film join bewertung on film.film_id = bewertung.film_id where datum > '01.07.2020'

select * from aktuelle_bewertung 

create view gute_filme (film_id,titel) As 
select distinct film.film_id, film.titel 
from film join bewertung on film.film_id = bewertung.film_id where bewertung.punkte >= 3

select * from gute_filme 

--
--CREATE TRIGGER Filme2020_Insert
--INSTEAD OF INSERT ON Filme2020
--REFERENCING NEW AS N
--FOR EACH ROW
--INSERT INTO Film
--(FilmID, Titel, Genre, Jahr, Regie, Bewertung)
--VALUES
--((SELECT COALESCE(MAX(FilmID),0)+1 FROM Film), N.Titel, N.Genre, 2020, NULL, NULL);

-- Trigger in PostgreSQL als trigger function:

CREATE FUNCTION UpdateFilm()
RETURNS TRIGGER
LANGUAGE plpgsql -- plpsql = Procedural Language/PostgreSQL
AS $$
BEGIN
 update film set titel = new.titel where film_id = new.film_id;
 
RETURN NEW;
END;
$$;
CREATE TRIGGER UpdateFilm
 Instead Of Update
 ON aktuelle_bewertung
 FOR EACH ROW
 EXECUTE PROCEDURE 
 UpdateFilm();
END; 

select titel from aktuelle_bewertung
update aktuelle_bewertung set titel = 'Der Herr der Dinge - Die Gelehrten2' where film_id = 108;




CREATE FUNCTION UpdateFilmId()
RETURNS TRIGGER
LANGUAGE plpgsql -- plpsql = Procedural Language/PostgreSQL
AS $$
BEGIN
 update film set film_id = new.film_id where titel = new.titel;
 
RETURN NEW;
END;
$$;
CREATE TRIGGER UpdateFilmid
 Instead Of Update
 ON aktuelle_bewertung
 FOR EACH ROW
 EXECUTE PROCEDURE 
 UpdateFilmId();
END; 

select * from film
update aktuelle_bewertung set film_id = 2308 where titel = 'Der Herr der Dinge - Die Gelehrten2'


--e

CREATE FUNCTION DeleteFilm()
RETURNS TRIGGER
LANGUAGE plpgsql -- plpsql = Procedural Language/PostgreSQL
AS $$
BEGIN

 delete from bewertung where film_id = old.film_id;
 
RETURN NEW;
END;
$$;
CREATE TRIGGER DeleteFilm
 Instead Of Delete
 ON gute_filme
 FOR EACH ROW
 EXECUTE PROCEDURE 
 DeleteFilm();
END; 


select * from gute_filme
delete from gute_filme where film_id = 101