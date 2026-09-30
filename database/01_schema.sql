-- Schema relationala: tabele, constrangeri si secvente. Se ruleaza o singura data intr-o schema goala.

SET DEFINE OFF
SET SQLBLANKLINES ON
SET SERVEROUTPUT ON
WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK

-- TARA
CREATE TABLE TARA(
    cod_tara NUMBER(5) PRIMARY KEY,
    nume_tara VARCHAR2(30) NOT NULL UNIQUE
);

-- REGIUNE
CREATE TABLE REGIUNE(
    cod_regiune NUMBER(5) PRIMARY KEY,
    nume_regiune VARCHAR2(25) NOT NULL UNIQUE,
    cod_tara NUMBER(5) NOT NULL,
    CONSTRAINT fk_regiune_tara FOREIGN KEY (cod_tara) REFERENCES TARA(cod_tara)
);

-- ORAS
CREATE TABLE ORAS (
    cod_oras NUMBER(10) PRIMARY KEY,
    nume_oras VARCHAR2(25) NOT NULL UNIQUE,
    cod_regiune NUMBER(5) NOT NULL,
    CONSTRAINT fk_oras_regiune FOREIGN KEY (cod_regiune) REFERENCES REGIUNE(cod_regiune)
);

-- ADRESA
CREATE TABLE ADRESA (
    cod_adresa NUMBER(15) PRIMARY KEY,
    strada VARCHAR2(50) NOT NULL,
    numar VARCHAR2(25) NOT NULL,
    cod_oras NUMBER(10) NOT NULL,
    CONSTRAINT fk_adresa_oras FOREIGN KEY (cod_oras) REFERENCES ORAS(cod_oras)
);

-- DEPARTAMENT
CREATE TABLE DEPARTAMENT (
    cod_departament NUMBER(5) PRIMARY KEY,
    nume_departament VARCHAR2(25) NOT NULL UNIQUE,
    cod_adresa NUMBER(15) NOT NULL,
    CONSTRAINT fk_departament_adresa FOREIGN KEY (cod_adresa) REFERENCES ADRESA(cod_adresa)
);

-- JOB
CREATE TABLE JOB (
    cod_job NUMBER(5) PRIMARY KEY,
    nume_job VARCHAR2(50) NOT NULL UNIQUE,
    cod_departament NUMBER(5) NOT NULL,
    CONSTRAINT fk_job_departament FOREIGN KEY (cod_departament) REFERENCES DEPARTAMENT(cod_departament)
);

-- PERSONAL
CREATE TABLE PERSONAL (
    cod_personal NUMBER(5) PRIMARY KEY,
    tip_personal VARCHAR2(10) NOT NULL CHECK (tip_personal IN ('agent', 'manager')),
    nume VARCHAR2(25) NOT NULL,
    prenume VARCHAR2(50) NOT NULL,
    cod_adresa NUMBER(15) NOT NULL,
    mail VARCHAR2(50) UNIQUE NOT NULL,
    numar_telefon VARCHAR2(25) UNIQUE NOT NULL,
    salariu NUMBER(10,2) NOT NULL CHECK (salariu > 0),
    data_nasterii DATE NOT NULL,
    data_angajarii DATE NOT NULL,
    CONSTRAINT fk_personal_adresa FOREIGN KEY (cod_adresa) REFERENCES ADRESA(cod_adresa)
);

-- AGENT
CREATE TABLE AGENT (
    cod_personal NUMBER(5) PRIMARY KEY,
    cod_job NUMBER(5) NOT NULL,
    CONSTRAINT fk_agent_personal FOREIGN KEY (cod_personal) REFERENCES PERSONAL(cod_personal),
    CONSTRAINT fk_agent_job FOREIGN KEY (cod_job) REFERENCES JOB(cod_job)
);

-- MANAGER
CREATE TABLE MANAGER (
    cod_personal NUMBER(5) PRIMARY KEY,
    cod_departament NUMBER(5) NOT NULL UNIQUE,
    CONSTRAINT fk_manager_personal FOREIGN KEY (cod_personal) REFERENCES PERSONAL(cod_personal),
    CONSTRAINT fk_manager_departament FOREIGN KEY (cod_departament) REFERENCES DEPARTAMENT(cod_departament)
);

-- PERSOANA_CONTACT
CREATE TABLE PERSOANA_CONTACT (
    cod_persoana_contact NUMBER(5) PRIMARY KEY,
    nume VARCHAR2(25) NOT NULL,
    prenume VARCHAR2(50) NOT NULL,
    mail VARCHAR2(50) UNIQUE NOT NULL,
    numar_telefon VARCHAR2(25) UNIQUE NOT NULL
);

-- CONTRIBUITOR
CREATE TABLE CONTRIBUITOR (
    cod_contribuitor NUMBER(5) PRIMARY KEY,
    tip_contribuitor VARCHAR2(10) NOT NULL CHECK (tip_contribuitor IN ('artist', 'sponsor'))
);

-- SPONSOR
CREATE TABLE SPONSOR (
    cod_contribuitor NUMBER(5) PRIMARY KEY,
    nume_sponsor VARCHAR2(25) NOT NULL UNIQUE,
    CONSTRAINT fk_sponsor_contribuitor FOREIGN KEY (cod_contribuitor) REFERENCES CONTRIBUITOR(cod_contribuitor)
);

-- ARTIST
CREATE TABLE ARTIST (
    cod_contribuitor NUMBER(5) PRIMARY KEY,
    nume VARCHAR2(25) NOT NULL,
    prenume VARCHAR2(50) NOT NULL,
    nume_de_scena VARCHAR2(25) UNIQUE,
    CONSTRAINT fk_artist_contribuitor FOREIGN KEY (cod_contribuitor) REFERENCES CONTRIBUITOR(cod_contribuitor)
);

-- CONTRACT
CREATE TABLE CONTRACT (
    cod_contract NUMBER(5) PRIMARY KEY,
    valoare NUMBER(15,2) NOT NULL CHECK (valoare > 0),
    data_semnarii DATE DEFAULT SYSDATE NOT NULL,
    cod_persoana_contact NUMBER(5) NOT NULL,
    cod_personal NUMBER(5) NOT NULL,
    cod_contribuitor NUMBER(5) UNIQUE NOT NULL,
    CONSTRAINT fk_contract_contribuitor FOREIGN KEY (cod_contribuitor) REFERENCES CONTRIBUITOR(cod_contribuitor),
    CONSTRAINT fk_contract_persoana_contact FOREIGN KEY (cod_persoana_contact) REFERENCES PERSOANA_CONTACT(cod_persoana_contact),
    CONSTRAINT fk_contract_personal FOREIGN KEY (cod_personal) REFERENCES PERSONAL(cod_personal)
);

-- SCENA
CREATE TABLE SCENA (
    cod_scena NUMBER(5) PRIMARY KEY,
    nume_scena VARCHAR2(25) UNIQUE NOT NULL,
    capacitate NUMBER(10) DEFAULT 10000 NOT NULL CHECK (capacitate > 2000),
    cod_adresa NUMBER(15) UNIQUE NOT NULL,
    CONSTRAINT fk_scena_adresa FOREIGN KEY (cod_adresa) REFERENCES ADRESA(cod_adresa)
);

-- PARTICIPANT
CREATE TABLE PARTICIPANT(
    cod_participant NUMBER(5) PRIMARY KEY,
    nume VARCHAR2(25) NOT NULL,
    prenume VARCHAR2(50) NOT NULL,
    data_nasterii DATE NOT NULL,
    cod_adresa NUMBER(15) NOT NULL,
    numar_telefon VARCHAR2(25) NOT NULL UNIQUE,
    mail VARCHAR2(50) NOT NULL UNIQUE,
    CONSTRAINT fk_participant_adresa FOREIGN KEY(cod_adresa) REFERENCES ADRESA(cod_adresa)
);

-- BILET
CREATE TABLE BILET (
    cod_bilet NUMBER(5) PRIMARY KEY,
    tip_bilet VARCHAR2(15) NOT NULL CHECK (tip_bilet IN ('Acces General', 'VIP General', 'VIP Ultra')),
    verificat CHAR(1) DEFAULT 'F' NOT NULL CHECK (verificat IN ('A', 'F')),
    cod_participant NUMBER(5) NOT NULL UNIQUE,
    cod_personal NUMBER(5),
    CONSTRAINT fk_bilet_participant FOREIGN KEY (cod_participant) REFERENCES PARTICIPANT(cod_participant),
    CONSTRAINT fk_bilet_personal FOREIGN KEY (cod_personal) REFERENCES PERSONAL(cod_personal)
);

-- BRATARA
CREATE TABLE BRATARA (
    cod_bratara NUMBER(5) PRIMARY KEY,
    sold_bratara NUMBER(10,2) DEFAULT 0 NOT NULL CHECK (sold_bratara >= 0),
    cod_bilet NUMBER(5) NOT NULL UNIQUE,
    CONSTRAINT fk_bratara_bilet FOREIGN KEY (cod_bilet) REFERENCES BILET(cod_bilet)
);

-- INCARCA
CREATE TABLE INCARCA (
    cod_bratara NUMBER(5),
    cod_personal NUMBER(5),
    data_ora TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    suma NUMBER(10, 2) NOT NULL CHECK(suma > 0),
    CONSTRAINT pk_incarca PRIMARY KEY(cod_bratara, cod_personal, data_ora),
    CONSTRAINT fk_incarca_bratara FOREIGN KEY (cod_bratara) REFERENCES BRATARA(cod_bratara),
    CONSTRAINT fk_incarca_personal FOREIGN KEY (cod_personal) REFERENCES PERSONAL(cod_personal)
);

-- INSULA
CREATE TABLE INSULA (
    cod_insula NUMBER(5) PRIMARY KEY,
    sold_insula NUMBER(10,2) DEFAULT 0 NOT NULL CHECK (sold_insula >= 0),
    cod_contribuitor NUMBER(5) NOT NULL,
    cod_adresa NUMBER(15) NOT NULL UNIQUE,
    CONSTRAINT fk_insula_sponsor FOREIGN KEY (cod_contribuitor) REFERENCES SPONSOR(cod_contribuitor),
    CONSTRAINT fk_insula_adresa FOREIGN KEY (cod_adresa) REFERENCES ADRESA(cod_adresa)
);

-- PRODUS
CREATE TABLE PRODUS (
    cod_produs NUMBER(5) PRIMARY KEY,
    nume_produs VARCHAR2(50) NOT NULL UNIQUE,
    pret NUMBER(10,2) NOT NULL CHECK (pret > 0)
);

-- ARE_STOC
CREATE TABLE ARE_STOC(
    cod_insula NUMBER(5),
    cod_produs NUMBER(5),
    cantitate_disponibila NUMBER(5) NOT NULL CHECK(cantitate_disponibila >= 0),
    CONSTRAINT pk_are_stoc PRIMARY KEY(cod_insula, cod_produs),
    CONSTRAINT fk_are_stoc_insula FOREIGN KEY(cod_insula) REFERENCES INSULA(cod_insula),
    CONSTRAINT fk_are_stoc_produs FOREIGN KEY(cod_produs) REFERENCES PRODUS(cod_produs)
);

-- REPREZENTANT
CREATE TABLE REPREZENTANT (
    cod_reprezentant NUMBER(5) PRIMARY KEY,
    nume VARCHAR2(25) NOT NULL,
    prenume VARCHAR2(50) NOT NULL,
    cod_insula NUMBER(5) NOT NULL,
    CONSTRAINT fk_repr_insula FOREIGN KEY (cod_insula) REFERENCES INSULA(cod_insula)
);

-- TRANZACTIE
CREATE TABLE TRANZACTIE (
    cod_tranzactie NUMBER(5) PRIMARY KEY,
    cod_bratara NUMBER(5) NOT NULL,
    cod_reprezentant NUMBER(5) NOT NULL,
    data_ora TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    suma NUMBER(10,2) NOT NULL CHECK (suma > 0),
    CONSTRAINT fk_tranz_bratara FOREIGN KEY (cod_bratara) REFERENCES BRATARA(cod_bratara),
    CONSTRAINT fk_tranz_reprezentant FOREIGN KEY (cod_reprezentant) REFERENCES REPREZENTANT(cod_reprezentant)
);

-- DETALII
CREATE TABLE DETALII (
    cod_tranzactie NUMBER(5),
    cod_produs NUMBER(5),
    cantitate NUMBER(5) NOT NULL CHECK (cantitate > 0),
    CONSTRAINT pk_detalii PRIMARY KEY (cod_tranzactie, cod_produs),
    CONSTRAINT fk_detalii_tranz FOREIGN KEY (cod_tranzactie) REFERENCES TRANZACTIE(cod_tranzactie),
    CONSTRAINT fk_detalii_produs FOREIGN KEY (cod_produs) REFERENCES PRODUS(cod_produs)
);

-- PROGRAM
CREATE TABLE PROGRAM (
    cod_eveniment NUMBER(5) PRIMARY KEY,
    cod_contribuitor NUMBER(5) NOT NULL,
    cod_scena NUMBER(5) NOT NULL,
    inceput DATE NOT NULL,
    sfarsit DATE NOT NULL,
    CONSTRAINT fk_program_scena FOREIGN KEY (cod_scena) REFERENCES SCENA(cod_scena),
    CONSTRAINT fk_program_contribuitor FOREIGN KEY (cod_contribuitor) REFERENCES CONTRIBUITOR(cod_contribuitor),
    CONSTRAINT ck_durata_event CHECK (sfarsit > inceput)
);

-- seq_cod_tara
CREATE SEQUENCE seq_cod_tara
START WITH 10
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- seq_cod_regiune
CREATE SEQUENCE seq_cod_regiune
START WITH 10
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- seq_cod_oras
CREATE SEQUENCE seq_cod_oras
START WITH 100
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- seq_cod_adresa
CREATE SEQUENCE seq_cod_adresa
START WITH 1000
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- seq_cod_departament
CREATE SEQUENCE seq_cod_departament
START WITH 10
INCREMENT BY 10
NOCACHE
NOCYCLE;

-- seq_cod_job
CREATE SEQUENCE seq_cod_job
START WITH 100
INCREMENT BY 10
NOCACHE
NOCYCLE;

-- seq_cod_personal
CREATE SEQUENCE seq_cod_personal
START WITH 100
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- seq_cod_persoana_contact
CREATE SEQUENCE seq_cod_persoana_contact
START WITH 100
INCREMENT BY 10
NOCACHE
NOCYCLE;

-- seq_cod_contribuitor
CREATE SEQUENCE seq_cod_contribuitor
START WITH 10
INCREMENT BY 10
NOCACHE
NOCYCLE;

-- seq_cod_contract
CREATE SEQUENCE seq_cod_contract
START WITH 100
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- seq_cod_scena
CREATE SEQUENCE seq_cod_scena
START WITH 10
INCREMENT BY 10
NOCACHE
NOCYCLE;

-- seq_cod_participant
CREATE SEQUENCE seq_cod_participant
START WITH 1000
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- seq_cod_bilet
CREATE SEQUENCE seq_cod_bilet
START WITH 100
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- seq_cod_bratara
CREATE SEQUENCE seq_cod_bratara
START WITH 10
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- seq_cod_insula
CREATE SEQUENCE seq_cod_insula
START WITH 100
INCREMENT BY 10
NOCACHE
NOCYCLE;

-- seq_cod_produs
CREATE SEQUENCE seq_cod_produs
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- seq_cod_reprezentant
CREATE SEQUENCE seq_cod_reprezentant
START WITH 10
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- seq_cod_eveniment
CREATE SEQUENCE seq_cod_eveniment
START WITH 10
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- seq_cod_tranzactie
CREATE SEQUENCE seq_cod_tranzactie
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- SUSPICIUNE
CREATE TABLE SUSPICIUNE (
    cod_suspiciune NUMBER PRIMARY KEY,
    nume_utilizator VARCHAR2(25),
    data_ora TIMESTAMP,
    motiv VARCHAR2(200)
);

-- seq_suspiciune
CREATE SEQUENCE seq_suspiciune
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- MENTENANTA
CREATE TABLE MENTENANTA(
    cod_mentenanta NUMBER PRIMARY KEY,
    data_inceput TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    data_sfarsit TIMESTAMP,
    initiator VARCHAR2(25),
    observatii VARCHAR2(200)
);

-- seq_mentenanta
CREATE SEQUENCE seq_mentenanta
START WITH 1
NOCACHE;
