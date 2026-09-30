-- Proceduri independente si pachete PL/SQL complete (specificatie + corp).
-- Functiile membre raman in pachetele lor pentru a pastra starea si interfata.

SET DEFINE OFF
SET SQLBLANKLINES ON
SET SERVEROUTPUT ON
WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK

-- p_tranzactie_produs
CREATE OR REPLACE PROCEDURE p_tranzactie_produs( 
    v_cod_reprezentant IN REPREZENTANT.cod_reprezentant%TYPE,
    v_cod_produs IN PRODUS.cod_produs%TYPE,
    v_cod_bratara IN BRATARA.cod_bratara%TYPE,
    v_data_ora IN TIMESTAMP DEFAULT SYSTIMESTAMP
    )
IS
    v_cod_tranzactie NUMBER;
    v_cod_insula INSULA.cod_insula%TYPE;
    v_pret PRODUS.pret%TYPE;
BEGIN
    SELECT cod_insula
    INTO v_cod_insula
    FROM REPREZENTANT
    WHERE cod_reprezentant = v_cod_reprezentant;
    
    SELECT pret
    INTO v_pret
    FROM PRODUS
    WHERE cod_produs = v_cod_produs;
    
    UPDATE BRATARA
    SET sold_bratara = sold_bratara - v_pret
    WHERE cod_bratara = v_cod_bratara AND sold_bratara >= v_pret;
    
    IF SQL%ROWCOUNT = 0 THEN 
        RAISE_APPLICATION_ERROR(-20501, 'Sold insuficient sau bratara inexistenta.');
    END IF;
    
    UPDATE ARE_STOC
    SET cantitate_disponibila = cantitate_disponibila - 1
    WHERE cod_insula = v_cod_insula AND cod_produs = v_cod_produs AND cantitate_disponibila >= 1;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20502, 'Produs indisponibil in aceasta insula.');
    END IF;
    
    v_cod_tranzactie := seq_cod_tranzactie.NEXTVAL;
    
    INSERT INTO TRANZACTIE
    VALUES (v_cod_tranzactie, v_cod_bratara, v_cod_reprezentant, v_data_ora, v_pret);
    
    INSERT INTO DETALII
    VALUES (v_cod_tranzactie, v_cod_produs, 1);
    
    UPDATE INSULA
    SET sold_insula = sold_insula + v_pret
    WHERE cod_insula = v_cod_insula;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Tranzactie reusita.');
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Reprezentantul sau produsul nu exista.');
        RAISE;
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('A aparut o eroare: ' || SQLERRM || '.');
        RAISE;
END;
/

-- acces_VIP
CREATE OR REPLACE PACKAGE acces_VIP AS
    PROCEDURE resetare;
    PROCEDURE raport;
    PROCEDURE acces (
        p_cod_bratara IN BRATARA.cod_bratara%TYPE,
        in_zona_vip IN VARCHAR2,
        in_operatie IN VARCHAR2);
END acces_VIP;
/

-- acces_VIP
CREATE OR REPLACE PACKAGE BODY acces_VIP AS
    TYPE t_zone IS VARRAY(3) OF VARCHAR2(15);
    p_zone_vip t_zone := t_zone('REVERB', 'PULS', 'CULISE_VIP');
    
    TYPE t_participanti IS TABLE OF NUMBER;
    p_participanti t_participanti := t_participanti();
    
    TYPE t_capacitate IS TABLE OF PLS_INTEGER INDEX BY VARCHAR2(15);
    p_capacitate t_capacitate;
    
    TYPE t_locatie IS TABLE OF VARCHAR2(15) INDEX BY PLS_INTEGER;
    p_locatie t_locatie;
    
    capacitate_maxima PLS_INTEGER := 5;
    
    PROCEDURE resetare
    IS
    BEGIN
        p_participanti := t_participanti();
        p_locatie.DELETE;
        p_capacitate.DELETE;
        FOR i IN p_zone_vip.FIRST..p_zone_vip.LAST LOOP
                p_capacitate(p_zone_vip(i)) := 0;
        END LOOP;
        
        DBMS_OUTPUT.NEW_LINE;
        DBMS_OUTPUT.PUT_LINE('Resetare finalizata: a fost reinitializata evidenta participanților VIP din zonele VIP.');
        DBMS_OUTPUT.NEW_LINE;
    END;
    
    PROCEDURE raport
    IS
        v_nume PARTICIPANT.nume%TYPE;
        v_prenume PARTICIPANT.prenume%TYPE;
        v_tip_bilet BILET.tip_bilet%TYPE;
    BEGIN
        DBMS_OUTPUT.NEW_LINE;
        DBMS_OUTPUT.PUT_LINE('Raport acces_VIP');
        DBMS_OUTPUT.NEW_LINE;
        FOR i IN p_zone_vip.FIRST..p_zone_vip.LAST LOOP
            IF p_capacitate.EXISTS(p_zone_vip(i)) THEN
                DBMS_OUTPUT.PUT_LINE('Zona ' || p_zone_vip(i) || ' are capacitatea ' || p_capacitate(p_zone_vip(i)) || '.');
            ELSE
                DBMS_OUTPUT.PUT_LINE('Zona ' || p_zone_vip(i) || ' are capacitatea 0.');
            END IF;
        END LOOP;
        
        DBMS_OUTPUT.NEW_LINE;
        
        IF p_participanti.COUNT > 0 THEN
            FOR i IN p_participanti.FIRST..p_participanti.LAST LOOP
                IF p_participanti.EXISTS(i) THEN
                    SELECT p.nume, p.prenume, b.tip_bilet
                    INTO v_nume, v_prenume, v_tip_bilet
                    FROM PARTICIPANT p
                    JOIN BILET b ON p.cod_participant = b.cod_participant
                    JOIN BRATARA br ON br.cod_bilet = b.cod_bilet 
                    WHERE p.cod_participant = p_participanti(i);
            
                    DBMS_OUTPUT.PUT_LINE('Participantul ' || v_nume || ' ' || v_prenume || ' cu codul ' || p_participanti(i) || ' este in zona ' || p_locatie(p_participanti(i)) || '.');
                END IF;
            END LOOP;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Nu exista niciun participant in zonele VIP.');
        END IF;
        
        DBMS_OUTPUT.NEW_LINE;
    END;
        
    PROCEDURE acces (
        p_cod_bratara IN BRATARA.cod_bratara%TYPE,
        in_zona_vip IN VARCHAR2,
        in_operatie IN VARCHAR2
    ) IS
        p_operatie VARCHAR2(15);
        p_zona_vip VARCHAR2(15);
        p_cod_participant PARTICIPANT.cod_participant%TYPE;
        p_tip_bilet BILET.tip_bilet%TYPE;
        p_verificat BILET.verificat%TYPE;
        p_data_nasterii PARTICIPANT.data_nasterii%TYPE;
        p_varsta NUMBER;
        gasit BOOLEAN;
    BEGIN
        gasit := FALSE;
        p_zona_vip := UPPER(in_zona_vip);
        FOR i IN p_zone_vip.FIRST..p_zone_vip.LAST LOOP
            IF p_zona_vip = p_zone_vip(i) THEN 
                gasit := TRUE;
                EXIT;
            END IF;
        END LOOP;
        
        IF NOT gasit THEN
            RAISE_APPLICATION_ERROR(-20601, 'Zona VIP invalida.');
        END IF;
        
        p_operatie := UPPER(in_operatie);
        IF p_operatie NOT IN ('ACCES', 'IESIRE') THEN
            RAISE_APPLICATION_ERROR(-20602, 'Operatie invalida.');
        END IF;
        
        IF p_capacitate.COUNT = 0 THEN
            FOR i IN p_zone_vip.FIRST..p_zone_vip.LAST LOOP
                p_capacitate(p_zone_vip(i)) := 0;
            END LOOP;
        END IF;
        
        BEGIN
            SELECT p.cod_participant, b.tip_bilet, b.verificat, p.data_nasterii
            INTO p_cod_participant, p_tip_bilet, p_verificat, p_data_nasterii
            FROM BRATARA br
            JOIN BILET b ON b.cod_bilet = br.cod_bilet
            JOIN PARTICIPANT p ON p.cod_participant = b.cod_participant
            WHERE br.cod_bratara = p_cod_bratara;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20603, 'Bratara inexistenta.');
        END;
        
        IF p_tip_bilet NOT IN ('VIP General', 'VIP Ultra') THEN
            DBMS_OUTPUT.PUT_LINE('Acces interzis: biletul nu este VIP.');
            RETURN;
        END IF;
        
        IF p_verificat <> 'A' THEN
            DBMS_OUTPUT.PUT_LINE('Acces interzis: biletul VIP este neverificat');
            RETURN;
        END IF;
        
        p_varsta := FLOOR(MONTHS_BETWEEN(SYSDATE, p_data_nasterii) / 12);
        IF p_varsta < 18 THEN
            DBMS_OUTPUT.PUT_LINE('Acces interzis: participantul este sub 18 ani.');
            RETURN;
        END IF;
        
        IF p_operatie = 'ACCES' THEN
            IF p_locatie.EXISTS(p_cod_participant) THEN
                DBMS_OUTPUT.PUT_LINE('Tentativa de frauda: participantul cu bratara ' || p_cod_participant || ' este deja in zona VIP ' || p_locatie(p_cod_participant) || '.');
                RETURN;
            ELSIF p_capacitate(p_zona_vip) >= capacitate_maxima THEN
                DBMS_OUTPUT.PUT_LINE('Acces nepermis momentan: aceasta zona VIP este la capacitate maxima.');
                RETURN;
            END IF;
            
            p_participanti.EXTEND;
            p_participanti(p_participanti.LAST) := p_cod_participant;
            p_locatie(p_cod_participant) := p_zona_vip;
            p_capacitate(p_zona_vip) := p_capacitate(p_zona_vip) + 1;
            
            DBMS_OUTPUT.PUT_LINE('Acces permis.');
            RETURN;
        ELSE
            IF NOT p_locatie.EXISTS(p_cod_participant) THEN
                DBMS_OUTPUT.PUT_LINE('Tentativa de frauda: participantul cu bratara ' || p_cod_participant || ' nu a fost inregistrat in nicio zona VIP.');
                RETURN;
            END IF;
            
            IF p_locatie(p_cod_participant) <> p_zona_vip THEN
                DBMS_OUTPUT.PUT_LINE('Tentativa de frauda: participantul cu bratara ' || p_cod_participant || ' nu a fost inregistrat in aceasta zona VIP.');
                RETURN;
            END IF;
            
            IF p_participanti.COUNT > 0 THEN
                FOR i IN p_participanti.FIRST..p_participanti.LAST LOOP
                    IF p_participanti.EXISTS(i) AND p_participanti(i) = p_cod_participant THEN
                        p_participanti.DELETE(i);
                        EXIT;
                    END IF;
                END LOOP;
            END IF;
            
            p_capacitate(p_zona_vip) := GREATEST(NVL(p_capacitate(p_zona_vip), 0) - 1, 0);
            p_locatie.DELETE(p_cod_participant);
            
            DBMS_OUTPUT.PUT_LINE('Iesire inregistrata.');
            RETURN;
        END IF;
    END acces;
END acces_VIP;
/

-- raport_editorial_program
CREATE OR REPLACE PROCEDURE raport_editorial_program
IS
    CURSOR c_zile IS
        SELECT DISTINCT TRUNC(inceput) zi
        FROM PROGRAM
        ORDER BY TRUNC(inceput);
        
    CURSOR c_program(zi PROGRAM.inceput%TYPE) IS
        SELECT scene.nume_scena,
            adrese.strada || ', ' || adrese.numar || ', ' || orase.nume_oras || ', ' || regiuni.nume_regiune || ', ' || tari.nume_tara || '.' adresa_scenei,
            (
            SELECT NVL(artisti.nume_de_scena, artisti.prenume)
            FROM PROGRAM programe
            JOIN ARTIST artisti ON artisti.cod_contribuitor = programe.cod_contribuitor
            JOIN CONTRACT contracte ON contracte.cod_contribuitor = artisti.cod_contribuitor
            WHERE programe.cod_scena = scene.cod_scena 
                AND TRUNC(programe.inceput) = TRUNC(zi)
            ORDER BY contracte.valoare DESC
            FETCH FIRST 1 ROW ONLY
            ) cap_de_afis,
            CURSOR (
                SELECT programe.inceput, programe.sfarsit,
                    CASE contribuitori.tip_contribuitor
                        WHEN 'artist' THEN 
                            NVL(artisti.nume_de_scena, artisti.prenume)
                        WHEN 'sponsor' THEN
                            'moment special ' || sponsori.nume_sponsor || '.'
                        END nume_publicabil
                FROM PROGRAM programe
                JOIN CONTRIBUITOR contribuitori ON contribuitori.cod_contribuitor = programe.cod_contribuitor
                LEFT JOIN ARTIST artisti ON artisti.cod_contribuitor = contribuitori.cod_contribuitor
                LEFT JOIN SPONSOR sponsori ON sponsori.cod_contribuitor = contribuitori.cod_contribuitor
                WHERE programe.cod_scena = scene.cod_scena 
                    AND TRUNC(programe.inceput) = TRUNC(zi)
                ORDER BY programe.inceput
                ) programele_scenei
        FROM SCENA scene
        JOIN ADRESA adrese ON adrese.cod_adresa = scene.cod_adresa
        JOIN ORAS orase ON orase.cod_oras = adrese.cod_oras
        JOIN REGIUNE regiuni ON regiuni.cod_regiune = orase.cod_regiune
        JOIN TARA tari ON tari.cod_tara = regiuni.cod_tara
        ORDER BY scene.nume_scena;
    
    TYPE t_rc IS REF CURSOR;
    rc_program t_rc;
    
    v_zi PROGRAM.inceput%TYPE;
    v_nume_scena SCENA.nume_scena%TYPE;
    v_adresa VARCHAR2(150);
    v_cap_de_afis VARCHAR2(50);
    v_inceput PROGRAM.inceput%TYPE;
    v_sfarsit PROGRAM.sfarsit%TYPE;
    v_nume_publicabil VARCHAR2(50);
    
    v_ziua PLS_INTEGER := 0;
    v_evenimente BOOLEAN;
    
BEGIN
    FOR v_data IN c_zile LOOP
        v_ziua := v_ziua + 1;
        v_zi := v_data.zi;
        
        DBMS_OUTPUT.NEW_LINE;
        DBMS_OUTPUT.PUT_LINE('Ziua ' || v_ziua || ' - ' ||
            TO_CHAR(v_zi, 'FMDay', 'NLS_DATE_LANGUAGE = ROMANIAN') || ', ' || -- *
            TO_CHAR(v_zi, 'DD', 'NLS_DATE_LANGUAGE = ROMANIAN') || ' ' ||
            TO_CHAR(v_zi, 'FMMonth', 'NLS_DATE_LANGUAGE = ROMANIAN') || ', ' ||
            TO_CHAR(v_zi, 'YYYY', 'NLS_DATE_LANGUAGE = ROMANIAN'));
        
        OPEN c_program(v_zi);
        LOOP
            FETCH c_program INTO v_nume_scena, v_adresa, v_cap_de_afis, rc_program;
            EXIT WHEN c_program%NOTFOUND;
            
            DBMS_OUTPUT.NEW_LINE;
            DBMS_OUTPUT.PUT_LINE(v_nume_scena);
            DBMS_OUTPUT.PUT_LINE(v_adresa);
            
            IF v_cap_de_afis IS NULL THEN
                DBMS_OUTPUT.PUT_LINE('Nu exista cap de afis: Nu exista artisti programati.');
            ELSE
                DBMS_OUTPUT.PUT_LINE('Cap de afis ' || v_cap_de_afis || '.');
            END IF;
            
            v_evenimente := FALSE;
            
            LOOP
                FETCH rc_program INTO v_inceput, v_sfarsit, v_nume_publicabil;
                EXIT WHEN rc_program%NOTFOUND;
                
                v_evenimente := TRUE;
                DBMS_OUTPUT.PUT_LINE('    ' || TO_CHAR(v_inceput, 'HH24:MI') || '-' || TO_CHAR(v_sfarsit, 'HH24:MI') || ' ' || v_nume_publicabil);
            END LOOP;
            
            CLOSE rc_program;
            
            IF NOT v_evenimente THEN
                DBMS_OUTPUT.PUT_LINE('    Nu exista niciun eveniment programat.');
            END IF;
            
        END LOOP;
        CLOSE c_program;
        
    END LOOP;
END raport_editorial_program;
/

-- p_verificare_disponibilitate_produs
CREATE OR REPLACE PROCEDURE p_verificare_disponibilitate_produs (
    p_cod_participant IN PARTICIPANT.cod_participant%TYPE, 
    p_nume_produs IN PRODUS.nume_produs%TYPE
 )
IS
    v_nume_participant PARTICIPANT.nume%TYPE;
    v_prenume_participant PARTICIPANT.prenume%TYPE;
    
    v_cod_bratara BRATARA.cod_bratara%TYPE;
    v_sold_bratara BRATARA.sold_bratara%TYPE;
    v_verificat BILET.verificat%TYPE;
    
    v_produse_gasite PLS_INTEGER;
    
    v_cod_produs PRODUS.cod_produs%TYPE;
    v_nume_produs PRODUS.nume_produs%TYPE;
    v_pret_produs PRODUS.pret%TYPE;
    
    v_stocuri_gasite PLS_INTEGER;
    
    v_cod_insula INSULA.cod_insula%TYPE;
    v_nume_sponsor SPONSOR.nume_sponsor%TYPE;
    
    v_cantitate_disponibila ARE_STOC.cantitate_disponibila%TYPE;
    
    v_insule PLS_INTEGER;
    
    v_strada ADRESA.strada%TYPE;
    v_numar ADRESA.numar%TYPE;
    v_nume_oras ORAS.nume_oras%TYPE;
    v_nume_regiune REGIUNE.nume_regiune%TYPE;
    v_nume_tara TARA.nume_tara%TYPE;
    
    e_participat_negasit EXCEPTION;
    e_denumire_inexistenta EXCEPTION;
    e_participant_inexistent EXCEPTION;
    e_bilet_neverificat EXCEPTION;
    e_produs_inexistent EXCEPTION;
    e_produs_ambiguu EXCEPTION;
        
BEGIN
    IF p_cod_participant IS NULL THEN
        RAISE e_participant_inexistent;
    END IF;
    
    IF p_nume_produs IS NULL OR TRIM(p_nume_produs) IS NULL THEN
        RAISE e_denumire_inexistenta;
    END IF;
    
    WITH
    s_participant AS (
        SELECT nume, prenume
        FROM PARTICIPANT
        WHERE cod_participant = p_cod_participant
        ),
    s_bratara AS (
        SELECT br.cod_bratara, br.sold_bratara, b.verificat
        FROM BILET b
        JOIN BRATARA br ON br.cod_bilet = b.cod_bilet
        WHERE b.cod_participant = p_cod_participant
        ),
    s_produse AS (
        SELECT p.cod_produs, p.nume_produs, p.pret,
            (
            CASE
                WHEN LOWER(p.nume_produs) LIKE LOWER(TRIM(p_nume_produs)) || '%' THEN
                    1
                ELSE
                    2
            END
            ) relevanta
        FROM PRODUS p
        WHERE LOWER(p.nume_produs) LIKE '%' || LOWER(TRIM(p_nume_produs)) || '%'
        ),
    s_relevanta AS (
        SELECT MIN(relevanta) relevanta
        FROM s_produse
        ),
    s_cautare_produs AS (
        SELECT p.*
        FROM s_produse p
        WHERE p.relevanta = (
                                SELECT relevanta
                                FROM s_relevanta
                            )
        ),
    s_produse_gasite AS (
        SELECT COUNT(*) produse_gasite
        FROM s_cautare_produs
        ),
    s_produs AS (
        SELECT cp.*
        FROM s_cautare_produs cp
        WHERE ROWNUM = 1
        ),
    s_cautare_stoc AS (
        SELECT i.cod_insula, a.cantitate_disponibila
        FROM INSULA i
        JOIN ARE_STOC a ON a.cod_insula = i.cod_insula
        JOIN s_produs p ON p.cod_produs = a.cod_produs
        WHERE a.cantitate_disponibila > 0
        ),
    s_stocuri_gasite AS (
        SELECT COUNT(*) stocuri_gasite
        FROM s_cautare_stoc
        ),
    s_stoc AS (
        SELECT cs.*
        FROM s_cautare_stoc cs
        WHERE ROWNUM = 1
        ),
    s_insula AS (
        SELECT s.nume_sponsor, 
            a.strada, a.numar, 
            o.nume_oras, r.nume_regiune, t.nume_tara
        FROM s_stoc stoc
        JOIN INSULA i ON i.cod_insula = stoc.cod_insula
        JOIN SPONSOR s ON s.cod_contribuitor = i.cod_contribuitor
        JOIN ADRESA a ON a.cod_adresa = i.cod_adresa
        JOIN ORAS o ON o.cod_oras = a.cod_oras
        JOIN REGIUNE r ON r.cod_regiune = o.cod_regiune
        JOIN TARA t ON t.cod_tara = r.cod_tara
        )
    SELECT
        sp.nume, sp.prenume,
        sb.cod_bratara, sb.sold_bratara, sb.verificat,
        pg.produse_gasite,
        pr.cod_produs, pr.nume_produs, pr.pret,
        sg.stocuri_gasite,
        st.cod_insula, st.cantitate_disponibila,
        si.nume_sponsor,
        si.strada, si.numar, si.nume_oras, si.nume_regiune, si.nume_tara
    INTO
        v_nume_participant, v_prenume_participant,
        v_cod_bratara, v_sold_bratara, v_verificat,
        v_produse_gasite,
        v_cod_produs, v_nume_produs, v_pret_produs,
        v_stocuri_gasite,
        v_cod_insula, v_cantitate_disponibila,
        v_nume_sponsor,
        v_strada, v_numar, v_nume_oras, v_nume_regiune, v_nume_tara
    FROM s_produse_gasite pg
    CROSS JOIN s_stocuri_gasite sg
    LEFT JOIN s_participant sp ON 1 = 1
    LEFT JOIN s_bratara sb ON 1 = 1
    LEFT JOIN s_produs pr ON 1 = 1
    LEFT JOIN s_stoc st ON 1 = 1
    LEFT JOIN s_insula si ON 1 = 1;
    
    IF v_nume_participant IS NULL OR v_prenume_participant IS NULL THEN
        RAISE e_participat_negasit;
    END IF;
    
    IF v_verificat = 'F' THEN 
        RAISE e_bilet_neverificat; 
    END IF;
    
    IF v_produse_gasite = 0 OR v_cod_produs IS NULL THEN
        RAISE e_produs_inexistent;
    ELSIF v_produse_gasite > 1 THEN 
        RAISE e_produs_ambiguu;
    END IF;
    
    SELECT COUNT(*)
    INTO v_insule
    FROM INSULA i
    JOIN SPONSOR s ON s.cod_contribuitor = i.cod_contribuitor
    WHERE s.nume_sponsor = v_nume_sponsor;
    
    IF NVL(v_cantitate_disponibila, 0) > 0 THEN
        DBMS_OUTPUT.PUT_LINE( v_nume_produs || ' este disponibil' ||
            CASE
            WHEN v_stocuri_gasite = v_insule THEN
                ' la toate insulele '
            WHEN v_stocuri_gasite > 1 THEN
                ' la mai multe insule '
            WHEN v_stocuri_gasite = 1 THEN
                ' doar la o insula '
            END || v_nume_sponsor || '.');
        
        DBMS_OUTPUT.PUT_LINE('Produsul este in stoc ' ||
            CASE
                WHEN v_cantitate_disponibila >= 5 THEN
                    'suficient'
                ELSE
                    'limitat' 
                END ||
            ' si il gasesti la insula ' || v_nume_sponsor || ', ' || v_strada || ', ' || v_numar || ', ' || v_nume_oras || ', ' || v_nume_regiune || ', ' || v_nume_tara || '.');
    
        DBMS_OUTPUT.PUT_LINE('Pretul produsului este de ' || v_pret_produs || ' RON.');
    
        DBMS_OUTPUT.NEW_LINE;
    
        DBMS_OUTPUT.PUT_LINE('Soldul bratarii tale este ' || v_sold_bratara || ' RON.');
        
        IF v_sold_bratara < v_pret_produs THEN
            DBMS_OUTPUT.PUT_LINE('Pentru a putea achizitiona acest produs este necesara incarcarea bratarii cu ' || TO_CHAR(v_pret_produs - v_sold_bratara) || ' RON.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Poti achizitiona acest produs.');
        END IF;
        
    ELSE
        DBMS_OUTPUT.PUT_LINE(v_nume_produs || ' este indisponibil momentan.');
    END IF;
    
EXCEPTION
    WHEN e_participat_negasit THEN
        RAISE_APPLICATION_ERROR(-20901, 'Nu a fost identificat niciun participant cu codul ' || p_cod_participant || '.');
    WHEN e_denumire_inexistenta THEN
         RAISE_APPLICATION_ERROR(-20902, 'Denumirea produsului nu poate fi NULL.');
    WHEN e_participant_inexistent THEN
        RAISE_APPLICATION_ERROR(-20903, 'Codul participantului nu poate fi NULL.');
    WHEN e_bilet_neverificat THEN
        RAISE_APPLICATION_ERROR(-20904, 'Biletul este neverificat.');
    WHEN e_produs_inexistent THEN
        RAISE_APPLICATION_ERROR(-20905, 'Nu a fost identificat niciun produs care sa corespunda criteriului ''' || p_nume_produs || '''.');
    WHEN e_produs_ambiguu THEN
        RAISE_APPLICATION_ERROR(-20906, 'Cautarea este ambigua pentru criteriul ''' || p_nume_produs || '''.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20907, 'Eroare neasteptata ' || SQLERRM);
END;
/

-- p_suspiciune
CREATE OR REPLACE PROCEDURE p_suspiciune (
    p_motiv IN VARCHAR2
) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    INSERT INTO SUSPICIUNE(cod_suspiciune, nume_utilizator, data_ora, motiv)
    VALUES (seq_suspiciune.NEXTVAL, USER, SYSTIMESTAMP, p_motiv);
    
    COMMIT;
END;
/

-- pkg_mentenanta
CREATE OR REPLACE PACKAGE pkg_mentenanta IS
    mentenanta_activa BOOLEAN := FALSE;
    
    PROCEDURE incepe(p_observatii VARCHAR2 := NULL);
    PROCEDURE termina;
END pkg_mentenanta;
/

-- pkg_mentenanta
CREATE OR REPLACE PACKAGE BODY pkg_mentenanta IS
    PROCEDURE incepe(p_observatii VARCHAR2 := NULL) IS
    BEGIN
        mentenanta_activa := TRUE;
        
        INSERT INTO MENTENANTA (cod_mentenanta, data_inceput, initiator, observatii)
        VALUES (seq_mentenanta.NEXTVAL, SYSTIMESTAMP, USER, p_observatii);
        
        COMMIT;
        
        DBMS_OUTPUT.PUT_LINE('Programul de mentenata inceputa. Realizati modificarile necesare iar apoi opriti programul de mentenanta prin pkg_mentenanta.termina.');
        
    END incepe;
    
    PROCEDURE termina IS
    BEGIN
        mentenanta_activa := FALSE;
        
        UPDATE MENTENANTA
        SET data_sfarsit = SYSTIMESTAMP
        WHERE data_sfarsit IS NULL;
        
        COMMIT;
        
        DBMS_OUTPUT.PUT_LINE('Programul de mentenanta s-a terminat.');
        
    END termina;

END pkg_mentenanta;
/

-- pkg_comenzi
CREATE OR REPLACE PACKAGE pkg_comenzi AS

    TYPE articol IS RECORD (
            cod_produs PRODUS.cod_produs%TYPE,
            cantitate DETALII.cantitate%TYPE
            );
    
    TYPE cos IS TABLE OF articol INDEX BY PLS_INTEGER;
    
    TYPE bon IS RECORD (
        cod_tranzactie TRANZACTIE.cod_tranzactie%TYPE,
        cod_bratara BRATARA.cod_bratara%TYPE,
        cod_insula INSULA.cod_insula%TYPE,
        total TRANZACTIE.suma%TYPE,
        sold_initial BRATARA.sold_bratara%TYPE,
        sold_final BRATARA.sold_bratara%TYPE
        );
    
    PROCEDURE resetare_cos;
    
    PROCEDURE adauga_produs (
        cod_produs IN PRODUS.cod_produs%TYPE,
        cantitate IN DETALII.cantitate%TYPE DEFAULT 1
        );
    
    PROCEDURE sterge_produs (
        cod_produs IN PRODUS.cod_produs%TYPE,
        cantitate IN DETALII.cantitate%TYPE DEFAULT 1
        );
    
    FUNCTION total_comanda
        RETURN NUMBER;
    
    FUNCTION bon_electronic
        RETURN VARCHAR2;
    
    PROCEDURE proceseaza_comanda (
        cod_bratara IN BRATARA.cod_bratara%TYPE,
        cod_reprezentant IN REPREZENTANT.cod_reprezentant%TYPE
        );
        
END pkg_comenzi;
/

-- pkg_comenzi
CREATE OR REPLACE PACKAGE BODY pkg_comenzi AS
    cos_curent cos;
    bon_curent bon;
    bon_disponibil BOOLEAN := FALSE;
    
    PROCEDURE resetare_cos IS
    BEGIN
        cos_curent.DELETE;
        
        DBMS_OUTPUT.PUT_LINE('Cosul de cumparaturi a fost golit.');
    END resetare_cos;
    
    PROCEDURE adauga_produs (
        cod_produs IN PRODUS.cod_produs%TYPE,
        cantitate IN DETALII.cantitate%TYPE DEFAULT 1
    ) IS
        v_cod_produs PRODUS.cod_produs%TYPE := cod_produs;
        v_cantitate DETALII.cantitate%TYPE := cantitate;
        v_nume_produs PRODUS.nume_produs%TYPE;
    BEGIN
    
        IF v_cantitate IS NULL OR v_cantitate <= 0 THEN
            RAISE_APPLICATION_ERROR(-20910, 'Cantitatea trebuie sa fie strict pozitiva.');
        END IF;
        
        BEGIN
            SELECT p.nume_produs
            INTO v_nume_produs
            FROM PRODUS p
            WHERE p.cod_produs = v_cod_produs;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20905, 'Produsul cu codul ' || v_cod_produs || ' nu exista.');
        END;
        
        IF cos_curent.EXISTS(v_cod_produs) THEN
            cos_curent(v_cod_produs).cantitate := cos_curent(v_cod_produs).cantitate + v_cantitate;
        ELSE
            cos_curent(v_cod_produs).cod_produs := v_cod_produs;
            cos_curent(v_cod_produs).cantitate := v_cantitate;
        END IF;
    
        DBMS_OUTPUT.PUT_LINE(
            'Produs adaugat in cos: ' || v_nume_produs || ' x '|| v_cantitate || '.');
        
    END adauga_produs;
    
    PROCEDURE sterge_produs(
        cod_produs IN PRODUS.cod_produs%TYPE,
        cantitate IN DETALII.cantitate%TYPE DEFAULT 1
    ) IS
        v_cod_produs PRODUS.cod_produs%TYPE := cod_produs;
        v_cantitate DETALII.cantitate%TYPE := cantitate;
        v_nume_produs PRODUS.nume_produs%TYPE;
    BEGIN
        IF v_cantitate IS NULL OR v_cantitate <= 0 THEN
            RAISE_APPLICATION_ERROR(-20910, 'Cantitatea trebuie sa fie strict pozitiva.');
        END IF;
        
        IF NOT cos_curent.EXISTS(v_cod_produs) THEN
            RAISE_APPLICATION_ERROR(-20912, 'Produsul cu codul ' || v_cod_produs || ' nu exista in cos.');
        END IF;
        
        SELECT p.nume_produs
        INTO v_nume_produs
        FROM PRODUS p
        WHERE p.cod_produs = v_cod_produs;
        
        IF v_cantitate > cos_curent(v_cod_produs).cantitate THEN
            RAISE_APPLICATION_ERROR(-20913, 'Cantitatea solicitata pentru stergere este mai mare decat cantitatea existenta in cos.');
        END IF;
        
        IF v_cantitate = cos_curent(v_cod_produs).cantitate THEN
            cos_curent.DELETE(v_cod_produs);
            
            DBMS_OUTPUT.PUT_LINE('Produs eliminat din cos: ' || v_nume_produs || '.');
        ELSE
            cos_curent(v_cod_produs).cantitate := cos_curent(v_cod_produs).cantitate - v_cantitate;
            
            DBMS_OUTPUT.PUT_LINE('Cantitatea produsului ' || v_nume_produs || ' a fost diminuata cu ' || v_cantitate || '.');
        END IF;
    END sterge_produs;
    
    FUNCTION total_comanda RETURN NUMBER
    IS
        v_total NUMBER(12, 2) := 0;
        v_pret PRODUS.pret%TYPE;
        i PLS_INTEGER;
    BEGIN
        IF cos_curent.COUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20904, 'Cosul de cumparaturi este gol.');
        END IF;
        
        i := cos_curent.FIRST;
        
        WHILE i IS NOT NULL LOOP
            SELECT p.pret
            INTO v_pret
            FROM PRODUS p
            WHERE p.cod_produs = cos_curent(i).cod_produs;
            
            v_total := v_total + v_pret * cos_curent(i).cantitate;
            
            i := cos_curent.NEXT(i);
        END LOOP;
        
        RETURN v_total;
    END total_comanda;
    
    FUNCTION bon_electronic
        RETURN VARCHAR2
    IS
        v_bon VARCHAR2(30000);
        v_data_ora TRANZACTIE.data_ora%TYPE;
        v_nume_participant PARTICIPANT.nume%TYPE;
        v_prenume_participant PARTICIPANT.prenume%TYPE;
        v_nume_reprezentant REPREZENTANT.nume%TYPE;
        v_prenume_reprezentant REPREZENTANT.prenume%TYPE;
        v_nume_sponsor SPONSOR.nume_sponsor%TYPE;
    BEGIN
        IF NOT bon_disponibil THEN
            RAISE_APPLICATION_ERROR(-20911, 'Nu exista nicio tranzactie pentru care sa se poata genera bonul');
        END IF;
        
        SELECT t.data_ora,
            p.nume,
            p.prenume,
            r.nume,
            r.prenume,
            s.nume_sponsor
        INTO v_data_ora,
            v_nume_participant,
            v_prenume_participant,
            v_nume_reprezentant,
            v_prenume_reprezentant,
            v_nume_sponsor
        FROM TRANZACTIE t
        JOIN BRATARA br ON br.cod_bratara = t.cod_bratara
        JOIN BILET b ON b.cod_bilet = br.cod_bilet
        JOIN PARTICIPANT p ON p.cod_participant = b.cod_participant
        JOIN REPREZENTANT r ON r.cod_reprezentant = t.cod_reprezentant
        JOIN INSULA i ON i.cod_insula = r.cod_insula
        JOIN SPONSOR s ON s.cod_contribuitor = i.cod_contribuitor
        WHERE t.cod_tranzactie = bon_curent.cod_tranzactie;
        
        v_bon := 
            CHR(10)
            || '===================================================='
            || CHR(10)
            || '                      BREEZE'
            || CHR(10)
            || '                       BON'
            || CHR(10)
            || '===================================================='
            || CHR(10)
            || 'Tranzactie: #' || bon_curent.cod_tranzactie
            || CHR(10)
            || 'Data: ' || TO_CHAR(v_data_ora, 'DD.MM.YYYY HH24:MI:SS')
            || CHR(10)
            || 'Participant: ' || v_nume_participant || ' ' || v_prenume_participant
            || CHR(10)
            || 'Bratara: #' || bon_curent.cod_bratara
            || CHR(10)
            || 'Insula: #' || bon_curent.cod_insula || ' - ' || v_nume_sponsor
            || CHR(10)
            || 'Reprezentant: ' || v_nume_reprezentant || ' ' || v_prenume_reprezentant
            || CHR(10)
            || '----------------------------------------------------'
            || CHR(10)
            || RPAD('Produs', 26)
            || LPAD('Cant.', 7)
            || LPAD('Pret', 9)
            || LPAD('Total', 10)
            || CHR(10)
            || '----------------------------------------------------'
            || CHR(10);
            
        FOR x IN (
            SELECT p.nume_produs,
                d.cantitate,
                p.pret,
                d.cantitate * p.pret subtotal
            FROM DETALII d
            JOIN PRODUS p ON p.cod_produs = d.cod_produs
            WHERE d.cod_tranzactie = bon_curent.cod_tranzactie
            ORDER BY p.nume_produs
            ) LOOP
                v_bon := v_bon 
                    || RPAD(SUBSTR(x.nume_produs, 1, 25), 26)
                    || LPAD(x.cantitate, 7)
                    || LPAD(TO_CHAR(x.pret, 'FM99990.00'), 9)
                    || LPAD(TO_CHAR(x.subtotal, 'FM99990.00'), 10)
                    || CHR(10);
        END LOOP;
        
        v_bon := v_bon
            || '----------------------------------------------------'
            || CHR(10)
            || RPAD('Sold initial: ', 42)
            || LPAD(TO_CHAR(bon_curent.sold_initial, 'FM99990.00'), 10)
            || CHR(10)
            || RPAD('TOTAL: ', 42)
            || LPAD(TO_CHAR(bon_curent.total, 'FM99990.00'), 10)
            || CHR(10)
            || RPAD('Sold ramas: ', 42)
            || LPAD(TO_CHAR(bon_curent.sold_final, 'FM99990.00'), 10)
            || CHR(10)
            || '===================================================='
            || CHR(10)
            || '                    Multumim!'
            || CHR(10)
            || '===================================================='
            || CHR(10);
            
        RETURN v_bon;
    END bon_electronic;
    
    PROCEDURE proceseaza_comanda (
        cod_bratara IN BRATARA.cod_bratara%TYPE,
        cod_reprezentant IN REPREZENTANT.cod_reprezentant%TYPE
        ) IS
        v_cod_bratara BRATARA.cod_bratara%TYPE := cod_bratara;
        v_cod_reprezentant REPREZENTANT.cod_reprezentant%TYPE := cod_reprezentant;
        v_cod_insula INSULA.cod_insula%TYPE;
        v_sold_initial BRATARA.sold_bratara%TYPE;
        v_sold_final BRATARA.sold_bratara%TYPE;
        v_verificat BILET.verificat%TYPE;
        v_total NUMBER(12, 2);
        v_stoc ARE_STOC.cantitate_disponibila%TYPE;
        v_nume_produs PRODUS.nume_produs%TYPE;
        v_cod_tranzactie TRANZACTIE.cod_tranzactie%TYPE;
        i PLS_INTEGER;
    BEGIN
        bon_disponibil := FALSE;
        SAVEPOINT inceput_comanda;
        
        IF cos_curent.COUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20904, 'Cosul de cumparaturi este gol.');
        END IF;
        
        BEGIN
            SELECT r.cod_insula 
            INTO v_cod_insula
            FROM REPREZENTANT r
            WHERE r.cod_reprezentant = v_cod_reprezentant;
            
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20903, 'Reprezentantul cu codul ' || v_cod_reprezentant || ' nu exista.');
        END;
        
        BEGIN
            SELECT br.sold_bratara, b.verificat
            INTO v_sold_initial, v_verificat
            FROM BRATARA br
            JOIN BILET b ON b.cod_bilet = br.cod_bilet
            WHERE br.cod_bratara = v_cod_bratara
            FOR UPDATE;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20901, 'Bratara cu codul ' || v_cod_bratara || ' nu exista.');
        END;
        
        IF v_verificat <> 'A' THEN
            RAISE_APPLICATION_ERROR(-20902, 'Biletul asociat bratarii ' || v_cod_bratara || ' nu este verificat.');
        END IF;
        
        v_total := total_comanda;
        
        IF v_sold_initial < v_total THEN
            RAISE_APPLICATION_ERROR(-20908, 'Sold insuficient. Valoarea comenzii este ' || TO_CHAR(v_total, 'FM99990.00') || ', iar soldul disponibil este ' || TO_CHAR(v_sold_initial, 'FM99990.00') || '.');
        END IF;
        
        i := cos_curent.FIRST;
        
        WHILE i IS NOT NULL LOOP
        
            SELECT p.nume_produs
            INTO v_nume_produs
            FROM PRODUS p
            WHERE p.cod_produs = cos_curent(i).cod_produs;
            
            BEGIN
                SELECT a.cantitate_disponibila
                INTO v_stoc
                FROM ARE_STOC a
                WHERE a.cod_insula = v_cod_insula AND a.cod_produs = cos_curent(i).cod_produs
                FOR UPDATE;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    RAISE_APPLICATION_ERROR(-20906, 'Produsul ' || v_nume_produs || ' nu este disponibil la insula ' || v_cod_insula || '.');
            END;
            
            IF v_stoc < cos_curent(i).cantitate THEN
                RAISE_APPLICATION_ERROR(-20907, 'Stoc insuficient pentru produsul ' || v_nume_produs || '. Cantitate solicitata: ' || cos_curent(i).cantitate || ', cantitate disponibila: ' || v_stoc || '.');
            END IF;
        
            UPDATE ARE_STOC a
            SET cantitate_disponibila = cantitate_disponibila - cos_curent(i).cantitate
            WHERE a.cod_insula = v_cod_insula AND a.cod_produs = cos_curent(i).cod_produs;
        
            i := cos_curent.NEXT(i);
        END LOOP;
        
        UPDATE BRATARA br
        SET sold_bratara = sold_bratara - v_total
        WHERE br.cod_bratara = v_cod_bratara;
        
        UPDATE INSULA i
        SET sold_insula = sold_insula + v_total
        WHERE i.cod_insula = v_cod_insula;
        
        v_cod_tranzactie := seq_cod_tranzactie.NEXTVAL;
        
        INSERT INTO TRANZACTIE(
            cod_tranzactie,
            cod_bratara,
            cod_reprezentant,
            data_ora, suma
            ) VALUES ( 
            v_cod_tranzactie,
            v_cod_bratara,
            v_cod_reprezentant,
            SYSTIMESTAMP,
            v_total
        );
        
        i := cos_curent.FIRST;
        
        WHILE i IS NOT NULL LOOP
            INSERT INTO DETALII (
                cod_tranzactie,
                cod_produs,
                cantitate
                ) VALUES (
                v_cod_tranzactie,
                cos_curent(i).cod_produs,
                cos_curent(i).cantitate
            );
            
            i := cos_curent.NEXT(i);
        END LOOP;
        
        SELECT br.sold_bratara
        INTO v_sold_final
        FROM BRATARA br
        WHERE br.cod_bratara = v_cod_bratara;
        
        bon_curent.cod_tranzactie := v_cod_tranzactie;
        bon_curent.cod_bratara := v_cod_bratara;
        bon_curent.cod_insula := v_cod_insula;
        bon_curent.total := v_total;
        bon_curent.sold_initial := v_sold_initial;
        bon_curent.sold_final := v_sold_final;
        bon_disponibil := TRUE;
        
        
        DBMS_OUTPUT.NEW_LINE;
        DBMS_OUTPUT.PUT_LINE('Comanda a fost procesata cu succes.');
        DBMS_OUTPUT.PUT_LINE('Tranzactie generata: #' || v_cod_tranzactie);
        DBMS_OUTPUT.PUT_LINE('Valoare comanda: ' || TO_CHAR(v_total, 'FM999990.00'));
        
        DBMS_OUTPUT.PUT_LINE(bon_electronic);
        
        COMMIT;
        
        cos_curent.DELETE;
        
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK TO inceput_comanda;
            bon_disponibil := FALSE;
            DBMS_OUTPUT.PUT_LINE('Comanda a fost anulata.');
            DBMS_OUTPUT.PUT_LINE('Motiv: ' || SQLERRM);
            
            RAISE;
    END proceseaza_comanda;
END pkg_comenzi;
/
