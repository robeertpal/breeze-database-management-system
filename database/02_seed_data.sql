-- Date initiale si cele cinci tranzactii demonstrative din popularea originala.
-- Se ruleaza DUPA 04 si 05, INAINTE de 03: soldurile initiale sunt actualizate manual aici.

SET DEFINE OFF
SET SQLBLANKLINES ON
SET SERVEROUTPUT ON
WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK

INSERT INTO TARA (cod_tara, nume_tara)
VALUES (seq_cod_tara.NEXTVAL, 'România');

INSERT INTO TARA (cod_tara, nume_tara)
VALUES (seq_cod_tara.NEXTVAL, 'Ungaria');

INSERT INTO TARA (cod_tara, nume_tara)
VALUES (seq_cod_tara.NEXTVAL, 'Statele Unite ale Americii');

INSERT INTO TARA (cod_tara, nume_tara)
VALUES (seq_cod_tara.NEXTVAL, 'Italia');

INSERT INTO TARA (cod_tara, nume_tara)
VALUES (seq_cod_tara.NEXTVAL, 'Maldive');

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Alba', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Arad', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Argeș', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Bacău', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Bihor', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Bistrița-Năsăud', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Botoșani', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Brăila', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Brașov', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'București', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Buzău', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Călărași', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Caraș-Severin', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Cluj', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Constanța', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Covasna', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Dâmbovița', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Dolj', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Galați', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Giurgiu', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Gorj', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Harghita', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Hunedoara', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Ialomița', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Iași', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Ilfov', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Maramureș', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Mehedinți', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Mureș', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Neamț', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Olt', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Prahova', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Satu Mare', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Sălaj', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Sibiu', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Suceava', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Teleorman', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Timiș', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Tulcea', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Vaslui', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Vâlcea', 10);

INSERT INTO REGIUNE (cod_regiune, nume_regiune, cod_tara)
VALUES (seq_cod_regiune.NEXTVAL, 'Vrancea', 10);

INSERT INTO ORAS (cod_oras, nume_oras, cod_regiune)
VALUES (seq_cod_oras.NEXTVAL, 'Târgu Mureș', 38);

INSERT INTO ORAS (cod_oras, nume_oras, cod_regiune)
VALUES (seq_cod_oras.NEXTVAL, 'Cluj-Napoca', 23);

INSERT INTO ORAS (cod_oras, nume_oras, cod_regiune)
VALUES (seq_cod_oras.NEXTVAL, 'București', 19);

INSERT INTO ORAS (cod_oras, nume_oras, cod_regiune)
VALUES (seq_cod_oras.NEXTVAL, 'Galați', 28);

INSERT INTO ORAS (cod_oras, nume_oras, cod_regiune)
VALUES (seq_cod_oras.NEXTVAL, 'Constanța', 24);

INSERT INTO ORAS (cod_oras, nume_oras, cod_regiune)
VALUES (seq_cod_oras.NEXTVAL, 'Brașov', 18);

INSERT INTO ORAS (cod_oras, nume_oras, cod_regiune)
VALUES (seq_cod_oras.NEXTVAL, 'Sovata', 38);

INSERT INTO ORAS (cod_oras, nume_oras, cod_regiune)
VALUES (seq_cod_oras.NEXTVAL, 'Craiova', 27);

INSERT INTO ORAS (cod_oras, nume_oras, cod_regiune)
VALUES (seq_cod_oras.NEXTVAL, 'Ploiești', 41);

INSERT INTO ORAS (cod_oras, nume_oras, cod_regiune)
VALUES (seq_cod_oras.NEXTVAL, 'Alba Iulia', 10);

INSERT INTO ORAS (cod_oras, nume_oras, cod_regiune)
VALUES (seq_cod_oras.NEXTVAL, 'Medgidia', 24);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Lacul Roșu', '7', 101);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Bulevardul Eroilor', '36', 103);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Aleea Stadionului', '23', 108);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Secerei', '24A', 100);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Nicolae Bălcescu', '108C', 103);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Sebesului', '109', 102);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Borzesti', '87D', 103);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Semanatorilor', '89', 105);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Secerei', '32', 107);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Bulevardul 1 Mai', '76', 101);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Prieteniei', '50', 105);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Secerei', '75', 103);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Bulevardul Eroilor', '98', 101);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Lacul Roșu', '42', 105);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Brăila', '19', 104);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Bradului', '63D', 108);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Bucegi', '57', 108);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Secerei', '9', 103);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Bulevardul 1 Mai', '17C', 104);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Brăila', '102', 107);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Lacul Roșu', '37', 107);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Bulevardul Eroilor', '68', 108);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Bulevardul Cetăţii', '103', 109);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Borzesti', '127A', 108);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Semanatorilor', '41', 102);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Bulevardul Cetăţii', '17', 109);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Prieteniei', '65', 107);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Sebesului', '69', 101);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Iuliu Maniu', '76', 101);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Bulevardul Pandurilor', '68', 100);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Bradului', '28', 108);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Bujorului', '51B', 108);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Nicolae Bălcescu', '1', 108);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Calea Sighişoarei', '29', 100);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Bujorului', '15A', 103);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Selimbar', '18', 107);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Nicolae Bălcescu', '33', 102);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Nicolae Bălcescu', '68', 102);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Prieteniei', '55', 106);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Bulevardul Pandurilor', '80', 103);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Aleea Stadionului', '113', 105);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Bulevardul Pandurilor', '64C', 101);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Sebesului', '59', 109);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Sebesului', '16A', 101);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Iuliu Maniu', '61', 101);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Calea Sighişoarei', '34', 103);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Înfrățirii', '122D', 109);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Bulevardul Cetăţii', '25D', 103);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Republicii', '106', 106);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Bulevardul Pandurilor', '26C', 100);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Semanatorilor', '50D', 103);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Aleea Stadionului', '71B', 101);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Aleea Stadionului', '109A', 101);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Aleea Stadionului', '7', 101);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Aleea Stadionului', '115', 101);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Aleea Stadionului', '109', 101);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Aleea Stadionului', '87D', 101);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Aleea Stadionului', '89', 101);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Aleea Stadionului', '32', 101);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Aleea Stadionului', '76', 101);

INSERT INTO ADRESA (cod_adresa, strada, numar, cod_oras)
VALUES (seq_cod_adresa.NEXTVAL, 'Aleea Stadionului', '81', 101);

INSERT INTO DEPARTAMENT (cod_departament, nume_departament, cod_adresa)
VALUES (seq_cod_departament.NEXTVAL, 'Securitate', 1002);

INSERT INTO DEPARTAMENT (cod_departament, nume_departament, cod_adresa)
VALUES (seq_cod_departament.NEXTVAL, 'Acces', 1002);

INSERT INTO DEPARTAMENT (cod_departament, nume_departament, cod_adresa)
VALUES (seq_cod_departament.NEXTVAL, 'Marketing', 1056);

INSERT INTO DEPARTAMENT (cod_departament, nume_departament, cod_adresa)
VALUES (seq_cod_departament.NEXTVAL, 'Brățări', 1055);

INSERT INTO DEPARTAMENT (cod_departament, nume_departament, cod_adresa)
VALUES (seq_cod_departament.NEXTVAL, 'Resurse Umane', 1057);

INSERT INTO JOB (cod_job, nume_job, cod_departament)
VALUES (seq_cod_job.NEXTVAL, 'Responsabil de securitate', 10);

INSERT INTO JOB (cod_job, nume_job, cod_departament)
VALUES (seq_cod_job.NEXTVAL, 'Responsabil de sisteme video', 10);

INSERT INTO JOB (cod_job, nume_job, cod_departament)
VALUES (seq_cod_job.NEXTVAL, 'Verificarea biletelor', 20);

INSERT INTO JOB (cod_job, nume_job, cod_departament)
VALUES (seq_cod_job.NEXTVAL, 'Agent VIP', 20);

INSERT INTO JOB (cod_job, nume_job, cod_departament)
VALUES (seq_cod_job.NEXTVAL, 'Creator de conținut', 30);

INSERT INTO JOB (cod_job, nume_job, cod_departament)
VALUES (seq_cod_job.NEXTVAL, 'Responsabil de social-media', 30);

INSERT INTO JOB (cod_job, nume_job, cod_departament)
VALUES (seq_cod_job.NEXTVAL, 'Cameraman', 30);

INSERT INTO JOB (cod_job, nume_job, cod_departament)
VALUES (seq_cod_job.NEXTVAL, 'Editor foto și video', 30);

INSERT INTO JOB (cod_job, nume_job, cod_departament)
VALUES (seq_cod_job.NEXTVAL, 'Încărcare brățări', 40);

INSERT INTO JOB (cod_job, nume_job, cod_departament)
VALUES (seq_cod_job.NEXTVAL, 'Suport brățări', 40);

INSERT INTO JOB (cod_job, nume_job, cod_departament)
VALUES (seq_cod_job.NEXTVAL, 'Suport VIP', 50);

INSERT INTO JOB (cod_job, nume_job, cod_departament)
VALUES (seq_cod_job.NEXTVAL, 'Consultant Juridic', 50);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'manager', 'Văidean', 'Robert', 1009, 'bogdan.vaidean@breeze.com', '+40 728 381 233', 7086.34, DATE '1966-05-04', DATE '2019-01-19');
INSERT INTO MANAGER (cod_personal, cod_departament)
VALUES (seq_cod_personal.CURRVAL, 40);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'manager', 'Farcaș', 'Bogdan', 1033, 'bogdan.farcas@breeze.com', '+40 717 281 122', 9586.17, DATE '1996-06-17', DATE '2024-02-11');
INSERT INTO MANAGER (cod_personal, cod_departament)
VALUES (seq_cod_personal.CURRVAL, 20);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'manager', 'Todoran', 'Sebastian - Claudiu', 1029, 'bogdan.todoran@breeze.com', '+40 794 117 232', 3555.25, DATE '2001-02-23', DATE '2020-12-07');
INSERT INTO MANAGER (cod_personal, cod_departament)
VALUES (seq_cod_personal.CURRVAL, 30);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'manager', 'Piluț', 'Filip', 1018, 'filip.todoran@breeze.com', '+40 728 177 901', 4368.80, DATE '1982-01-16', DATE '2019-02-01');
INSERT INTO MANAGER (cod_personal, cod_departament)
VALUES (seq_cod_personal.CURRVAL, 50);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'manager', 'Matache', 'Viorel', 1039, 'viorel.matache@breeze.com', '+40 727 285 663', 8057.94, DATE '1981-12-24', DATE '2018-11-19');
INSERT INTO MANAGER (cod_personal, cod_departament)
VALUES (seq_cod_personal.CURRVAL, 10);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Mureșan', 'Alex - Eduard', 1042, 'alexeduard.muresan@breeze.com', '+40 724 283 283', 9488.86, DATE '1967-01-21', DATE '2025-06-01');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 130);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Belgea', 'Lidia', 1015, 'lidia.belgea@breeze.com', '+40 799 238 194', 8903.32, DATE '1981-05-14', DATE '2019-10-29');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 150);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Matache', 'Beatrice', 1044, 'beatrice.matache@breeze.com', '+40 737 281 965', 4954.69, DATE '1997-09-16', DATE '2020-09-29');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 120);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Cenan', 'Andreea', 1018, 'andreea.cenan@breeze.com', '+40 783 182 180', 10664.24, DATE '1999-10-23', DATE '2018-08-18');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 130);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Eremia', 'Natalia', 1026, 'natalia.eremia@breeze.com', '+40 717 180 563', 10949.13, DATE '1979-02-12', DATE '2020-05-20');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 170);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Nedelcu', 'Dragoș', 1010, 'dragos.nedelcu@breeze.com', '+40 728 188 919', 8271.63, DATE '1976-10-14', DATE '2024-07-22');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 160);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Trifan', 'Robert', 1024, 'robert.trifan@breeze.com', '+40 731 182 265', 4272.74, DATE '1967-02-11', DATE '2019-03-26');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 120);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Gherendi', 'Cristian', 1045, 'cristian.gherendi@breeze.com', '+40 766 271 128', 6743.77, DATE '1985-12-30', DATE '2023-12-08');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 140);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Mureșan', 'Cristina', 1045, 'cristina.muresan@breeze.com', '+40 714 164 232', 10033.09, DATE '1980-04-05', DATE '2019-04-02');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 140);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Todoran', 'Cristian', 1030, 'cristian.todoran@breeze.com', '+40 798 271 772', 5018.55, DATE '1969-10-10', DATE '2025-01-05');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 140);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Gherendi', 'Sebastian', 1039, 'sebastian.gherendi@breeze.com', '+40 701 283 283', 4873.18, DATE '1999-12-06', DATE '2023-12-13');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 100);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Prodan', 'Natalia', 1032, 'natalia.prodan@breeze.com', '+40 701 823 183', 11875.23, DATE '2001-03-11', DATE '2022-08-21');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 130);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Eremia', 'Mihaela', 1037, 'mihaela.eremia@breeze.com', '+40 718 272 381', 10436.20, DATE '1999-02-13', DATE '2023-12-22');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 120);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Echim', 'Andrei', 1036, 'andrei.echim@breeze.com', '+40 721 281 219', 8656.05, DATE '1974-07-03', DATE '2024-01-18');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 130);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Belgea', 'Robert', 1044, 'robert.belgea@breeze.com', '+40 727 299 900', 4528.54, DATE '1975-01-30', DATE '2018-09-20');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 150);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Pal', 'Cezar', 1036, 'cezar.pal@breeze.com', '+40 718 277 101', 4103.45, DATE '1993-04-23', DATE '2018-08-30');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 130);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Șerbănaț', 'Alexandra', 1022, 'alexandra.serbanat@breeze.com', '+40 718 318 117', 9186.31, DATE '1974-08-12', DATE '2024-01-18');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 120);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Trifan', 'Larisa', 1031, 'larisa.trifan@breeze.com', '+40 735 261 182', 5118.49, DATE '1969-05-08', DATE '2025-05-23');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 160);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Matache', 'Alin - Ștefan', 1027, 'alinstefan.matache@breeze.com', '+40 743 593 293', 11865.40, DATE '1969-06-01', DATE '2018-09-06');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 160);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Rimes', 'Corina', 1016, 'corina.rimes@breeze.com', '+40 708 681 197', 4691.56, DATE '1973-03-26', DATE '2021-02-14');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 170);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Văidean', 'Alina', 1029, 'alina.vaidean@breeze.com', '+40 718 281 197', 11993.90, DATE '1965-08-30', DATE '2019-01-18');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 130);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Bădulescu', 'Eduard', 1032, 'eduard.badulescu@breeze.com', '+40 799 172 512', 11170.77, DATE '1972-05-21', DATE '2022-04-02');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 100);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Nedelcu', 'Matei', 1030, 'matei.nedelcu@breeze.com', '+40 728 271 228', 11961.09, DATE '1989-12-06', DATE '2025-06-04');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 170);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Echim', 'Lucia', 1019, 'lucia.echim@breeze.com', '+40 728 505 392', 8108.66, DATE '1998-07-21', DATE '2021-07-08');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 100);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Eremia', 'Cezar', 1031, 'cezar.eremia@breeze.com', '+40 727 228 928', 11666.62, DATE '1968-08-05', DATE '2020-02-01');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 110);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Ivone', 'Lidia', 1010, 'lidia.ivone@breeze.com', '+40 742 277 918', 8407.50, DATE '1996-08-09', DATE '2018-10-12');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 180);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Ceușan', 'Diana', 1021, 'diana.ceusan@breeze.com', '+40 719 295 127', 6731.08, DATE '1985-05-04', DATE '2025-02-16');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 200);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Mureșan', 'Dan', 1029, 'dan.muresan@breeze.com', '+40 733 364 280', 9008.30, DATE '1992-04-29', DATE '2025-02-13');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 190);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Moga', 'Cristian', 1000, 'cristian.moga@breeze.com', '+40 769 281 283', 8234.08, DATE '1995-09-17', DATE '2021-08-21');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 180);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Ceușan', 'Zoe', 1023, 'zoe.ceusan@breeze.com', '+40 729 775 432', 5293.36, DATE '1990-06-11', DATE '2021-07-12');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 190);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Ardeleanu', 'Robert', 1027, 'robert.ardeleanu@breeze.com', '+40 728 288 074', 5596.34, DATE '1990-03-08', DATE '2024-01-17');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 200);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Bogătean', 'Tiago', 1048, 'tiago.bogatean@breeze.com', '+40 718 232 182', 7830.98, DATE '1969-01-29', DATE '2018-07-12');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 180);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Piluț', 'Cristina', 1031, 'cristina.pilut@breeze.com', '+40 728 382 831', 6743.77, DATE '1985-12-30', DATE '2023-12-08');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 200);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Mărginean', 'Daria', 1035, 'daria.marginean@breeze.com', '+40 796 273 120', 10033.09, DATE '1980-04-05', DATE '2019-04-02');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 210);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Bogătean', 'Cristian', 1000, 'cristian.bogatean@breeze.com', '+40 727 377 181', 5018.55, DATE '1969-10-10', DATE '2025-01-05');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 200);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Prodan', 'Andrei - Petru', 1045, 'andreipetru.prodan@breeze.com', '+40 721 283 220', 11307.20, DATE '1991-11-14', DATE '2021-08-20');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 210);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Șerbănaț', 'Roxana', 1045, 'roxana.serbanat@breeze.com', '+40 722 654 172', 10963.08, DATE '1968-07-14', DATE '2018-12-17');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 210);

INSERT INTO PERSONAL (cod_personal, tip_personal, nume, prenume, cod_adresa, mail, numar_telefon, salariu, data_nasterii, data_angajarii)
VALUES (seq_cod_personal.NEXTVAL, 'agent', 'Bădulescu', 'Carla', 1026, 'carla.badulescu@breeze.com', '+40 791 371 277', 11548.21, DATE '1972-05-29', DATE '2020-12-21');
INSERT INTO AGENT (cod_personal, cod_job)
VALUES (seq_cod_personal.CURRVAL, 210);

INSERT INTO PERSOANA_CONTACT
VALUES (seq_cod_persoana_contact.NEXTVAL, 'Pop', 'Alexandru', 'alexandrupop28@outlook.com', '+40 781 283 182');

INSERT INTO PERSOANA_CONTACT
VALUES (seq_cod_persoana_contact.NEXTVAL, 'Moldovan', 'Gabriel', 'moldovangabriel@yahoo.com', '+40 783 172 188');

INSERT INTO PERSOANA_CONTACT
VALUES (seq_cod_persoana_contact.NEXTVAL, 'Neagu', 'David', 'neeagudavid@gmail.com', '+40 792 288 987');

INSERT INTO PERSOANA_CONTACT
VALUES (seq_cod_persoana_contact.NEXTVAL, 'Șerbănaț', 'Andreea', 'andreea.sbn@outlook.com', '+40 772 183 192');

INSERT INTO PERSOANA_CONTACT
VALUES (seq_cod_persoana_contact.NEXTVAL, 'Eremia', 'Alexandra', 'eremiaalexandraa20@yahoo.com', '+40 782 881 196');

INSERT INTO PERSOANA_CONTACT
VALUES (seq_cod_persoana_contact.NEXTVAL, 'Mureșan', 'Alexandru', 'alexmuresann@gmail.com', '+40 783 182 288');

INSERT INTO PERSOANA_CONTACT
VALUES (seq_cod_persoana_contact.NEXTVAL, 'Ciobanu', 'Walter', 'walteer91@icloud.com', '+40 752 173 380');

INSERT INTO PERSOANA_CONTACT
VALUES (seq_cod_persoana_contact.NEXTVAL, 'Văidean', 'Crina', 'vdncrinaa99@icloud.com', '+40 728 177 198');

INSERT INTO PERSOANA_CONTACT
VALUES (seq_cod_persoana_contact.NEXTVAL, 'Echim', 'Filip', 'echim.filip2@yahoo.com', '+40 728 591 391');

INSERT INTO PERSOANA_CONTACT
VALUES (seq_cod_persoana_contact.NEXTVAL, 'Prodan', 'Alessia', 'prodanalessia@icloud.com', '+40 726 194 183');

INSERT INTO PERSOANA_CONTACT
VALUES (seq_cod_persoana_contact.NEXTVAL, 'Badea', 'Cristina', 'cristina.bd@yahoo.com', '+40 786 173 182');

INSERT INTO PERSOANA_CONTACT
VALUES (seq_cod_persoana_contact.NEXTVAL, 'Belgea', 'Alexandru', 'balexandru2000@yahoo.com', '+40 717 282 196');

INSERT INTO CONTRIBUITOR
VALUES (seq_cod_contribuitor.NEXTVAL, 'sponsor');
INSERT INTO SPONSOR
VALUES (seq_cod_contribuitor.CURRVAL, 'Coca-Cola');

INSERT INTO CONTRIBUITOR
VALUES (seq_cod_contribuitor.NEXTVAL, 'sponsor');
INSERT INTO SPONSOR
VALUES (seq_cod_contribuitor.CURRVAL, 'IQOS');

INSERT INTO CONTRIBUITOR
VALUES (seq_cod_contribuitor.NEXTVAL, 'sponsor');
INSERT INTO SPONSOR
VALUES (seq_cod_contribuitor.CURRVAL, 'eMAG');

INSERT INTO CONTRIBUITOR
VALUES (seq_cod_contribuitor.NEXTVAL, 'sponsor');
INSERT INTO SPONSOR
VALUES (seq_cod_contribuitor.CURRVAL, 'Samsung');

INSERT INTO CONTRIBUITOR
VALUES (seq_cod_contribuitor.NEXTVAL, 'sponsor');
INSERT INTO SPONSOR
VALUES (seq_cod_contribuitor.CURRVAL, 'McDoanls');

INSERT INTO CONTRIBUITOR
VALUES (seq_cod_contribuitor.NEXTVAL, 'artist');
INSERT INTO ARTIST
VALUES (seq_cod_contribuitor.CURRVAL, 'Rimes', 'Irina', NULL);

INSERT INTO CONTRIBUITOR
VALUES (seq_cod_contribuitor.NEXTVAL, 'artist');
INSERT INTO ARTIST
VALUES (seq_cod_contribuitor.CURRVAL, 'Roabeș', 'Denis', 'The Motans');

INSERT INTO CONTRIBUITOR
VALUES (seq_cod_contribuitor.NEXTVAL, 'artist');
INSERT INTO ARTIST
VALUES (seq_cod_contribuitor.CURRVAL, 'Matache', 'Delia', NULL);

INSERT INTO CONTRIBUITOR
VALUES (seq_cod_contribuitor.NEXTVAL, 'artist');
INSERT INTO ARTIST
VALUES (seq_cod_contribuitor.CURRVAL, 'Ghinea', 'Alex', 'Nouă Unșpe');

INSERT INTO CONTRIBUITOR
VALUES (seq_cod_contribuitor.NEXTVAL, 'artist');
INSERT INTO ARTIST
VALUES (seq_cod_contribuitor.CURRVAL, 'Alexandra', 'Apostoleanu', 'INNA');

INSERT INTO CONTRIBUITOR
VALUES (seq_cod_contribuitor.NEXTVAL, 'artist');
INSERT INTO ARTIST
VALUES (seq_cod_contribuitor.CURRVAL, 'Tiberiu', 'Andrei', 'Smiley');

INSERT INTO CONTRIBUITOR
VALUES (seq_cod_contribuitor.NEXTVAL, 'artist');
INSERT INTO ARTIST
VALUES (seq_cod_contribuitor.CURRVAL, 'Măruță', 'Irina-Alexandra', 'Andra');

INSERT INTO CONTRIBUITOR
VALUES (seq_cod_contribuitor.NEXTVAL, 'artist');
INSERT INTO ARTIST
VALUES (seq_cod_contribuitor.CURRVAL, 'Eremia', 'Alina', NULL);

INSERT INTO CONTRIBUITOR
VALUES (seq_cod_contribuitor.NEXTVAL, 'artist');
INSERT INTO ARTIST
VALUES (seq_cod_contribuitor.CURRVAL, 'Moldovan', 'Andreea-Ioana', 'AMI');

INSERT INTO CONTRIBUITOR
VALUES (seq_cod_contribuitor.NEXTVAL, 'artist');
INSERT INTO ARTIST
VALUES (seq_cod_contribuitor.CURRVAL, 'Buble', 'Lidia', NULL);

INSERT INTO CONTRIBUITOR
VALUES (seq_cod_contribuitor.NEXTVAL, 'artist');
INSERT INTO ARTIST
VALUES (seq_cod_contribuitor.CURRVAL, 'Donose', 'Felicia', 'Feli');

INSERT INTO CONTRACT
VALUES (seq_cod_contract.NEXTVAL, 10000, DATE '2025-02-01', 100, 103, 10);

INSERT INTO CONTRACT
VALUES (seq_cod_contract.NEXTVAL, 8000, DATE '2025-01-15', 110, 103, 20);

INSERT INTO CONTRACT
VALUES (seq_cod_contract.NEXTVAL, 15000, DATE '2025-01-20', 120, 102, 30);

INSERT INTO CONTRACT
VALUES (seq_cod_contract.NEXTVAL, 12000, DATE '2025-02-03', 130, 102, 40);

INSERT INTO CONTRACT
VALUES (seq_cod_contract.NEXTVAL, 9000, DATE '2025-02-10', 140, 103, 50);

INSERT INTO CONTRACT
VALUES (seq_cod_contract.NEXTVAL, 13500, DATE '2025-02-15', 150, 103, 60);

INSERT INTO CONTRACT
VALUES (seq_cod_contract.NEXTVAL, 11000, DATE '2025-02-17', 160, 102, 70);

INSERT INTO CONTRACT
VALUES (seq_cod_contract.NEXTVAL, 9500, DATE '2025-01-30', 170, 102, 80);

INSERT INTO CONTRACT
VALUES (seq_cod_contract.NEXTVAL, 12500, DATE '2025-02-18', 170, 103, 90);

INSERT INTO CONTRACT
VALUES (seq_cod_contract.NEXTVAL, 12000, DATE '2025-02-19', 180, 102, 100);

INSERT INTO CONTRACT
VALUES (seq_cod_contract.NEXTVAL, 9800, DATE '2025-02-20', 190, 103, 110);

INSERT INTO CONTRACT
VALUES (seq_cod_contract.NEXTVAL, 8750, DATE '2025-02-21', 200, 103, 120);

INSERT INTO CONTRACT
VALUES (seq_cod_contract.NEXTVAL, 12200, DATE '2025-02-22', 210, 102, 130);

INSERT INTO CONTRACT
VALUES (seq_cod_contract.NEXTVAL, 13300, DATE '2025-02-23', 200, 102, 140);

INSERT INTO CONTRACT
VALUES (seq_cod_contract.NEXTVAL, 9600, DATE '2025-02-23', 160, 103, 150);

INSERT INTO CONTRACT
VALUES (seq_cod_contract.NEXTVAL, 11000, DATE '2025-02-24', 190, 102, 160);

INSERT INTO SCENA
VALUES (seq_cod_scena.NEXTVAL, 'Principală', 10000, 1059);

INSERT INTO SCENA
VALUES (seq_cod_scena.NEXTVAL, 'BREEZE Arena', 7500, 1057);

INSERT INTO SCENA
VALUES (seq_cod_scena.NEXTVAL, 'Briza de Cluj', 3500, 1054);

INSERT INTO SCENA
VALUES (seq_cod_scena.NEXTVAL, 'AER', 5000, 1058);

INSERT INTO SCENA
VALUES (seq_cod_scena.NEXTVAL, 'VIP', 2500, 1053);

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Rimes', 'Mădălina', DATE '2003-04-07', 1001, '+40 727 172 188', 'madalinarimes@yahoo.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Farcaș', 'Cezar', DATE '1988-12-04', 1023, '+40 799 271 118', 'cezarfarcas@yahoo.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Prodan', 'Smaranda', DATE '1999-02-25', 1011, '+40 727 282 229', 'smarandaprodan@outlook.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Pal', 'Carla', DATE '1977-02-28', 1011, '+40 767 281 116', 'carlapal@icloud.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Drăgan', 'Corina', DATE '1974-02-28', 1033, '+40 782 466 283', 'corinadragan@outlook.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Pop', 'Andra', DATE '1990-08-11', 1026, '+40 716 281 188', 'andrapop@outlook.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Drăgănuţă', 'Larisa', DATE '1978-08-17', 1008, '+40 766 271 916', 'larisadraganuta@outlook.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Farcaș', 'Albert', DATE '1980-06-11', 1014, '+40 717 228 592', 'albertfarcas@outlook.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Mureșan', 'Dan', DATE '1985-12-08', 1022, '+40 744 472 182', 'danmuresan@icloud.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Moga', 'Cristian', DATE '1990-09-26', 1033, '+40 749 172 181', 'cristianmoga@outlook.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Echim', 'Bogdan', DATE '1971-06-10', 1041, '+40 764 173 288', 'bogdanechim@outlook.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Moldovan', 'Ștefania', DATE '1992-05-24', 1044, '+40 728 229 789', 'stefaniamoldovan@icloud.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Bursuc', 'Carmen', DATE '1996-03-22', 1020, '+40 796 284 194', 'carmenbursuc@icloud.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Ardeleanu', 'Lidia', DATE '2003-11-26', 1006, '+40 727 483 283', 'lidiaardeleanu@gmail.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Bădulescu', 'Andreea', DATE '1987-02-13', 1005, '+40 728 377 283', 'andreeabadulescu@yahoo.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Rimes', 'Daria', DATE '1994-02-01', 1024, '+40 742 272 193', 'dariarimes@gmail.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Mureșan', 'Dragoș', DATE '1970-02-23', 1035, '+40 773 183 299', 'dragosmuresan@yahoo.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Hadărău', 'Victor', DATE '1998-08-30', 1032, '+40 728 017 284', 'victorhadarau@icloud.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Pal', 'Darius', DATE '1984-07-16', 1004, '+40 735 289 285', 'dariuspal@outlook.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Moga', 'Georgeta', DATE '1980-10-21', 1038, '+40 768 296 113', 'georgetamoga@yahoo.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Matache', 'Liviu - Robert', DATE '1999-08-06', 1037, '+40 726 227 193', 'liviurobertmatache@gmail.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Moldovan', 'Rareș - Paul', DATE '1994-03-11', 1024, '+40 755 281 330', 'rarespaulmoldovan@outlook.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Pintecan', 'Tiago', DATE '1993-03-20', 1013, '+40 713 277 989', 'tiagopintecan@outlook.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Șerbănaț', 'Cezar', DATE '1994-11-06', 1047, '+40 718 288 199', 'cezarserbanat@yahoo.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Ceușan', 'Alina', DATE '1971-05-30', 1039, '+40 714 556 279', 'alinaceusan@gmail.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Moldovan', 'Gabriel', DATE '1975-12-08', 1035, '+40 755 273 183', 'gabrielmoldovan@gmail.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Achim', 'Lucia', DATE '1974-03-26', 1014, '+40 725 183 872', 'luciaachim@gmail.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Echim', 'Daria', DATE '1999-04-25', 1027, '+40 727 716 392', 'dariaechim@outlook.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Văidean', 'Mihaela', DATE '1978-08-06', 1018, '+40 788 183 199', 'mihaelavaidean@icloud.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Baciu', 'Dragoș', DATE '1981-03-16', 1015, '+40 719 278 388', 'dragosbaciu@yahoo.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Farcaș', 'Rareș - Paul', DATE '2003-10-21', 1025, '+40 726 277 193', 'rarespaulfarcas@icloud.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Zderea', 'Tiago', DATE '1972-08-18', 1031, '+40 726 117 288', 'tiagozderea@gmail.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Cherteș', 'Alin - Ștefan', DATE '2001-03-31', 1035, '+40 789 327 288', 'alinstefanchertes@outlook.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Moldovan', 'Georgeta', DATE '1995-12-25', 1007, '+40 752 273 118', 'georgetamoldovan@yahoo.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Echim', 'Cezar', DATE '1991-05-22', 1032, '+40 727 929 715', 'cezarechim@yahoo.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Trifan', 'Alina', DATE '1996-09-10', 1015, '+40 728 372 173', 'alinatrifan@icloud.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Pop', 'Sanda', DATE '1973-09-05', 1028, '+40 718 281 388', 'sandapop@outlook.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Moldovan', 'Iulia', DATE '2002-02-16', 1041, '+40 732 218 388', 'iuliamoldovan@outlook.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Vlad', 'Natalia', DATE '2003-09-23', 1015, '+40 701 273 288', 'nataliavlad@yahoo.com');

INSERT INTO PARTICIPANT
VALUES(seq_cod_participant.NEXTVAL, 'Bădulescu', 'Gabriel', DATE '1979-07-25', 1032, '+40 727 287 717', 'gabrielbadulescu@icloud.com');

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'Acces General', 'A', 1000, 133);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'Acces General', 'A', 1001, 130);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'Acces General', 'A', 1002, 132);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'Acces General', 'A', 1003, 130);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'Acces General', 'A', 1004, 130);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'Acces General', 'A', 1005, 132);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'Acces General', 'F', 1006, NULL);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'Acces General', 'A', 1007, 130);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'Acces General', 'F', 1008, NULL);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'VIP General', 'A', 1009, 134);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'Acces General', 'A', 1010, 133);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'Acces General', 'A', 1011, 134);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'Acces General', 'F', 1012, NULL);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'Acces General', 'A', 1013, 134);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'Acces General', 'A', 1014, 136);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'Acces General', 'A', 1015, 134);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'VIP General', 'A', 1016, 132);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'VIP General', 'F', 1017, NULL);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'Acces General', 'A', 1018, 132);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'VIP General', 'A', 1019, 134);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'VIP General', 'A', 1020, 132);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'Acces General', 'F', 1021, NULL);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'VIP General', 'A', 1022, 133);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'Acces General', 'A', 1023, 130);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'VIP General', 'A', 1024, 130);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'Acces General', 'A', 1025, 132);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'Acces General', 'A', 1026, 134);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'VIP Ultra', 'F', 1027, NULL);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'Acces General', 'A', 1028, 130);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'VIP General', 'F', 1029, NULL);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'Acces General', 'A', 1030, 133);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'Acces General', 'A', 1031, 136);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'VIP General', 'F', 1032, NULL);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'Acces General', 'A', 1033, 132);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'VIP General', 'A', 1034, 132);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'Acces General', 'F', 1035, NULL);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'Acces General', 'F', 1036, NULL);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'Acces General', 'A', 1037, 134);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'Acces General', 'A', 1038, 136);

INSERT INTO BILET
VALUES (seq_cod_bilet.NEXTVAL, 'VIP Ultra', 'A', 1039, 130);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 100);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 101);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 102);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 103);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 104);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 105);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 106);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 107);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 108);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 109);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 110);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 111);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 112);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 113);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 114);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 115);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 116);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 117);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 118);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 119);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 120);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 121);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 122);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 123);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 124);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 125);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 126);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 127);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 128);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 129);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 130);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 131);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 132);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 133);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 134);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 135);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 136);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 137);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 138);

INSERT INTO BRATARA (cod_bratara, sold_bratara, cod_bilet)
VALUES (seq_cod_bratara.NEXTVAL, 0, 139);

INSERT INTO INSULA
VALUES(seq_cod_insula.NEXTVAL, 0, 10, 1051);

INSERT INTO INSULA
VALUES(seq_cod_insula.NEXTVAL, 0, 20, 1057);

INSERT INTO INSULA
VALUES(seq_cod_insula.NEXTVAL, 0, 30, 1059);

INSERT INTO INSULA
VALUES(seq_cod_insula.NEXTVAL, 0, 40, 1058);

INSERT INTO INSULA
VALUES(seq_cod_insula.NEXTVAL, 0, 50, 1052);

INSERT INTO INSULA
VALUES(seq_cod_insula.NEXTVAL, 0, 20, 1053);

INSERT INTO INSULA
VALUES(seq_cod_insula.NEXTVAL, 0, 10, 1054);

INSERT INTO INSULA
VALUES(seq_cod_insula.NEXTVAL, 0, 20, 1055);

INSERT INTO INSULA
VALUES(seq_cod_insula.NEXTVAL, 0, 10, 1056);

INSERT INTO INSULA
VALUES(seq_cod_insula.NEXTVAL, 0, 30, 1060);

INSERT INTO PRODUS
VALUES (seq_cod_produs.NEXTVAL, 'Coca-Cola 500ml', 10.50);

INSERT INTO PRODUS
VALUES (seq_cod_produs.NEXTVAL, 'Coca-Cola Lămâie 500ml', 10.50);

INSERT INTO PRODUS
VALUES (seq_cod_produs.NEXTVAL, 'Coca-Cola Zero 500ml', 10.50);

INSERT INTO PRODUS
VALUES (seq_cod_produs.NEXTVAL, 'Fuzetea Lămâie 500ml', 10.50);

INSERT INTO PRODUS
VALUES (seq_cod_produs.NEXTVAL, 'Apă Plată Aqua Carpatica 500ml', 10.50);

INSERT INTO PRODUS
VALUES (seq_cod_produs.NEXTVAL, 'Apă Minerală Aqua Carpatica 500ml', 10.50);

INSERT INTO PRODUS
VALUES (seq_cod_produs.NEXTVAL, 'Starter Kit IQOS ILUMA i PRIME', 499.99);

INSERT INTO PRODUS
VALUES (seq_cod_produs.NEXTVAL, 'Starter Kit IQOS ILUMA i', 249.99);

INSERT INTO PRODUS
VALUES (seq_cod_produs.NEXTVAL, 'Starter Kit IQOS ILUMA i ONE', 99.99);

INSERT INTO PRODUS
VALUES (seq_cod_produs.NEXTVAL, 'TEREA Turquoise', 24.00);

INSERT INTO PRODUS
VALUES (seq_cod_produs.NEXTVAL, 'TEREA Blue', 24.00);

INSERT INTO PRODUS
VALUES(seq_cod_produs.NEXTVAL,'Powerbank 10.000mAh', 200.00);

INSERT INTO PRODUS
VALUES(seq_cod_produs.NEXTVAL,'Sticlă 750ml', 10.00);

INSERT INTO PRODUS
VALUES(seq_cod_produs.NEXTVAL,'Pelerină ploaie', 15.00);

INSERT INTO PRODUS
VALUES(seq_cod_produs.NEXTVAL,'Ochelari soare UV', 75.00);

INSERT INTO PRODUS
VALUES(seq_cod_produs.NEXTVAL,'Husă telefon rezistentă la apă', 25.00);

INSERT INTO PRODUS
VALUES(seq_cod_produs.NEXTVAL,'Rucsac festival', 40.00);

INSERT INTO PRODUS
VALUES (seq_cod_produs.NEXTVAL, 'Galaxy S25 Ultra', 4500.00);

INSERT INTO PRODUS
VALUES (seq_cod_produs.NEXTVAL, 'Galaxy Buds2 Pro', 900.00);

INSERT INTO PRODUS
VALUES (seq_cod_produs.NEXTVAL, 'MicroSD 128GB', 250.00);

INSERT INTO PRODUS
VALUES (seq_cod_produs.NEXTVAL, 'Încărcător Wireless', 250.00);

INSERT INTO PRODUS
VALUES (seq_cod_produs.NEXTVAL, 'Samsung SmartTag', 150.00);

INSERT INTO PRODUS
VALUES (seq_cod_produs.NEXTVAL, 'Big Mac', 25.00);

INSERT INTO PRODUS
VALUES (seq_cod_produs.NEXTVAL, 'Meniu Big Mac', 35.00);

INSERT INTO PRODUS
VALUES (seq_cod_produs.NEXTVAL, 'MC Chicken', 25.00);

INSERT INTO PRODUS
VALUES (seq_cod_produs.NEXTVAL, 'Meniu MC Chicken', 25.00);

INSERT INTO PRODUS
VALUES (seq_cod_produs.NEXTVAL, 'McNuggets 9 buc.', 15.00);

INSERT INTO PRODUS
VALUES (seq_cod_produs.NEXTVAL, 'Meniu McNuggets 9 buc.', 15.00);

INSERT INTO PRODUS
VALUES (seq_cod_produs.NEXTVAL, 'McFlurry', 15.00);

INSERT INTO ARE_STOC
VALUES(100, 1, 100);

INSERT INTO ARE_STOC
VALUES(100, 2, 100);

INSERT INTO ARE_STOC
VALUES(100, 3, 100);

INSERT INTO ARE_STOC
VALUES(160, 4, 100);

INSERT INTO ARE_STOC
VALUES(160, 5, 100);

INSERT INTO ARE_STOC
VALUES(160, 6, 100);

INSERT INTO ARE_STOC
VALUES(180, 1, 100);

INSERT INTO ARE_STOC
VALUES(180, 5, 100);

INSERT INTO ARE_STOC
VALUES(180, 6, 100);

INSERT INTO ARE_STOC
VALUES(110, 7, 100);

INSERT INTO ARE_STOC
VALUES(110, 8, 100);

INSERT INTO ARE_STOC
VALUES(150, 8, 1000);

INSERT INTO ARE_STOC
VALUES(150, 9, 200);

INSERT INTO ARE_STOC
VALUES(150, 10, 200);

INSERT INTO ARE_STOC
VALUES(170, 10, 1000);

INSERT INTO ARE_STOC
VALUES(170, 11, 1000);

INSERT INTO ARE_STOC
VALUES(170, 7,  100);

INSERT INTO ARE_STOC
VALUES(120, 12, 200);

INSERT INTO ARE_STOC
VALUES(120, 13, 150);

INSERT INTO ARE_STOC
VALUES(120, 14, 100);

INSERT INTO ARE_STOC
VALUES(190, 13, 25);

INSERT INTO ARE_STOC
VALUES(190, 14, 150);

INSERT INTO ARE_STOC
VALUES(190, 15, 70);

INSERT INTO ARE_STOC
VALUES(130, 22, 250);

INSERT INTO ARE_STOC
VALUES(130, 21, 100);

INSERT INTO ARE_STOC
VALUES(130, 20, 150);

INSERT INTO ARE_STOC
VALUES(140, 23, 2500);

INSERT INTO ARE_STOC
VALUES(140, 25, 3000);

INSERT INTO REPREZENTANT
VALUES(seq_cod_reprezentant.NEXTVAL, 'Munteanu', 'Iulia', 100);

INSERT INTO REPREZENTANT
VALUES(seq_cod_reprezentant.NEXTVAL, 'Eremia', 'Alin - Ștefan', 110);

INSERT INTO REPREZENTANT
VALUES(seq_cod_reprezentant.NEXTVAL, 'Neagu', 'Robert', 120);

INSERT INTO REPREZENTANT
VALUES(seq_cod_reprezentant.NEXTVAL, 'Ichim', 'Sebastian', 130);

INSERT INTO REPREZENTANT
VALUES(seq_cod_reprezentant.NEXTVAL, 'Hadărău', 'Gabriel', 140);

INSERT INTO REPREZENTANT
VALUES(seq_cod_reprezentant.NEXTVAL, 'Pop', 'Alexandra', 150);

INSERT INTO REPREZENTANT
VALUES(seq_cod_reprezentant.NEXTVAL, 'Moldovan', 'Andra', 160);

INSERT INTO REPREZENTANT
VALUES(seq_cod_reprezentant.NEXTVAL, 'Cenan', 'Gabriela', 170);

INSERT INTO REPREZENTANT
VALUES(seq_cod_reprezentant.NEXTVAL, 'Baciu', 'Ionuț', 180);

INSERT INTO REPREZENTANT
VALUES(seq_cod_reprezentant.NEXTVAL, 'Brița', 'Laura', 190);

INSERT INTO REPREZENTANT
VALUES(seq_cod_reprezentant.NEXTVAL, 'Nițoi', 'Dan', 100);

INSERT INTO REPREZENTANT
VALUES(seq_cod_reprezentant.NEXTVAL, 'Păun', 'Laura', 110);

INSERT INTO REPREZENTANT
VALUES(seq_cod_reprezentant.NEXTVAL, 'Bălan', 'Andrei', 120);

INSERT INTO REPREZENTANT
VALUES(seq_cod_reprezentant.NEXTVAL, 'Stănilă', 'Gabriel', 130);

INSERT INTO REPREZENTANT
VALUES(seq_cod_reprezentant.NEXTVAL, 'Burcuș', 'Delia', 140);

INSERT INTO REPREZENTANT
VALUES(seq_cod_reprezentant.NEXTVAL, 'Grejdan', 'Roxana', 150);

INSERT INTO REPREZENTANT
VALUES(seq_cod_reprezentant.NEXTVAL, 'Bichir', 'Adriana', 160);

INSERT INTO REPREZENTANT
VALUES(seq_cod_reprezentant.NEXTVAL, 'Neacșu', 'Simona', 170);

INSERT INTO REPREZENTANT
VALUES(seq_cod_reprezentant.NEXTVAL, 'Deac', 'Andreea-Alexandra', 180);

INSERT INTO REPREZENTANT
VALUES(seq_cod_reprezentant.NEXTVAL, 'Popescu', 'Robert', 190);

INSERT INTO REPREZENTANT
VALUES(seq_cod_reprezentant.NEXTVAL, 'Cheșuț', 'Cristian', 100);

INSERT INTO REPREZENTANT
VALUES(seq_cod_reprezentant.NEXTVAL, 'Borz', 'Vlad', 110);

INSERT INTO REPREZENTANT
VALUES(seq_cod_reprezentant.NEXTVAL, 'Mărginean', 'Sanda', 120);

INSERT INTO REPREZENTANT
VALUES(seq_cod_reprezentant.NEXTVAL, 'Maior', 'Cătălin', 130);

INSERT INTO REPREZENTANT
VALUES(seq_cod_reprezentant.NEXTVAL, 'Mureșan', 'Ioana', 140);

INSERT INTO PROGRAM
VALUES(seq_cod_eveniment.NEXTVAL, 100, 10, TO_DATE('2025-04-24 16:00','YYYY-MM-DD HH24:MI'),TO_DATE('2025-04-24 18:45','YYYY-MM-DD HH24:MI'));

INSERT INTO PROGRAM
VALUES(seq_cod_eveniment.NEXTVAL, 10, 10, TO_DATE('2025-04-24 18:50','YYYY-MM-DD HH24:MI'),TO_DATE('2025-04-24 19:00','YYYY-MM-DD HH24:MI'));

INSERT INTO PROGRAM
VALUES(seq_cod_eveniment.NEXTVAL, 110, 10, TO_DATE('2025-04-24 19:05','YYYY-MM-DD HH24:MI'),TO_DATE('2025-04-24 19:50','YYYY-MM-DD HH24:MI'));

INSERT INTO PROGRAM
VALUES(seq_cod_eveniment.NEXTVAL, 20, 10, TO_DATE('2025-04-24 19:55','YYYY-MM-DD HH24:MI'),TO_DATE('2025-04-24 20:00','YYYY-MM-DD HH24:MI'));

INSERT INTO PROGRAM
VALUES(seq_cod_eveniment.NEXTVAL, 60, 10, TO_DATE('2025-04-24 20:05','YYYY-MM-DD HH24:MI'),TO_DATE('2025-04-24 21:05','YYYY-MM-DD HH24:MI'));

INSERT INTO PROGRAM
VALUES(seq_cod_eveniment.NEXTVAL, 20, 10, TO_DATE('2025-04-24 21:10','YYYY-MM-DD HH24:MI'),TO_DATE('2025-04-24 21:20','YYYY-MM-DD HH24:MI'));

INSERT INTO PROGRAM
VALUES(seq_cod_eveniment.NEXTVAL, 70, 20, TO_DATE('2025-04-24 19:00','YYYY-MM-DD HH24:MI'),TO_DATE('2025-04-24 19:45','YYYY-MM-DD HH24:MI'));

INSERT INTO PROGRAM
VALUES(seq_cod_eveniment.NEXTVAL, 40, 20, TO_DATE('2025-04-24 19:50','YYYY-MM-DD HH24:MI'),TO_DATE('2025-04-24 20:00','YYYY-MM-DD HH24:MI'));

INSERT INTO PROGRAM
VALUES(seq_cod_eveniment.NEXTVAL, 90, 50, TO_DATE('2025-04-24 21:00','YYYY-MM-DD HH24:MI'),TO_DATE('2025-04-24 21:45','YYYY-MM-DD HH24:MI'));

INSERT INTO PROGRAM
VALUES(seq_cod_eveniment.NEXTVAL, 30, 50, TO_DATE('2025-04-24 22:00','YYYY-MM-DD HH24:MI'),TO_DATE('2025-04-24 22:10','YYYY-MM-DD HH24:MI'));

INSERT INTO PROGRAM
VALUES(seq_cod_eveniment.NEXTVAL, 120, 30, TO_DATE('2025-04-25 19:00','YYYY-MM-DD HH24:MI'),TO_DATE('2025-04-25 19:45','YYYY-MM-DD HH24:MI'));

INSERT INTO PROGRAM
VALUES(seq_cod_eveniment.NEXTVAL, 50, 30, TO_DATE('2025-04-25 22:00','YYYY-MM-DD HH24:MI'),TO_DATE('2025-04-25 22:15','YYYY-MM-DD HH24:MI'));

INSERT INTO PROGRAM
VALUES(seq_cod_eveniment.NEXTVAL, 140, 30, TO_DATE('2025-04-25 22:30','YYYY-MM-DD HH24:MI'),TO_DATE('2025-04-25 22:45','YYYY-MM-DD HH24:MI'));

INSERT INTO PROGRAM
VALUES(seq_cod_eveniment.NEXTVAL, 50, 30, TO_DATE('2025-04-25 22:50','YYYY-MM-DD HH24:MI'),TO_DATE('2025-04-25 23:00','YYYY-MM-DD HH24:MI'));

INSERT INTO PROGRAM
VALUES(seq_cod_eveniment.NEXTVAL, 80, 40, TO_DATE('2025-04-25 19:00','YYYY-MM-DD HH24:MI'),TO_DATE('2025-04-25 19:50','YYYY-MM-DD HH24:MI'));

INSERT INTO PROGRAM
VALUES(seq_cod_eveniment.NEXTVAL, 20, 40, TO_DATE('2025-04-25 20:00','YYYY-MM-DD HH24:MI'),TO_DATE('2025-04-25 20:15','YYYY-MM-DD HH24:MI'));

INSERT INTO PROGRAM
VALUES(seq_cod_eveniment.NEXTVAL, 130, 40, TO_DATE('2025-04-25 22:05','YYYY-MM-DD HH24:MI'),TO_DATE('2025-04-25 22:50','YYYY-MM-DD HH24:MI'));

INSERT INTO PROGRAM
VALUES(seq_cod_eveniment.NEXTVAL, 30, 40, TO_DATE('2025-04-25 22:55','YYYY-MM-DD HH24:MI'),TO_DATE('2025-04-25 23:00','YYYY-MM-DD HH24:MI'));

INSERT INTO PROGRAM
VALUES(seq_cod_eveniment.NEXTVAL, 150, 20, TO_DATE('2025-04-25 20:00','YYYY-MM-DD HH24:MI'),TO_DATE('2025-04-25 20:50','YYYY-MM-DD HH24:MI'));

INSERT INTO PROGRAM
VALUES(seq_cod_eveniment.NEXTVAL, 20, 20, TO_DATE('2025-04-25 21:00','YYYY-MM-DD HH24:MI'),TO_DATE('2025-04-25 21:10','YYYY-MM-DD HH24:MI'));

INSERT INTO PROGRAM
VALUES(seq_cod_eveniment.NEXTVAL, 160, 20, TO_DATE('2025-04-25 21:30','YYYY-MM-DD HH24:MI'),TO_DATE('2025-04-25 22:15','YYYY-MM-DD HH24:MI'));

INSERT INTO PROGRAM
VALUES(seq_cod_eveniment.NEXTVAL, 10, 20, TO_DATE('2025-04-25 22:20','YYYY-MM-DD HH24:MI'),TO_DATE('2025-04-25 22:30','YYYY-MM-DD HH24:MI'));

INSERT INTO INCARCA (cod_bratara, cod_personal, data_ora, suma)
VALUES (13, 136, TIMESTAMP '2025-04-24 18:00:48', 200);
UPDATE BRATARA
SET sold_bratara = sold_bratara + 200
WHERE cod_bratara = 13;

INSERT INTO INCARCA (cod_bratara, cod_personal, data_ora, suma)
VALUES (14, 130, TIMESTAMP '2025-04-24 22:43:54', 400);
UPDATE BRATARA
SET sold_bratara = sold_bratara + 400
WHERE cod_bratara = 14;

INSERT INTO INCARCA (cod_bratara, cod_personal, data_ora, suma)
VALUES (15, 136, TIMESTAMP '2025-04-24 15:21:42', 900);
UPDATE BRATARA
SET sold_bratara = sold_bratara + 900
WHERE cod_bratara = 15;

INSERT INTO INCARCA (cod_bratara, cod_personal, data_ora, suma)
VALUES (16, 130, TIMESTAMP '2025-04-24 18:28:15', 50);
UPDATE BRATARA
SET sold_bratara = sold_bratara + 50
WHERE cod_bratara = 16;

INSERT INTO INCARCA (cod_bratara, cod_personal, data_ora, suma)
VALUES (17, 136, TIMESTAMP '2025-04-24 17:14:22', 1000);
UPDATE BRATARA
SET sold_bratara = sold_bratara + 1000
WHERE cod_bratara = 17;

INSERT INTO INCARCA (cod_bratara, cod_personal, data_ora, suma)
VALUES (18, 136, TIMESTAMP '2025-04-24 22:21:18', 900);
UPDATE BRATARA
SET sold_bratara = sold_bratara + 900
WHERE cod_bratara = 18;

INSERT INTO INCARCA (cod_bratara, cod_personal, data_ora, suma)
VALUES (19, 136, TIMESTAMP '2025-04-25 00:14:11', 450);
UPDATE BRATARA
SET sold_bratara = sold_bratara + 450
WHERE cod_bratara = 19;

INSERT INTO INCARCA (cod_bratara, cod_personal, data_ora, suma)
VALUES (40, 130, TIMESTAMP '2025-04-24 23:39:39', 700);
UPDATE BRATARA
SET sold_bratara = sold_bratara + 700
WHERE cod_bratara = 40;

INSERT INTO INCARCA (cod_bratara, cod_personal, data_ora, suma)
VALUES (41, 130, TIMESTAMP '2025-04-25 21:49:57', 550);
UPDATE BRATARA
SET sold_bratara = sold_bratara + 550
WHERE cod_bratara = 41;

INSERT INTO INCARCA (cod_bratara, cod_personal, data_ora, suma)
VALUES (42, 130, TIMESTAMP '2025-04-25 21:58:51', 600);
UPDATE BRATARA
SET sold_bratara = sold_bratara + 600
WHERE cod_bratara = 42;

INSERT INTO INCARCA (cod_bratara, cod_personal, data_ora, suma)
VALUES (43, 133, TIMESTAMP '2025-04-25 19:31:24', 100);
UPDATE BRATARA
SET sold_bratara = sold_bratara + 100
WHERE cod_bratara = 43;

INSERT INTO INCARCA (cod_bratara, cod_personal, data_ora, suma)
VALUES (44, 130, TIMESTAMP '2025-04-25 19:40:27', 650);
UPDATE BRATARA
SET sold_bratara = sold_bratara + 650
WHERE cod_bratara = 44;

INSERT INTO INCARCA (cod_bratara, cod_personal, data_ora, suma)
VALUES (45, 136, TIMESTAMP '2025-04-25 22:06:22', 1000);
UPDATE BRATARA
SET sold_bratara = sold_bratara + 1000
WHERE cod_bratara = 45;

INSERT INTO INCARCA (cod_bratara, cod_personal, data_ora, suma)
VALUES (46, 136, TIMESTAMP '2025-04-25 22:28:36', 350);
UPDATE BRATARA
SET sold_bratara = sold_bratara + 350
WHERE cod_bratara = 46;

INSERT INTO INCARCA (cod_bratara, cod_personal, data_ora, suma)
VALUES (47, 136, TIMESTAMP '2025-04-25 18:54:18', 400);
UPDATE BRATARA
SET sold_bratara = sold_bratara + 400
WHERE cod_bratara = 47;

BEGIN
    p_tranzactie_produs(30,1,41, TIMESTAMP '2025-04-24 20:19:16');
    p_tranzactie_produs(30, 1, 47, TIMESTAMP '2025-04-24 17:28:28');
    p_tranzactie_produs(30, 1, 41, TIMESTAMP '2025-04-24 20:19:16');
    p_tranzactie_produs(30, 3, 17, TIMESTAMP '2025-04-24 22:55:28');
    p_tranzactie_produs(30, 2, 17, TIMESTAMP '2025-04-24 21:35:12');
END;
/
COMMIT;
