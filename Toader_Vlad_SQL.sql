----------------------------------------------------------------------------------
--Crearea tabelelor

CREATE TABLE categorie
(id_categorie number(3) constraint pk_categorie primary key,
nume varchar2(50));

CREATE TABLE locatie
(id_locatie number(3) constraint pk_locatie primary key,
nume varchar2(100));

CREATE TABLE editura
(id_editura number(3) constraint pk_editura primary key,
nume varchar2(50),
adresa varchar2(100),
numar_telefon varchar2(15),
email varchar2(30),
id_locatie number(3),
constraint fk_editura_locatie foreign key (id_locatie) references locatie (id_locatie));

CREATE TABLE autor
(id_autor number(3) constraint pk_autor primary key,
prenume varchar2(30),
nume varchar2(30),
data_nasterii date);

CREATE TABLE abonament
(id_abonament number(3) constraint pk_abonament primary key,
pret number(2,2),
detalii varchar2(100));

CREATE TABLE carte
(id_carte number(3) constraint pk_carte primary key,
titlu varchar2(100),
an_aparitie number(4),
numar_pagini number(4),
pret number(3,2),
id_editura number(3),
id_categorie number(3),
constraint fk_carte_editura foreign key (id_editura) references editura (id_editura),
constraint fk_carte_categorie foreign key (id_categorie) references categorie (id_categorie));

CREATE TABLE exemplar
(id_exemplar number(3) constraint pk_exemplar primary key,
conditie varchar2(20),
disponibilitate varchar2(20),
id_carte number(3),
constraint fk_exemplar_carte foreign key (id_carte) references carte (id_carte));

CREATE TABLE cititor
(id_cititor number(3) constraint pk_cititor primary key,
prenume varchar2(100),
nume varchar2(100),
numar_telefon varchar2(15),
email varchar2(100),
tip_abonament number(3),
constraint fk_cititor_abonament foreign key (tip_abonament) references abonament (id_abonament));

CREATE TABLE scriere
(id_scriere number(3) constraint pk_scriere primary key,
id_autor number(3),
id_carte number(3),
constraint fk_scriere_autor foreign key (id_autor) references autor (id_autor),
constraint fk_scriere_carte foreign key (id_carte) references carte (id_carte));

CREATE TABLE imprumut
(id_imprumut number(3) constraint pk_imprumut primary key,
data_imprumut date,
data_restituire date,
id_exemplar number(3),
id_cititor number(3),
constraint fk_imprumut_exemplar foreign key (id_exemplar) references exemplar (id_exemplar),
constraint fk_imprumut_cititor foreign key (id_cititor) references cititor (id_cititor));

--Adaugarea constrangerilor suplimentare
ALTER TABLE exemplar
ADD CONSTRAINT check_disponibilitate
CHECK (disponibilitate in ('DISPONIBIL', 'IMPRUMUTAT'));

ALTER TABLE exemplar
ADD CONSTRAINT check_conditie
CHECK (conditie in ('NOUA', 'DETERIORATA'));

ALTER TABLE imprumut
ADD CONSTRAINT check_data
CHECK (data_restituire >= data_imprumut);

----------------------------------------------------------------------------------
--Inserarea in tabele
INSERT INTO categorie VALUES
(1, 'Thriller');
INSERT INTO categorie VALUES
(2, 'Fantasy');
INSERT INTO categorie VALUES
(3, 'Young adult');
INSERT INTO categorie VALUES
(4, 'Dezvoltare personala');
INSERT INTO categorie VALUES
(5, 'Aventura');
INSERT INTO categorie VALUES
(6, 'SF');

INSERT INTO locatie VALUES
(1, 'Bucuresti');
INSERT INTO locatie VALUES
(2, 'Iasi');
INSERT INTO locatie VALUES
(3, 'Timisoara');
INSERT INTO locatie VALUES
(4, 'Cluj');
INSERT INTO locatie VALUES
(5, 'Brasov');

INSERT INTO editura VALUES
(1, 'Humanitas', 'Piata Presei Libere nr. 1', '0214088355', 'secretariat@humanitas.ro', 1);
INSERT INTO editura VALUES
(2, 'Corint', 'Str. Mihai Eminescu nr. 54A', '0213194797', 'vanzari@edituracorint.ro', 1);
INSERT INTO editura VALUES
(3, 'Litera', 'Str. Moeciu nr. 6', '0374826635', 'contact@litera.ro', 3);
INSERT INTO editura VALUES
(4, 'Nemira', 'Splaiul Unirii nr. 6', ' 0213138978', 'office.bucuresti@polirom.ro', 4);
INSERT INTO editura VALUES
(5, 'Polirom', 'Str. Iani Buzoiani nr. 14', '0721747464', 'office@nemira.ro', 2);

INSERT INTO autor VALUES
(1, 'Stephen', 'King', to_date('21-09-1947', 'dd-mm-yyyy'));
INSERT INTO autor VALUES
(2, 'Leigh', 'Bardugo', to_date('06-04-1975', 'dd-mm-yyyy'));
INSERT INTO autor VALUES
(3, 'Adam', 'Silvera', to_date('07-06-1990', 'dd-mm-yyyy'));
INSERT INTO autor VALUES
(4, 'John', 'Green', to_date('24-08-1977', 'dd-mm-yyyy'));
INSERT INTO autor VALUES
(5, 'Brian', 'Tracy', to_date('05-01-1947', 'dd-mm-yyyy'));
INSERT INTO autor VALUES
(6, 'J.R.R.', 'Tolkien', to_date('03-01-1892', 'dd-mm-yyyy'));
INSERT INTO autor VALUES
(7, 'Jules', 'Verne', to_date('08-02-1828', 'dd-mm-yyyy'));

ALTER TABLE abonament MODIFY detalii VARCHAR2(500);
ALTER TABLE abonament MODIFY pret NUMBER(2,0);
INSERT INTO abonament VALUES
(1, 50, 'lunar premium - toate zonele');
INSERT INTO abonament VALUES
(2, 40, 'lunar standard - restrictionat la cartile de dezvoltare personala');
INSERT INTO abonament VALUES
(3, 20, 'saptamanal premium - acces in toate zonele');
INSERT INTO abonament VALUES
(4, 10, 'saptamanal standard - restrictionat la cartile de dezvoltare personala');
INSERT INTO abonament VALUES
(5, 5, 'zilnic - acces in toate zonele');

ALTER TABLE carte MODIFY pret NUMBER (5,2);
INSERT INTO carte VALUES
(1, 'Carrie', 1974, 199, 30, 1, 1);
INSERT INTO carte VALUES
(2, 'Mr. Mercedes', 2015, 488, 32.44, 2, 1);
INSERT INTO carte VALUES
(3, 'Regatul umbrelor', 2012, 344, 30, 5, 2);
INSERT INTO carte VALUES
(4, 'Banda celor sase ciori', 2013, 592, 41.65, 5, 2);
INSERT INTO carte VALUES
(5, 'Amandoi mor la sfarsit', 2021, 336, 45, 3, 3);
INSERT INTO carte VALUES 
(6, 'Sub aceeasi stea', 2013, 312, 43.50, 4, 3);
INSERT INTO carte VALUES
(7, 'Incepe ce nu-ti place!', 2001, 245, 20.50, 1, 4);
INSERT INTO carte VALUES
(8, 'Succesul in viata', 1993, 198, 25, 3, 4);
INSERT INTO carte VALUES
(9, 'Stapanul inelelor', 1954, 670, 63.50, 4, 5);
INSERT INTO carte VALUES
(10, 'Hobbitul', 1937, 532, 57, 2, 5);
INSERT INTO carte VALUES
(11, 'Silmarillion', 1977, 320, 40.99, 1, 2);
INSERT INTO carte VALUES
(12, 'Ocolul pamantului in 80 de zile', 1872, 243, 25, 5, 6);
INSERT INTO carte VALUES
(13, 'Insula misterioasa', 1875, 302, 28.5, 4, 6);

INSERT INTO exemplar VALUES
(1, 'NOUA', 'DISPONIBIL', 1);
INSERT INTO exemplar VALUES
(2, 'DETERIORATA', 'DISPONIBIL', 1);
INSERT INTO exemplar VALUES
(3, 'NOUA', 'IMPRUMUTAT', 2);
INSERT INTO exemplar VALUES
(4, 'DETERIORATA', 'IMPRUMUTAT', 2);
INSERT INTO exemplar VALUES
(5, 'NOUA', 'IMPRUMUTAT', 3);
INSERT INTO exemplar VALUES
(6, 'NOUA', 'IMPRUMUTAT', 3);
INSERT INTO exemplar VALUES
(7, 'DETERIORATA', 'IMPRUMUTAT', 3);
INSERT INTO exemplar VALUES
(8, 'NOUA', 'DISPONIBIL', 4);
INSERT INTO exemplar VALUES
(9, 'DETERIORATA', 'IMPRUMUTAT', 5);
INSERT INTO exemplar VALUES
(10, 'DETERIORATA', 'DISPONIBIL', 6);
INSERT INTO exemplar VALUES
(11, 'NOUA', 'IMPRUMUTAT', 6);
INSERT INTO exemplar VALUES
(12, 'NOUA', 'DISPONIBIL', 7);
INSERT INTO exemplar VALUES
(13, 'DETERIORATA', 'DISPONIBIL', 8);
INSERT INTO exemplar VALUES
(14, 'NOUA', 'IMPRUMUTAT', 9);
INSERT INTO exemplar VALUES
(15, 'NOUA', 'IMPRUMUTAT', 9);
INSERT INTO exemplar VALUES
(16, 'DETERIORATA', 'DISPONIBIL', 10);
INSERT INTO exemplar VALUES
(17, 'NOUA', 'IMPRUMUTAT', 11);
INSERT INTO exemplar VALUES
(18, 'DETERIORATA', 'DISPONIBIL', 11);
INSERT INTO exemplar VALUES
(19, 'NOUA', 'DISPONIBIL', 12);
INSERT INTO exemplar VALUES
(20, 'NOUA', 'DISPONIBIL', 12);
INSERT INTO exemplar VALUES
(21, 'DETERIORATA', 'IMPRUMUTAT', 13);

INSERT INTO cititor VALUES
(1, 'Theodor', 'Popescu', '0752111232', 'theo.p@hotmail.com', 1);
INSERT INTO cititor VALUES
(2, 'Talida', 'Boboc', '0753212343', 'talidaboboc@gmail.com', 4);
INSERT INTO cititor VALUES
(3, 'Andreea', 'Constantinescu', '0721433212', 'andreea.const@yahoo.com', 2);
INSERT INTO cititor VALUES
(4, 'Elena', 'Malancu', '0782232123', 'elena_malancu_01@gmail.com', 3);
INSERT INTO cititor VALUES
(5, 'Sofia', 'Vultur', '0742121854', 'sofiavultur@yahoo.com', 5);
INSERT INTO cititor VALUES
(6, 'Lucas', 'Pelmus', '0765211943', 'lucasss@hotmail.com', 1);
INSERT INTO cititor VALUES
(7, 'Mihail', 'Manea', '0732114666', 'mihail_seb@gmail.com', 3);

INSERT INTO scriere VALUES
(1, 1, 1);
INSERT INTO scriere VALUES
(2, 1, 2);
INSERT INTO scriere VALUES
(3, 2, 3);
INSERT INTO scriere VALUES
(4, 2, 4);
INSERT INTO scriere VALUES
(5, 3, 5);
INSERT INTO scriere VALUES
(6, 2, 5);
INSERT INTO scriere VALUES
(7, 4, 6);
INSERT INTO scriere VALUES
(8, 5, 7);
INSERT INTO scriere VALUES
(9, 5, 8);
INSERT INTO scriere VALUES
(10, 6, 9);
INSERT INTO scriere VALUES
(11, 7, 9);
INSERT INTO scriere VALUES
(12, 6, 10);
INSERT INTO scriere VALUES
(13, 6, 11);
INSERT INTO scriere VALUES
(14, 7, 12);
INSERT INTO scriere VALUES
(15, 7, 13);
INSERT INTO scriere VALUES
(16, 6, 13);

INSERT INTO imprumut VALUES
(1, to_date('02-12-2021','dd-mm-yyyy'), to_date('13-12-2021','dd-mm-yyyy'), 1, 1);
INSERT INTO imprumut VALUES
(2, to_date('05-12-2021','dd-mm-yyyy'), to_date('02-01-2022','dd-mm-yyyy'), 2, 1);
INSERT INTO imprumut VALUES
(3, to_date('30-11-2021','dd-mm-yyyy'), to_date('03-12-2021','dd-mm-yyyy'), 3, 2);
INSERT INTO imprumut VALUES
(4, to_date('07-12-2021','dd-mm-yyyy'), to_date('07-12-2021','dd-mm-yyyy'), 15, 3);
INSERT INTO imprumut VALUES
(5, to_date('02-12-2021','dd-mm-yyyy'), to_date('07-12-2021','dd-mm-yyyy'), 12, 4);
INSERT INTO imprumut VALUES
(6, to_date('25-11-2021','dd-mm-yyyy'), to_date('28-11-2021','dd-mm-yyyy'), 10, 4);
INSERT INTO imprumut VALUES
(7, to_date('02-12-2021','dd-mm-yyyy'), to_date('02-12-2021','dd-mm-yyyy'), 8, 5);
INSERT INTO imprumut VALUES
(8, to_date('04-01-2022','dd-mm-yyyy'), to_date('07-01-2022','dd-mm-yyyy'), 4, 1);
INSERT INTO imprumut VALUES
(9, to_date('11-12-2021','dd-mm-yyyy'), to_date('13-12-2021','dd-mm-yyyy'), 9, 6);
INSERT INTO imprumut VALUES
(10, to_date('14-12-2021','dd-mm-yyyy'), to_date('18-12-2021','dd-mm-yyyy'), 6, 7);
INSERT INTO imprumut VALUES
(11, to_date('21-11-2021','dd-mm-yyyy'), to_date('21-12-2021','dd-mm-yyyy'), 21, 2);

----------------------------------------------------------------------------------
--Ex. 6: Afisati, pentru fiecare tip de abonament existent, cititorii care il 
--detin si numarul de imprumuturi efectuate de fiecare.

CREATE OR REPLACE PROCEDURE ex6 IS
    TYPE tab_imb_id_abon IS TABLE OF abonament.id_abonament%TYPE;
    t_id_abon tab_imb_id_abon := tab_imb_id_abon();
    
    TYPE tab_imb_det_abon IS TABLE OF abonament.detalii%TYPE;
    t_det_abon tab_imb_det_abon := tab_imb_det_abon();
    
    TYPE cit_record IS RECORD
        (id cititor.id_cititor%TYPE,
        prenume cititor.prenume%TYPE,
        nume cititor.nume%TYPE,
        abon cititor.tip_abonament%TYPE);
        
    TYPE tab_cititori IS TABLE OF cit_record INDEX BY BINARY_INTEGER;
    t_cit tab_cititori;
    
    i INTEGER;
    cnt INTEGER;
    j INTEGER;
    nr_imprumuturi INTEGER;
BEGIN
    SELECT id_abonament
    BULK COLLECT INTO t_id_abon
    FROM abonament
    ORDER BY id_abonament;
    
    SELECT detalii
    BULK COLLECT INTO t_det_abon
    FROM abonament
    ORDER BY id_abonament;
    
    i := t_id_abon.FIRST;
    j := t_det_abon.FIRST;
    
    WHILE i <= t_id_abon.LAST LOOP
        DBMS_OUTPUT.PUT_LINE('Abonamentul cu id-ul '||t_id_abon(i)||' ('||t_det_abon(j)||')');
        
        SELECT id_cititor, prenume, nume, tip_abonament
        BULK COLLECT INTO t_cit
        FROM cititor
        WHERE tip_abonament = t_id_abon(i);
        
        IF t_cit.COUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('    '||'Niciun cititor nu are acest tip de abonament!');
            DBMS_OUTPUT.NEW_LINE;
        ELSE
            IF t_cit.COUNT > 1 THEN
                DBMS_OUTPUT.PUT_LINE('    '||'Cititorii care au acest tip de abonament:');
                DBMS_OUTPUT.NEW_LINE;
            ELSE
                DBMS_OUTPUT.PUT_LINE('    '||'Cititorul care are acest tip de abonament:');
                DBMS_OUTPUT.NEW_LINE;
            END IF;
            cnt := 0;
            FOR k IN t_cit.FIRST..t_cit.LAST LOOP
                cnt := cnt+1;
                DBMS_OUTPUT.PUT('        '||cnt||'. '||t_cit(k).prenume||' '||t_cit(k).nume);
                
                SELECT COUNT(*)
                INTO nr_imprumuturi
                FROM IMPRUMUT
                WHERE id_cititor = t_cit(k).id;
                
                DBMS_OUTPUT.PUT_LINE(' | numar de imprumuturi: '||nr_imprumuturi);
            END LOOP;
        END IF;
        
        i:=i+1;
        j:=j+1;
        DBMS_OUTPUT.NEW_LINE;
        DBMS_OUTPUT.NEW_LINE;
    END LOOP;
    
END ex6;

BEGIN
    ex6;
END;

----------------------------------------------------------------------------------
--Ex. 7: Afisati, pentru fiecare carte publicata dupa anul 2000,
--autorii acestora si cati ani aveau la momentul publicarii acesteia.

CREATE OR REPLACE PROCEDURE ex7 IS
    
    TYPE tab_imb_id_aut IS TABLE OF autor.id_autor%TYPE;
    t_id_aut tab_imb_id_aut := tab_imb_id_aut();
    
    v_id_carte carte.id_carte%TYPE;
    v_titlu carte.titlu%TYPE;
    v_an carte.an_aparitie%TYPE;
    v_prenume autor.prenume%TYPE;
    v_nume autor.nume%TYPE;
    v_ani NUMBER;
    
    CURSOR c IS
        SELECT id_carte, titlu, an_aparitie
        FROM carte
        WHERE an_aparitie >= 2000;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Carti publicate dupa anul 2000');
    DBMS_OUTPUT.NEW_LINE;
    OPEN c;
    LOOP
        FETCH c INTO v_id_carte, v_titlu, v_an;
        EXIT WHEN c%NOTFOUND;
        
        SELECT id_autor
        BULK COLLECT INTO t_id_aut
        FROM scriere
        WHERE id_carte = v_id_carte;
        
        DBMS_OUTPUT.PUT_LINE(v_titlu||' ('||v_an||') - scrisa de:');
        
        FOR i IN t_id_aut.FIRST..t_id_aut.LAST LOOP
            
            SELECT prenume, nume, (v_an - EXTRACT (YEAR FROM data_nasterii))
            INTO v_prenume, v_nume, v_ani
            FROM autor
            WHERE id_autor = t_id_aut(i);
            
            DBMS_OUTPUT.PUT_LINE('     '||v_prenume||' '||v_nume||' ('||v_ani||' ani)');
            
        END LOOP;
        
        DBMS_OUTPUT.NEW_LINE;
        DBMS_OUTPUT.NEW_LINE;

    END LOOP;
    CLOSE c;
END ex7;

BEGIN
    ex7;
END;

----------------------------------------------------------------------------------
--Ex. 8: Afisati, folosind o functie stocata, numarul de exemplare care
--trebuie inlocuite (sunt deteriorate) ale cartilor scrise de un autor
--al carui nume este dat ca parametru.

--Pentru a exemplifica tratarea exceptiilor, am mai inserat
--urmatoarea linie in tabelul AUTOR

INSERT INTO autor VALUES
(8, 'John', 'King', to_date('26-10-1956', 'dd-mm-yyyy'));

CREATE OR REPLACE FUNCTION ex8 (nume_aut autor.nume%TYPE) RETURN NUMBER IS
    id_aut autor.id_autor%TYPE;
    numar NUMBER;
BEGIN
    
    SELECT id_autor
    INTO id_aut
    FROM autor
    WHERE UPPER(nume) = UPPER(nume_aut);

    SELECT COUNT(conditie)
    INTO numar
    FROM exemplar e, carte c, scriere s
    WHERE c.id_carte = s.id_carte AND c.id_carte = e.id_carte 
        AND s.id_autor = id_aut  AND
        UPPER(conditie) = 'DETERIORATA';
    
    RETURN numar;
    
    EXCEPTION
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('Au fost gasiti mai multi autori cu numele introdus!');
            RETURN -1;
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Nu a fost gasit autorul cu numele dat!');
            RETURN -1;
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('A aparut o eroare!');
            RETURN -1;
END ex8;

DECLARE
    nume_aut autor.nume%TYPE := '&nume';
BEGIN
    DBMS_OUTPUT.PUT_LINE('Numarul de exemplare ale cartilor scrise de '||UPPER(nume_aut)||' care trebuie inlocuite: '||ex8(nume_aut));
END;
--am introdus de la tastatura numele Tolkien (functionare corecta)
--am introdus de la tastatura numele King (se intra pe exceptia TOO_MANY_ROWS)
--am introdus de la tastatura numele Popescu (se intra pe exceptia NO_DATA_FOUND)

----------------------------------------------------------------------------------
--Ex. 9: Afisati, folosind o procedura stocata, pentru cititorii care au
--imorumutat carti scrise doar de un autor, cartile imprumutate, precum
--si categoria din care face parte fiecare.

--Pentru a exemplifica tratarea exceptiilor, am mai inserat
--urmatoarele linii in tabelul CITITOR, respectiv IMPRUMUT

INSERT INTO cititor VALUES
(8, 'Andrei', 'Popescu', '0752421243', 'andrei2001.p@hotmail.com', 1);

INSERT INTO cititor VALUES
(9, 'Cosmin', 'Stefan', '0752433122', 'cosminstefann@gmail.com', 2);

INSERT INTO imprumut VALUES
(12, to_date('14-12-2021','dd-mm-yyyy'), to_date('18-12-2021','dd-mm-yyyy'), 6, 8);

CREATE OR REPLACE PROCEDURE ex9 (nume_cit cititor.nume%TYPE) IS
    TYPE tab_imb_id_aut IS TABLE OF autor.id_autor%TYPE;
    TYPE carte_categ IS RECORD
        (id carte.id_carte%TYPE,
        titlu carte.titlu%TYPE,
        categ categorie.nume%TYPE,
        id_aut autor.id_autor %TYPE);
    TYPE tab_carti IS TABLE OF carte_categ;
    t_carti tab_carti := tab_carti();
    id_cit cititor.id_cititor%TYPE;
    id_aut autor.id_autor%TYPE;
    exc1 exception;
    nume_aut autor.nume%TYPE;
    prenume_aut autor.prenume%TYPE;
BEGIN
    SELECT id_cititor
    INTO id_cit
    FROM cititor
    WHERE nume = nume_cit;
    
    SELECT DISTINCT(c.id_carte), c.titlu, cat.nume, a.id_autor
    BULK COLLECT INTO t_carti
    FROM categorie cat, carte c, exemplar e, imprumut i, scriere s, autor a
    WHERE cat.id_categorie = c.id_categorie AND
            c.id_carte = e.id_carte AND e.id_exemplar = i.id_exemplar AND
            c.id_carte = s.id_carte AND s.id_autor = a.id_autor AND
            c.id_carte IN (SELECT MAX(id_carte) 
                            FROM scriere
                            GROUP BY id_carte
                            HAVING COUNT(id_carte) = 1) AND
            i.id_cititor = id_cit;
    
    IF t_carti.COUNT = 0 THEN
        RAISE exc1;
    END IF;
    DBMS_OUTPUT.PUT_LINE('Cititorul cu numele de '||nume_cit||' a imprumutat:');
    FOR i IN t_carti.FIRST..t_carti.LAST LOOP
        DBMS_OUTPUT.PUT('   '||t_carti(i).titlu||' ('||t_carti(i).categ||') - scrisa de:');
        SELECT nume, prenume
        INTO nume_aut, prenume_aut
        FROM autor
        WHERE id_autor = t_carti(i).id_aut;
        DBMS_OUTPUT.PUT_LINE(' '||prenume_aut||' '||nume_aut);
    END LOOP;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20000, 'Nu a fost gasit cititorul cu numele '||nume_cit||'!');
        WHEN TOO_MANY_ROWS THEN
            RAISE_APPLICATION_ERROR(-20001, 'Au fost gasiti mai multi cititori cu numele '||nume_cit||'!');
        WHEN exc1 THEN
            RAISE_APPLICATION_ERROR(-20002, 'Cititorul cu numele '||nume_cit||' nu a imprumutat nicio carte!');
END ex9;

BEGIN --functioneaza
    ex9('Malancu');
END;

BEGIN --intra pe exceptia de TOO_MANY_ROWS
    ex9('Popescu');
END;

BEGIN --intra pe exceptia predefinita pentru cazul in care utilizatorul
    ex9('Stefan'); --nu a imprumutat nicio carte
END;

BEGIN --intra pe exceptia de NO_DATA_FOUND
    ex9('John'); 
END;

----------------------------------------------------------------------------------
--Ex. 10: Trigger LMD la nivel de comanda
CREATE OR REPLACE TRIGGER trig_ex10
    BEFORE INSERT OR DELETE OR UPDATE ON imprumut
BEGIN
    IF (TO_CHAR(SYSDATE,'D') = 1) OR (TO_CHAR(SYSDATE,'D') = 7)
    OR (TO_CHAR(SYSDATE,'HH24') NOT BETWEEN 8 AND 16)
    THEN
        IF INSERTING THEN
            RAISE_APPLICATION_ERROR(-20001,'Inserarea in tabelul IMPRUMUT
            este permisa doar in timpul programului de lucru!');
        ELSIF DELETING THEN
            RAISE_APPLICATION_ERROR(-20002,'Stergerea din tabelul IMPRUMUT
            este permisa doar in timpul programului de lucru!');
        ELSE
            RAISE_APPLICATION_ERROR(-20003,'Actualizarea in tabelul IMPRUMUT
            este permisa doar in timpul programului de lucru!');
        END IF;
    END IF;
END;

----------------------------------------------------------------------------------
--Ex. 11: Trigger LMD la nivel de linie
CREATE OR REPLACE PROCEDURE proc_trig_ex11
IS
BEGIN
    RAISE_APPLICATION_ERROR (-20000, 'Nu puteti modifica descriere abonamentelor!');
END;

CREATE OR REPLACE TRIGGER trig_ex11
BEFORE UPDATE OF detalii ON abonament
FOR EACH ROW
WHEN (NEW.detalii <> OLD.detalii)
BEGIN
    proc_trig_ex11;
END;

----------------------------------------------------------------------------------
--Ex. 12: Trigger LDD
CREATE OR REPLACE TRIGGER trig_ex12
 AFTER CREATE OR DROP OR ALTER ON DATABASE
BEGIN
    DBMS_OUTPUT.PUT_LINE('Baza de date: '||SYS.DATABASE_NAME);
    DBMS_OUTPUT.PUT_LINE('User: '||SYS.LOGIN_USER);
    DBMS_OUTPUT.PUT_LINE('Eveniment: '||SYS.SYSEVENT);
    DBMS_OUTPUT.PUT_LINE('Tip obiect referit: '||SYS.DICTIONARY_OBJ_TYPE);
    DBMS_OUTPUT.PUT_LINE('Nume obiect referit: '||SYS.DICTIONARY_OBJ_NAME);
    DBMS_OUTPUT.PUT_LINE('Data: '||SYSTIMESTAMP);
END;
/

----------------------------------------------------------------------------------
--Ex. 13: Pachet care contine toate obiectele definite
CREATE OR REPLACE PACKAGE proiect AS

    PROCEDURE ex6;
    
    PROCEDURE ex7;
    
    FUNCTION ex8 (nume_aut autor.nume%TYPE) RETURN NUMBER;
    
    PROCEDURE ex9 (nume_cit cititor.nume%TYPE);
    
END proiect;


CREATE OR REPLACE PACKAGE BODY proiect AS

    PROCEDURE ex6 IS
        TYPE tab_imb_id_abon IS TABLE OF abonament.id_abonament%TYPE;
        t_id_abon tab_imb_id_abon := tab_imb_id_abon();
        
        TYPE tab_imb_det_abon IS TABLE OF abonament.detalii%TYPE;
        t_det_abon tab_imb_det_abon := tab_imb_det_abon();
        
        TYPE cit_record IS RECORD
            (id cititor.id_cititor%TYPE,
            prenume cititor.prenume%TYPE,
            nume cititor.nume%TYPE,
            abon cititor.tip_abonament%TYPE);
            
        TYPE tab_cititori IS TABLE OF cit_record INDEX BY BINARY_INTEGER;
        t_cit tab_cititori;
        
        i INTEGER;
        cnt INTEGER;
        j INTEGER;
        nr_imprumuturi INTEGER;
    BEGIN
        SELECT id_abonament
        BULK COLLECT INTO t_id_abon
        FROM abonament
        ORDER BY id_abonament;
        
        SELECT detalii
        BULK COLLECT INTO t_det_abon
        FROM abonament
        ORDER BY id_abonament;
        
        i := t_id_abon.FIRST;
        j := t_det_abon.FIRST;
        
        WHILE i <= t_id_abon.LAST LOOP
            DBMS_OUTPUT.PUT_LINE('Abonamentul cu id-ul '||t_id_abon(i)||' ('||t_det_abon(j)||')');
            
            SELECT id_cititor, prenume, nume, tip_abonament
            BULK COLLECT INTO t_cit
            FROM cititor
            WHERE tip_abonament = t_id_abon(i);
            
            IF t_cit.COUNT = 0 THEN
                DBMS_OUTPUT.PUT_LINE('    '||'Niciun cititor nu are acest tip de abonament!');
                DBMS_OUTPUT.NEW_LINE;
            ELSE
                IF t_cit.COUNT > 1 THEN
                    DBMS_OUTPUT.PUT_LINE('    '||'Cititorii care au acest tip de abonament:');
                    DBMS_OUTPUT.NEW_LINE;
                ELSE
                    DBMS_OUTPUT.PUT_LINE('    '||'Cititorul care are acest tip de abonament:');
                    DBMS_OUTPUT.NEW_LINE;
                END IF;
                cnt := 0;
                FOR k IN t_cit.FIRST..t_cit.LAST LOOP
                    cnt := cnt+1;
                    DBMS_OUTPUT.PUT('        '||cnt||'. '||t_cit(k).prenume||' '||t_cit(k).nume);
                    
                    SELECT COUNT(*)
                    INTO nr_imprumuturi
                    FROM IMPRUMUT
                    WHERE id_cititor = t_cit(k).id;
                    
                    DBMS_OUTPUT.PUT_LINE(' | numar de imprumuturi: '||nr_imprumuturi);
                END LOOP;
            END IF;
            
            i:=i+1;
            j:=j+1;
            DBMS_OUTPUT.NEW_LINE;
            DBMS_OUTPUT.NEW_LINE;
        END LOOP;
        
    END ex6;


    PROCEDURE ex7 IS
    
        TYPE tab_imb_id_aut IS TABLE OF autor.id_autor%TYPE;
        t_id_aut tab_imb_id_aut := tab_imb_id_aut();
        
        v_id_carte carte.id_carte%TYPE;
        v_titlu carte.titlu%TYPE;
        v_an carte.an_aparitie%TYPE;
        v_prenume autor.prenume%TYPE;
        v_nume autor.nume%TYPE;
        v_ani NUMBER;
        
        CURSOR c IS
            SELECT id_carte, titlu, an_aparitie
            FROM carte
            WHERE an_aparitie >= 2000;

    BEGIN
        DBMS_OUTPUT.PUT_LINE('Carti publicate dupa anul 2000');
        DBMS_OUTPUT.NEW_LINE;
        OPEN c;
        LOOP
            FETCH c INTO v_id_carte, v_titlu, v_an;
            EXIT WHEN c%NOTFOUND;
            
            SELECT id_autor
            BULK COLLECT INTO t_id_aut
            FROM scriere
            WHERE id_carte = v_id_carte;
            
            DBMS_OUTPUT.PUT_LINE(v_titlu||' ('||v_an||') - scrisa de:');
            
            FOR i IN t_id_aut.FIRST..t_id_aut.LAST LOOP
                
                SELECT prenume, nume, (v_an - EXTRACT (YEAR FROM data_nasterii))
                INTO v_prenume, v_nume, v_ani
                FROM autor
                WHERE id_autor = t_id_aut(i);
                
                DBMS_OUTPUT.PUT_LINE('     '||v_prenume||' '||v_nume||' ('||v_ani||' ani)');
                
            END LOOP;
            
            DBMS_OUTPUT.NEW_LINE;
            DBMS_OUTPUT.NEW_LINE;
    
        END LOOP;
        CLOSE c;
    END ex7;


    FUNCTION ex8 (nume_aut autor.nume%TYPE) RETURN NUMBER IS
        id_aut autor.id_autor%TYPE;
        numar NUMBER;
    BEGIN
        
        SELECT id_autor
        INTO id_aut
        FROM autor
        WHERE UPPER(nume) = UPPER(nume_aut);
    
        SELECT COUNT(conditie)
        INTO numar
        FROM exemplar e, carte c, scriere s
        WHERE c.id_carte = s.id_carte AND c.id_carte = e.id_carte 
            AND s.id_autor = id_aut  AND
            UPPER(conditie) = 'DETERIORATA';
        
        RETURN numar;
        
        EXCEPTION
            WHEN TOO_MANY_ROWS THEN
                DBMS_OUTPUT.PUT_LINE('Au fost gasiti mai multi autori cu numele introdus!');
                RETURN -1;
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('Nu a fost gasit autorul cu numele dat!');
                RETURN -1;
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('A aparut o eroare!');
                RETURN -1;
    END ex8;
    

    PROCEDURE ex9 (nume_cit cititor.nume%TYPE) IS
        TYPE tab_imb_id_aut IS TABLE OF autor.id_autor%TYPE;
        TYPE carte_categ IS RECORD
            (id carte.id_carte%TYPE,
            titlu carte.titlu%TYPE,
            categ categorie.nume%TYPE,
            id_aut autor.id_autor %TYPE);
        TYPE tab_carti IS TABLE OF carte_categ;
        t_carti tab_carti := tab_carti();
        id_cit cititor.id_cititor%TYPE;
        id_aut autor.id_autor%TYPE;
        exc1 exception;
        nume_aut autor.nume%TYPE;
        prenume_aut autor.prenume%TYPE;
    BEGIN
        SELECT id_cititor
        INTO id_cit
        FROM cititor
        WHERE nume = nume_cit;
        
        SELECT DISTINCT(c.id_carte), c.titlu, cat.nume, a.id_autor
        BULK COLLECT INTO t_carti
        FROM categorie cat, carte c, exemplar e, imprumut i, scriere s, autor a
        WHERE cat.id_categorie = c.id_categorie AND
                c.id_carte = e.id_carte AND e.id_exemplar = i.id_exemplar AND
                c.id_carte = s.id_carte AND s.id_autor = a.id_autor AND
                c.id_carte IN (SELECT MAX(id_carte) 
                                FROM scriere
                                GROUP BY id_carte
                                HAVING COUNT(id_carte) = 1) AND
                i.id_cititor = id_cit;
        
        IF t_carti.COUNT = 0 THEN
            RAISE exc1;
        END IF;
        DBMS_OUTPUT.PUT_LINE('Cititorul cu numele de '||nume_cit||' a imprumutat:');
        FOR i IN t_carti.FIRST..t_carti.LAST LOOP
            DBMS_OUTPUT.PUT('   '||t_carti(i).titlu||' ('||t_carti(i).categ||') - scrisa de:');
            SELECT nume, prenume
            INTO nume_aut, prenume_aut
            FROM autor
            WHERE id_autor = t_carti(i).id_aut;
            DBMS_OUTPUT.PUT_LINE(' '||prenume_aut||' '||nume_aut);
        END LOOP;
    
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20000, 'Nu a fost gasit cititorul cu numele '||nume_cit||'!');
            WHEN TOO_MANY_ROWS THEN
                RAISE_APPLICATION_ERROR(-20001, 'Au fost gasiti mai multi cititori cu numele '||nume_cit||'!');
            WHEN exc1 THEN
                RAISE_APPLICATION_ERROR(-20002, 'Cititorul cu numele '||nume_cit||' nu a imprumutat nicio carte!');
    
    END ex9;

END proiect;

BEGIN
    proiect.ex6;
    proiect.ex7;
    DBMS_OUTPUT.PUT_LINE('Numarul de exemplare ale cartilor scrise de Tolkien care trebuie inlocuite: '||proiect.ex8('Tolkien'));
    proiect.ex9('Malancu');
END;

