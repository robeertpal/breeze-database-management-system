-- Functii stocate independente. Functiile membre ale pachetelor se afla in 04.

SET DEFINE OFF
SET SQLBLANKLINES ON
SET SERVEROUTPUT ON
WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK

-- f_contactare_manager_departament
CREATE OR REPLACE FUNCTION f_contactare_manager_departament(p_departament IN DEPARTAMENT.nume_departament%TYPE)
    RETURN VARCHAR2
IS
    v_rezultat VARCHAR2(2000);
BEGIN
    IF p_departament IS NULL OR TRIM(p_departament) IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'Parametrul nu poate fi NULL sau gol.');
    END IF;
    
    SELECT 'Departamentul ' || d.nume_departament || CHR(10) || -- *
        'cu sediul la adresa ' || a.strada || ', ' || a.numar || ', ' || o.nume_oras || ', ' || r.nume_regiune || ', ' || t.nume_tara || CHR(10) ||
        'manager ' || p.nume || ' ' || p.prenume || CHR(10) ||
        'contact ' || p.mail || ' ' || p.numar_telefon
    INTO v_rezultat
    FROM DEPARTAMENT d
    JOIN MANAGER m ON m.cod_departament = d.cod_departament
    JOIN PERSONAL p ON p.cod_personal = m.cod_personal
    JOIN ADRESA a ON a.cod_adresa = d.cod_adresa
    JOIN ORAS o ON a.cod_oras = o.cod_oras
    JOIN REGIUNE r ON r.cod_regiune = o.cod_regiune
    JOIN TARA t ON t.cod_tara = r.cod_tara
    WHERE LOWER(d.nume_departament) LIKE '%' || LOWER(TRIM(p_departament)) || '%'
        AND (CASE
                WHEN LOWER(d.nume_departament) LIKE LOWER(TRIM(p_departament)) || '%' THEN
                    1
                ELSE
                    2
            END)
            =
            (SELECT MIN(
                CASE
                    WHEN LOWER(d2.nume_departament) LIKE LOWER(TRIM(p_departament)) || '%' THEN
                        1
                    ELSE
                        2
                END
                )
            FROM DEPARTAMENT d2
            WHERE LOWER(d2.nume_departament) LIKE '%' || LOWER(TRIM(p_departament)) || '%'
            );
        
    RETURN v_rezultat;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20801, 'Nu a fost identificat niciun departament care sa corespunda criteriului: ''' || TRIM(p_departament) || '''.');
    WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20802, 'Cautarea este ambigua pentru criteriul: ''' || TRIM(p_departament) || '''. Exista mai multe departamente la acelasi nivel de relevanta.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20803, 'Eroare neprevazuta in f_contact_manager_departament: ' || SQLERRM);
END;
/
