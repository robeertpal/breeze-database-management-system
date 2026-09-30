-- Scenarii demonstrative originale, inclusiv cazuri negative cu erori asteptate.
-- Rulati pe o schema de test, selectiv. Exista COMMIT, DDL si audit autonom; ROLLBACK nu anuleaza tot.

SET DEFINE OFF
SET SQLBLANKLINES ON
SET SERVEROUTPUT ON
WHENEVER SQLERROR CONTINUE

PROMPT Obiecte invalide si erori de compilare (asteptat: zero randuri)
SELECT object_name, object_type, status FROM user_objects WHERE status = 'INVALID';
SELECT name, type, line, position, text FROM user_errors ORDER BY name, sequence;

PROMPT Scenarii manuale: verificati mesajele si efectele fiecarui caz
INSERT INTO PROGRAM
VALUES (seq_cod_eveniment.NEXTVAL, 60, 10, TO_DATE('2026-04-26 18:00','YYYY-MM-DD HH24:MI'), TO_DATE('2026-04-26 19:00','YYYY-MM-DD HH24:MI'));

UPDATE PROGRAM
SET cod_contribuitor = 20
WHERE cod_eveniment = 10;

INSERT INTO PROGRAM
VALUES (seq_cod_eveniment.NEXTVAL, 110, 10, TO_DATE('2025-04-24 18:30','YYYY-MM-DD HH24:MI'), TO_DATE('2025-04-24 19:15','YYYY-MM-DD HH24:MI'));

INSERT INTO BILET
VALUES (999, 'Acces General', 'A', 1000, NULL);

INSERT INTO BILET
VALUES (998, 'Acces General', 'A', 1001, 103);

UPDATE BILET SET verificat = 'F'
WHERE cod_bilet = 100;

UPDATE BILET
SET verificat = 'A', cod_personal = NULL
WHERE cod_bilet = 106;

UPDATE BILET
SET verificat = 'A', cod_personal = 103
WHERE cod_bilet = 106;

/*
    Zona VIP invalida.
*/

DECLARE
    p_cod_bratara BRATARA.cod_bratara%TYPE;
BEGIN
    SELECT cod_bratara
    INTO p_cod_bratara
    FROM BRATARA
    WHERE ROWNUM = 1;

    acces_VIP.resetare;
    acces_VIP.acces(p_cod_bratara, 'REVER', 'ACCES');
END;
/

/*
    Operatie invalida.
*/

DECLARE
    p_cod_bratara BRATARA.cod_bratara%TYPE;
BEGIN
    SELECT cod_bratara
    INTO p_cod_bratara
    FROM BRATARA
    WHERE ROWNUM = 1;

    acces_VIP.resetare;
    acces_VIP.acces(p_cod_bratara, 'REVERB', 'ACES');
END;
/

/*
    Bratara inexistenta.
*/

BEGIN
    acces_VIP.resetare;
    acces_VIP.acces(2, 'REVERB', 'ACCES');
END;
/

/*
    Biletul nu este VIP.
*/

DECLARE
    p_cod_bratara BRATARA.cod_bratara%TYPE;
BEGIN
    SELECT br.cod_bratara
    INTO p_cod_bratara
    FROM BRATARA br
    JOIN BILET b ON br.cod_bilet = b.cod_bilet
    WHERE tip_bilet NOT IN ('VIP General', 'VIP Ultra') AND ROWNUM = 1;

    acces_VIP.resetare;
    acces_VIP.acces(p_cod_bratara, 'REVERB', 'ACCES');
END;
/

/*
    Biletul VIP este neverificat.
*/

DECLARE
    p_cod_bratara BRATARA.cod_bratara%TYPE;
BEGIN
    SELECT br.cod_bratara
    INTO p_cod_bratara
    FROM BRATARA br
    JOIN BILET b ON br.cod_bilet = b.cod_bilet
    WHERE b.tip_bilet IN ('VIP General', 'VIP Ultra')
        AND verificat = 'F'
        AND ROWNUM = 1;

    acces_VIP.resetare;
    acces_VIP.acces(p_cod_bratara, 'REVERB', 'ACCES');
END;
/

/*
    Participantul este sub 18 ani.
*/

INSERT INTO PARTICIPANT
VALUES(100, 'Moldovan', 'Sebastian', DATE '2010-09-29', 1032, '+40 729 138 180', 'sebastianmoldovan@gmail.com');

INSERT INTO BILET
VALUES (10, 'VIP Ultra', 'A', 100, 132);

INSERT INTO BRATARA
VALUES (2, 0, 10);

DECLARE
    p_cod_bratara BRATARA.cod_bratara%TYPE;
BEGIN
    SELECT br.cod_bratara
    INTO p_cod_bratara
    FROM BRATARA br
    JOIN BILET b ON br.cod_bilet = b.cod_bilet
    JOIN PARTICIPANT p ON p.cod_participant = b.cod_participant
    WHERE VERIFICAT = 'A'
        AND b.tip_bilet IN ('VIP General', 'VIP Ultra')
        AND FLOOR(MONTHS_BETWEEN(SYSDATE, p.data_nasterii) / 12) < 18
        AND ROWNUM = 1;

    acces_VIP.resetare;
    acces_VIP.acces(p_cod_bratara, 'REVERB', 'ACCES');
END;
/

DELETE FROM BRATARA
WHERE cod_bratara = 2;

DELETE FROM BILET
WHERE cod_bilet = 10;

DELETE FROM PARTICIPANT
WHERE cod_participant = 100;

COMMIT;

/*
    Participantul este deja in zona VIP.
*/

DECLARE
    p_cod_bratara BRATARA.cod_bratara%TYPE;
BEGIN
    SELECT br.cod_bratara
    INTO p_cod_bratara
    FROM BRATARA br
    JOIN BILET b ON br.cod_bilet = b.cod_bilet
    JOIN PARTICIPANT p ON p.cod_participant = b.cod_participant
    WHERE VERIFICAT = 'A'
        AND b.tip_bilet IN ('VIP General', 'VIP Ultra')
        AND FLOOR(MONTHS_BETWEEN(SYSDATE, p.data_nasterii) / 12) >= 18
        AND ROWNUM = 1;

    acces_VIP.resetare;
    acces_VIP.acces(p_cod_bratara, 'REVERB', 'ACCES');
    acces_VIP.acces(p_cod_bratara, 'CULISE_VIP', 'ACCES');
END;
/

/*
    Zona VIP este la capacitate maxima.
*/

BEGIN
    acces_VIP.resetare;

    FOR i IN (SELECT br.cod_bratara
              FROM BRATARA br
              JOIN BILET b ON br.cod_bilet = b.cod_bilet
              JOIN PARTICIPANT p ON p.cod_participant = b.cod_participant
              WHERE VERIFICAT = 'A'
                  AND b.tip_bilet IN ('VIP General', 'VIP Ultra')
                  AND FLOOR(MONTHS_BETWEEN(SYSDATE, p.data_nasterii) / 12) >= 18
                  AND ROWNUM <= 6) LOOP

        acces_VIP.acces(i.cod_bratara, 'REVERB', 'ACCES');
    END LOOP;

    acces_VIP.raport;
END;
/

/*
    Participantul nu a fost inregistrat in nicio zona VIP.
*/

DECLARE
    p_cod_bratara BRATARA.cod_bratara%TYPE;
BEGIN
    SELECT br.cod_bratara
    INTO p_cod_bratara
    FROM BRATARA br
    JOIN BILET b ON br.cod_bilet = b.cod_bilet
    JOIN PARTICIPANT p ON p.cod_participant = b.cod_participant
    WHERE VERIFICAT = 'A'
        AND b.tip_bilet IN ('VIP General', 'VIP Ultra')
        AND FLOOR(MONTHS_BETWEEN(SYSDATE, p.data_nasterii) / 12) >= 18
        AND ROWNUM = 1;

    acces_VIP.resetare;
    acces_VIP.acces(p_cod_bratara, 'REVERB', 'IESIRE');
END;
/

/*
    Participantul nu a fost inregistrat in aceasta zona VIP.
*/

DECLARE
    p_cod_bratara BRATARA.cod_bratara%TYPE;
BEGIN
    SELECT br.cod_bratara
    INTO p_cod_bratara
    FROM BRATARA br
    JOIN BILET b ON br.cod_bilet = b.cod_bilet
    JOIN PARTICIPANT p ON p.cod_participant = b.cod_participant
    WHERE VERIFICAT = 'A'
        AND b.tip_bilet IN ('VIP General', 'VIP Ultra')
        AND FLOOR(MONTHS_BETWEEN(SYSDATE, p.data_nasterii) / 12) >= 18
        AND ROWNUM = 1;

    acces_VIP.resetare;
    acces_VIP.acces(p_cod_bratara, 'REVERB', 'ACCES');
    acces_VIP.acces(p_cod_bratara, 'CULISE_VIP', 'IESIRE');
END;
/

/*
    Acces permis.
*/

DECLARE
    p_cod_bratara BRATARA.cod_bratara%TYPE;
BEGIN
    SELECT br.cod_bratara
    INTO p_cod_bratara
    FROM BRATARA br
    JOIN BILET b ON br.cod_bilet = b.cod_bilet
    JOIN PARTICIPANT p ON p.cod_participant = b.cod_participant
    WHERE VERIFICAT = 'A'
        AND b.tip_bilet IN ('VIP General', 'VIP Ultra')
        AND FLOOR(MONTHS_BETWEEN(SYSDATE, p.data_nasterii) / 12) >= 18
        AND ROWNUM = 1;

    acces_VIP.resetare;
    acces_VIP.acces(p_cod_bratara, 'REVERB', 'ACCES');
END;
/

/*
    Iesire inregistrata.
*/

DECLARE
    p_cod_bratara BRATARA.cod_bratara%TYPE;
BEGIN
    SELECT br.cod_bratara
    INTO p_cod_bratara
    FROM BRATARA br
    JOIN BILET b ON br.cod_bilet = b.cod_bilet
    JOIN PARTICIPANT p ON p.cod_participant = b.cod_participant
    WHERE VERIFICAT = 'A'
        AND b.tip_bilet IN ('VIP General', 'VIP Ultra')
        AND FLOOR(MONTHS_BETWEEN(SYSDATE, p.data_nasterii) / 12) >= 18
        AND ROWNUM = 1;

    acces_VIP.resetare;
    acces_VIP.acces(p_cod_bratara, 'REVERB', 'ACCES');
    acces_VIP.acces(p_cod_bratara, 'REVERB', 'IESIRE');
END;
/

/*
    Reinitializarea evidența participanților VIP din zonele VIP.
*/

BEGIN
    acces_VIP.resetare;
    acces_VIP.raport;
END;
/

BEGIN
  raport_editorial_program;
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE(f_contactare_manager_departament(''));
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE(f_contactare_manager_departament('br'));
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE(f_contactare_manager_departament('e'));
END;
/

BEGIN
DBMS_OUTPUT.PUT_LINE(f_contactare_manager_departament('br'));
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE(f_contactare_manager_departament('e'));
END;
/

BEGIN
    p_verificare_disponibilitate_produs(NULL, 'cola');
END;
/

BEGIN
  p_verificare_disponibilitate_produs(1001, NULL);
END;
/

BEGIN
  p_verificare_disponibilitate_produs(10024, 'cola');
END;
/

BEGIN
  p_verificare_disponibilitate_produs(1001, 'cola ze');
END;
/

BEGIN
  p_verificare_disponibilitate_produs(1006, 'cola');
END;
/

BEGIN
  p_verificare_disponibilitate_produs(1001, 'nu_exista');
END;
/

BEGIN
  p_verificare_disponibilitate_produs(1001, 'co');
END;
/

BEGIN
  p_verificare_disponibilitate_produs(1001, 'McF');
END;
/

BEGIN
  p_verificare_disponibilitate_produs(1007, 'Cola Z');
END;
/

BEGIN
  p_verificare_disponibilitate_produs(1000, 'wi');
END;
/

UPDATE PARTICIPANT
SET nume = 'Robert'
WHERE cod_participant = 1000;

UPDATE BILET
SET cod_participant = 1001
WHERE cod_participant = 1001;

SELECT * FROM SUSPICIUNE;

INSERT INTO INCARCA (cod_bratara, cod_personal, suma)
VALUES (10, 141, 100);

SELECT *
FROM BRATARA
WHERE cod_bratara = 10;

INSERT INTO INCARCA (cod_bratara, cod_personal, suma)
VALUES (10, 132, 100);

SELECT *
FROM BRATARA
WHERE cod_bratara = 10;

SELECT *
FROM INCARCA
WHERE cod_bratara = 10;

CREATE TABLE TEST (
    id NUMBER
);

BEGIN
    pkg_mentenanta.incepe('Mentenanta pentru modificari structurale');
END;
/

CREATE TABLE TEST (
    id NUMBER
);

SELECT * FROM MENTENANTA;

BEGIN
    pkg_mentenanta.termina;
END;
/

COMMIT;

BEGIN
    pkg_mentenanta.incepe('Mentenanta pentru modificari structurale');
END;
/

BEGIN
    pkg_mentenanta.termina;
END;
/

/*
    Resetarea coșului.
*/

BEGIN
    pkg_comenzi.resetare_cos;
END;
/

/*
    Adăugarea unui produs în coș.
*/

BEGIN
    pkg_comenzi.resetare_cos;
    pkg_comenzi.adauga_produs(1, 2);
END;
/

/*
    Adăugarea aceluiași produs în coș de mai multe ori.
*/

BEGIN
    pkg_comenzi.resetare_cos;

    pkg_comenzi.adauga_produs(1, 2);
    pkg_comenzi.adauga_produs(1, 3);

    DBMS_OUTPUT.PUT_LINE('Total comanda: ' || pkg_comenzi.total_comanda);
END;
/

/*
    Ștergerea unor produse din coș.
*/

BEGIN
    pkg_comenzi.resetare_cos;

    pkg_comenzi.adauga_produs(1, 5);
    pkg_comenzi.sterge_produs(1, 2);

    DBMS_OUTPUT.PUT_LINE('Total comanda: ' || pkg_comenzi.total_comanda);
END;
/

BEGIN
    pkg_comenzi.resetare_cos;

    pkg_comenzi.adauga_produs(1, 5);
    pkg_comenzi.sterge_produs(1, 5);

    DBMS_OUTPUT.PUT_LINE('Total comanda: ' || pkg_comenzi.total_comanda);
END;
/

/*
    Adăugarea unei cantități 0 în coș.
*/

BEGIN
    pkg_comenzi.resetare_cos;
    pkg_comenzi.adauga_produs(1, 0);
END;
/

/*
    Adăugarea unui produs inexistent în coș.
*/

BEGIN
    pkg_comenzi.resetare_cos;
    pkg_comenzi.adauga_produs(2005, 1);
END;
/

/*
    Ștergerea unui produs care nu se află în coș.
*/

BEGIN
    pkg_comenzi.resetare_cos;
    pkg_comenzi.adauga_produs(1, 1);
    pkg_comenzi.sterge_produs(2, 1);
END;
/

/*
    Solicitarea totalului atunci când coșul este gol.
*/

BEGIN
    pkg_comenzi.resetare_cos;
    DBMS_OUTPUT.PUT_LINE(pkg_comenzi.total_comanda);
END;
/

/*
    Procesarea unei comenzi nule.
*/

BEGIN
    pkg_comenzi.resetare_cos;

    pkg_comenzi.proceseaza_comanda(
        cod_bratara => 1,
        cod_reprezentant => 1
    );
END;
/

/*
    Procesarea unei comenzi cu o brățară inexistentă.
*/

BEGIN
    pkg_comenzi.resetare_cos;
    pkg_comenzi.adauga_produs(1, 1);

    pkg_comenzi.proceseaza_comanda(
        cod_bratara => 2005,
        cod_reprezentant => 10
    );
END;
/

/*
    Procesarea unei comenzi cu o brățară a cărui bilet este neverificat.
*/

BEGIN
    pkg_comenzi.resetare_cos;
    pkg_comenzi.adauga_produs(1, 1);

    pkg_comenzi.proceseaza_comanda(
        cod_bratara => 22,
        cod_reprezentant => 10
    );
END;
/

/*
    Procesarea unei comenzi cu un produs indisponibil la insula reprezentantului.
*/

BEGIN
    pkg_comenzi.resetare_cos;
    pkg_comenzi.adauga_produs(9, 1);

    pkg_comenzi.proceseaza_comanda(
        cod_bratara => 15,
        cod_reprezentant => 10
    );
END;
/

/*
    Procesarea unei comenzi cu stoc insuficient pentru un produs din coș.
*/

BEGIN
    pkg_comenzi.resetare_cos;
    pkg_comenzi.adauga_produs(13, 500);

    pkg_comenzi.proceseaza_comanda(
        cod_bratara => 10,
        cod_reprezentant => 12
    );
END;
/

/*
    Procesarea unei comenzi cu o brățară cu sold insuficient.
*/

BEGIN
    pkg_comenzi.resetare_cos;
    pkg_comenzi.adauga_produs(13, 5);

    pkg_comenzi.proceseaza_comanda(
        cod_bratara => 11,
        cod_reprezentant => 12
    );
END;
/

/*
    Bon fără tranzacție.
*/

BEGIN
    pkg_comenzi.resetare_cos;

    DBMS_OUTPUT.PUT_LINE(pkg_comenzi.bon_electronic);
END;
/

/*
    Procesarea unei comenzi cu mai multe produse disponibile.
*/

BEGIN
    pkg_comenzi.resetare_cos;
    pkg_comenzi.adauga_produs(13, 1);
    pkg_comenzi.adauga_produs(14, 2);

    pkg_comenzi.proceseaza_comanda(
        cod_bratara => 10,
        cod_reprezentant => 19
    );
END;
/

/*
    Procesarea unei comenzi cu un produs care nu există la insula reprezentantului.
*/

-- Verificăm stocul produselor înainte de comandă.

SELECT a.cod_produs,
    p.nume_produs,
    a.cod_insula,
    a.cantitate_disponibila
FROM ARE_STOC a
JOIN PRODUS p ON p.cod_produs = a.cod_produs
WHERE a.cod_insula IN (190, 140) AND a.cod_produs IN (13, 14, 25);

BEGIN
    pkg_comenzi.resetare_cos;
    pkg_comenzi.adauga_produs(13, 1);
    pkg_comenzi.adauga_produs(14, 2); -- Produsule 13 și 14 sunt disponibile la insula reprezentantului 19.
    pkg_comenzi.adauga_produs(25, 2); -- Produsul 25 nu este disponibil la insula reprezentantului 19.

    pkg_comenzi.proceseaza_comanda(
        cod_bratara => 10,
        cod_reprezentant => 19
    );
END;
/

-- Verificăm stocul produselor după ce comanda a fost anulată.

SELECT a.cod_produs,
    p.nume_produs,
    a.cod_insula,
    a.cantitate_disponibila
FROM ARE_STOC a
JOIN PRODUS p ON p.cod_produs = a.cod_produs
WHERE a.cod_insula IN (190, 140) AND a.cod_produs IN (13, 14, 25);
