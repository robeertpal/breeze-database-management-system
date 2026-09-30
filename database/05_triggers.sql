-- Reguli de integritate, validare bilete, audit, incarcare bratari si control DDL.
-- Se ruleaza ULTIMUL la instalare. t_control ramane ultimul trigger creat.

SET DEFINE OFF
SET SQLBLANKLINES ON
SET SERVEROUTPUT ON
WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK

-- t_program_artist
CREATE OR REPLACE TRIGGER t_program_artist
AFTER INSERT ON PROGRAM
DECLARE
    p_cod_contribuitor CONTRIBUITOR.cod_contribuitor%TYPE;
    p_nume_artist VARCHAR2(50);
BEGIN
    SELECT p.cod_contribuitor
    INTO p_cod_contribuitor
    FROM PROGRAM p
    JOIN CONTRIBUITOR c ON c.cod_contribuitor = p.cod_contribuitor
    WHERE c.tip_contribuitor = 'artist'
    GROUP BY p.cod_contribuitor
    HAVING COUNT(*) > 1
    FETCH FIRST 1 ROW ONLY;

    SELECT NVL(nume_de_scena, nume || ' ' || prenume)
    INTO p_nume_artist
    FROM ARTIST
    WHERE cod_contribuitor = p_cod_contribuitor;

    RAISE_APPLICATION_ERROR(-20401, 'Artistul ' || p_nume_artist || ' poate sustine o singura reprezentatie in cadrul festivalului.');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        NULL;
END;
/

-- t_blocare_update
CREATE OR REPLACE TRIGGER t_blocare_update
BEFORE UPDATE OF cod_contribuitor ON PROGRAM
BEGIN
    RAISE_APPLICATION_ERROR(-20402, 'Modificarea artistului asociat unui program nu este permisa.');
END;
/

-- t_program_fara_suprapunere
CREATE OR REPLACE TRIGGER t_program_fara_suprapunere
AFTER INSERT ON PROGRAM
DECLARE
    p_cod_scena PROGRAM.cod_scena%TYPE;
BEGIN
    SELECT p1.cod_scena
    INTO p_cod_scena
    FROM PROGRAM p1
    JOIN PROGRAM p2 ON p1.cod_scena = p2.cod_scena
        AND p1.cod_eveniment <> p2.cod_eveniment
        AND p1.inceput < p2.sfarsit
        AND p1.sfarsit > p2.inceput
    FETCH FIRST 1 ROW ONLY;

    RAISE_APPLICATION_ERROR(-20403, 'Nu este permisa suprapunerea evenimentelor pe aceeasi scena.');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        NULL;
END;
/

-- t_bilet_validat_insert
CREATE OR REPLACE TRIGGER t_bilet_validat_insert
BEFORE INSERT ON BILET
FOR EACH ROW
DECLARE
    v_tip_personal PERSONAL.tip_personal%TYPE;
BEGIN
    IF :NEW.verificat = 'A' THEN

        IF :NEW.cod_personal IS NULL THEN
            RAISE_APPLICATION_ERROR(-20404, 'Validarea biletului se face exclusiv de catre un agent autorizat.');
        END IF;

        SELECT tip_personal
        INTO v_tip_personal
        FROM PERSONAL
        WHERE cod_personal = :NEW.cod_personal;

        IF v_tip_personal <> 'agent' THEN
            RAISE_APPLICATION_ERROR(-20405, 'Doar personalul cu rol de agent poate valida bilete.');
        END IF;
    END IF;
END;
/

-- t_bilet_validare_update
CREATE OR REPLACE TRIGGER t_bilet_validare_update
BEFORE UPDATE OF verificat ON BILET
FOR EACH ROW
DECLARE
    v_tip_personal PERSONAL.tip_personal%TYPE;
BEGIN
    IF :OLD.verificat = 'A' AND :NEW.verificat = 'F' THEN
        RAISE_APPLICATION_ERROR(-20406, 'Un bilet validat nu poate reveni la starea nevalidata.');
    END IF;

    IF :OLD.verificat = 'F' AND :NEW.verificat = 'A' THEN

        IF :NEW.cod_personal IS NULL THEN
            RAISE_APPLICATION_ERROR(-20407, 'Validarea biletului se face exclusiv de catre un agent autorizat.');
        END IF;

        SELECT tip_personal
        INTO v_tip_personal
        FROM PERSONAL
        WHERE cod_personal = :NEW.cod_personal;

        IF v_tip_personal <> 'agent' THEN
            RAISE_APPLICATION_ERROR(-20408, 'Doar personalul cu rol de agent poate valida bilete.');
        END IF;
    END IF;
END;
/

-- t_blocare_update_participant
CREATE OR REPLACE TRIGGER t_blocare_update_participant
BEFORE UPDATE OF nume, prenume, mail, numar_telefon ON PARTICIPANT
DECLARE
    p_motiv VARCHAR2(200);
BEGIN
    p_motiv := 'A incercat modificarea datelor de identificare pentru un participant.';
    p_suspiciune(p_motiv);
        
    RAISE_APPLICATION_ERROR(-20011, 'Datele de identificare ale participantilor nu pot fi modificate.');
END;
/

-- t_blocare_update_bilet
CREATE OR REPLACE TRIGGER t_blocare_update_bilet
BEFORE UPDATE OF cod_participant ON BILET
DECLARE
    p_motiv VARCHAR2(200);
BEGIN
    p_motiv := 'A incercat modificarea biletului unui participant.';
    p_suspiciune(p_motiv);
        
    RAISE_APPLICATION_ERROR(-20012, 'Biletele sunt netransferabile.');
END;
/

-- t_incarcare_bratara
CREATE OR REPLACE TRIGGER t_incarcare_bratara
AFTER INSERT ON INCARCA
FOR EACH ROW
DECLARE
    v_tip_personal PERSONAL.tip_personal%TYPE;
    v_cod_departament JOB.cod_departament%TYPE;
    e_nepermis EXCEPTION;
BEGIN
    SELECT tip_personal
    INTO v_tip_personal
    FROM PERSONAL
    WHERE cod_personal = :NEW.cod_personal;

    IF v_tip_personal = 'agent' THEN
        SELECT j.cod_departament
        INTO v_cod_departament
        FROM AGENT a
        JOIN JOB j ON j.cod_job = a.cod_job
        WHERE a.cod_personal = :NEW.cod_personal;

        IF v_cod_departament <> 40 THEN
            RAISE e_nepermis;
        END IF;

    ELSIF v_tip_personal <> 'manager' THEN
        RAISE e_nepermis;
    END IF;

    UPDATE BRATARA
    SET sold_bratara = sold_bratara + :NEW.suma
    WHERE cod_bratara = :NEW.cod_bratara;
    
EXCEPTION
    WHEN e_nepermis THEN
        RAISE_APPLICATION_ERROR(-20111, 'Incarcarea bratarilor poate fi efectuata exclusiv de agenti din departamentul Bratari sau de manageri.');
END;
/

-- t_control
CREATE OR REPLACE TRIGGER t_control
BEFORE CREATE OR ALTER OR DROP ON SCHEMA
BEGIN
    IF NOT pkg_mentenanta.mentenanta_activa THEN
        RAISE_APPLICATION_ERROR(-20900, 'Operatiile DDL sunt permise doar in intervalul de mentenanta. Activati mentenanta prin pkg_mentenanta.incepe[(observatii)] pentru a putea efectua modificari.');
    END IF;
END;
/
