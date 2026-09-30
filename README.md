# BREEZE Database Management System

Bază de date pentru administrarea unui festival de muzică: personal și departamente, artiști și sponsori, programul scenelor, participanți și bilete, brățări electronice, puncte de vânzare, plăți și stocuri.

Proiect realizat de **Pal Robert-Attila**, seria 23, grupa 232, anul universitar 2025–2026. Implementare în **Oracle Database 19c**, cu SQL și PL/SQL, într-un container Docker.

## Documentație și diagrame

[Documentația completă — PDF, 221 de pagini](docs/BREEZE_Documentation.pdf) păstrează modelul relațional, regulile de integritate, explicațiile implementării și scenariile demonstrative. Fișierul este copia integrală a documentului `232_Pal_Robert-Attila_BREEZE 2.pdf`.

### Diagrama entitate-relație

Export din pagina 24 a documentației. Deschide imaginea pentru detalii.

[![Diagrama ER BREEZE](docs/er-diagram.png)](docs/er-diagram.png)

### Schema conceptuală

Export din pagina 25 a documentației.

[![Schema conceptuală BREEZE](docs/conceptual-schema.png)](docs/conceptual-schema.png)

## Organizarea proiectului

```text
breeze-database-management-system/
├── README.md
├── database/
│   ├── 01_schema.sql
│   ├── 02_seed_data.sql
│   ├── 03_triggers.sql
│   ├── 04_procedures.sql
│   ├── 05_functions.sql
│   └── 06_tests.sql
├── docs/
│   ├── BREEZE_Documentation.pdf
│   ├── er-diagram.png
│   └── conceptual-schema.png
└── docker/
    └── README.md
```

| Fișier | Conținut |
| --- | --- |
| [01_schema.sql](database/01_schema.sql) | 28 de tabele, inclusiv `SUSPICIUNE` și `MENTENANTA`, constrângeri PK/FK/CHECK/UNIQUE și 21 de secvențe. |
| [02_seed_data.sql](database/02_seed_data.sql) | 536 de instrucțiuni INSERT pentru datele inițiale, 15 actualizări inițiale de sold și cinci apeluri de populare a tranzacțiilor. |
| [03_triggers.sql](database/03_triggers.sql) | Nouă triggere pentru program, bilete, audit, încărcări și control DDL. |
| [04_procedures.sql](database/04_procedures.sql) | Patru proceduri independente și trei pachete complete: `acces_VIP`, `pkg_mentenanta`, `pkg_comenzi`. |
| [05_functions.sql](database/05_functions.sql) | Funcția independentă `f_contactare_manager_departament`. |
| [06_tests.sql](database/06_tests.sql) | Verificări de compilare, interogări și scenarii demonstrative pozitive și negative. |

Funcțiile membre, precum `pkg_comenzi.total_comanda` și `pkg_comenzi.bon_electronic`, rămân în pachetul din `04_procedures.sql`: separarea lor ar rupe corpul PL/SQL și accesul la starea pachetului. INSERT-urile de test și cele din subprograme rămân alături de scenariul sau logica din care fac parte.

## Reguli și logică păstrate

| Funcționalitate | Implementare |
| --- | --- |
| Prevenirea suprapunerii evenimentelor pe aceeași scenă | `t_program_fara_suprapunere`; `t_program_artist` limitează reprezentațiile unui artist. |
| Validarea biletelor | `t_bilet_validat_insert`, `t_bilet_validare_update`: validare de către un agent și blocarea revenirii la starea nevalidată. |
| Audit pentru tentative suspecte | `p_suspiciune` folosește o tranzacție autonomă și păstrează înregistrarea chiar dacă operația este respinsă. |
| Blocarea transferului biletelor | `t_blocare_update_bilet`, împreună cu protecția datelor de identificare prin `t_blocare_update_participant`. |
| Control DDL | `t_control` permite CREATE/ALTER/DROP numai când `pkg_mentenanta` activează mentenanța în sesiunea curentă; tabela `MENTENANTA` păstrează evidența. |
| Actualizarea soldului brățărilor | `t_incarcare_bratara` verifică personalul și adaugă suma încărcată în sold. |
| Plăți și stocuri | `p_tranzactie_produs` și `pkg_comenzi`: debitarea brățării, actualizarea stocului, creditarea insulei, tranzacție și detalii; pachetul include coș, bon electronic, blocări `FOR UPDATE` și `SAVEPOINT`. |
| Acces VIP și raportare | `acces_VIP`, `raport_editorial_program`, `p_verificare_disponibilitate_produs` și funcția de contactare a managerului. |

## Instalare într-o schemă goală

Configurarea mediului și conectarea sunt descrise în [docker/README.md](docker/README.md). Folosește un utilizator de proiect din PDB, cu drepturi pentru tabele, secvențe, proceduri și triggere și cu spațiu în tablespace.

Din rădăcina proiectului, într-o sesiune SQL*Plus conectată la schema goală, rulează **în această ordine**:

```sql
@database/01_schema.sql
@database/04_procedures.sql
@database/05_functions.sql
@database/02_seed_data.sql
@database/03_triggers.sql

SELECT object_name, object_type, status
FROM user_objects
WHERE status = 'INVALID';

SELECT name, type, line, position, text
FROM user_errors
ORDER BY name, sequence;
```

Ultimele două interogări trebuie să întoarcă zero rânduri. În SQL Developer, deschide fișierele în aceeași ordine și folosește **Run Script (F5)**.

Numerele fișierelor identifică rolurile, nu ordinea de instalare. Procedura de tranzacții trebuie să existe înainte de populare. Seed-ul original conține actualizări manuale ale soldului după încărcări; instalarea triggerului de încărcare înaintea seed-ului ar dubla aceste sume. `t_control` este creat ultimul, după toate celelalte obiecte, pentru a nu bloca instalarea.

Fișierele de instalare opresc SQL*Plus la o eroare SQL. Erorile de compilare PL/SQL trebuie verificate separat prin `USER_ERRORS`. Instalarea este destinată unei scheme goale și nu este idempotentă: o nouă rulare poate întâlni obiecte existente, chei duplicate sau controlul DDL. DDL și unele proceduri fac COMMIT; o instalare incompletă nu poate fi anulată integral prin ROLLBACK.

## Scenarii de test

[06_tests.sql](database/06_tests.sql) păstrează demonstrațiile originale: suprapuneri, validări respinse, acces VIP, raportare, căutări ambigue, audit, încărcări, mentenanță și comenzi cu stoc ori sold insuficient.

Rulează blocurile selectiv într-o **schemă de test** după instalare. Pentru o demonstrație secvențială completă:

```sql
@database/06_tests.sql
```

Acest fișier continuă după erori deoarece unele sunt intenționate. Nu este o suită automată cu rezultat pass/fail: compară fiecare mesaj și efect cu scenariul comentat și cu documentația. Conține modificări de date, COMMIT și crearea tabelei `TEST`; auditul autonom persistă. Rerularea poate produce rezultate diferite, iar vârsta pentru VIP depinde de `SYSDATE`.

Pentru schimbări ulterioare de structură, activează mentenanța în **aceeași sesiune** în care execuți DDL:

```sql
BEGIN
    pkg_mentenanta.incepe('Actualizare controlata a schemei');
END;
/
-- Executa aici operatiile DDL necesare.
BEGIN
    pkg_mentenanta.termina;
END;
/
```

## Proveniență și verificare

SQL-ul a fost separat din `232_Pal_Robert-Attila_sursa.sql`, păstrând definițiile obiectelor și logica originală. Au fost eliminate delimitatoarele `/` redundante după SQL simplu, care ar reexecuta instrucțiunea în SQL*Plus. Explicațiile academice complete se află în PDF; fișierele SQL sunt grupate după responsabilitate.

Au fost verificate static inventarul obiectelor, păstrarea definițiilor, separarea datelor/scenariilor și integritatea copiei PDF; diagramele au fost verificate vizual. **Scripturile reorganizate nu au fost executate pe Oracle în această sesiune**; Docker și SQL*Plus nu au fost disponibile în PATH.

Reorganizarea păstrează și limitele implementării originale: triggerul de suprapunere verifică INSERT, nu modificările de interval prin UPDATE; evidența VIP și coșul sunt stări de pachet specifice sesiunii; mentenanța nu reprezintă un sistem separat de autorizare. Aceste aspecte necesită o revizie distinctă înaintea utilizării în producție.
