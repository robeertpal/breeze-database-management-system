# Oracle Database 19c în Docker

Configurația de mai jos este preluată din notițele locale de conectare ale proiectului. Descrie mediul existent; acest director nu conține încă un Dockerfile sau un fișier Compose pentru construirea automată a mediului.

| Parametru | Valoare documentată |
| --- | --- |
| Motor | Oracle Database 19c Enterprise Edition, versiune raportată 19.19.0.0.0 |
| Imagine locală | `oracle/database:19.3.0-ee` |
| Container | `homedb1` |
| Port publicat | `1521:1521` |
| SID / CDB | `HOMEDB1` |
| PDB / service name | `homedb1pdb` |
| Utilizator de proiect existent | `sgbd_homedb1` |

Eticheta imaginii și versiunea raportată de baza de date sunt valori distincte din notițele originale. Verifică mediul efectiv înainte de conectare.

## Pornirea containerului existent

```sh
docker ps -a --filter name=homedb1
docker start homedb1
docker logs --tail 100 homedb1
docker inspect --format '{{.State.Health.Status}}' homedb1
```

Continuă când containerul este `healthy`. Dacă acesta nu există, pașii de mai sus nu îl creează: trebuie pregătite separat imaginea Oracle 19c, containerul și stocarea persistentă. Configurația ARM64/Apple Silicon din notițe nu documentează metoda de construire sau emulare a imaginii.

## Conectare

În SQL Developer: host `localhost`, port `1521`, tip **Service name**, serviciu `homedb1pdb`, utilizator `sgbd_homedb1`, rol **Default**. Introdu parola local, în dialogul clientului.

SQL*Plus din container solicită parola interactiv:

```sh
docker exec -it homedb1 sqlplus sgbd_homedb1@//localhost:1521/homedb1pdb
```

Verifică sesiunea:

```sql
SHOW USER
SHOW CON_NAME
SELECT sys_context('USERENV', 'SERVICE_NAME') AS service_name FROM dual;
```

Pentru a face fișierele disponibile în container, rulează din rădăcina proiectului:

```sh
docker cp database homedb1:/tmp/breeze-database
docker exec -it -w /tmp/breeze-database homedb1 sqlplus sgbd_homedb1@//localhost:1521/homedb1pdb
```

Instalează **doar într-o schemă goală**. Dacă `sgbd_homedb1` conține deja proiectul, folosește o schemă de test nouă, pregătită de administrator, și înlocuiește utilizatorul în comenzile de conectare. Nu executa instalarea peste datele existente.

În SQL*Plus deschis în `/tmp/breeze-database`:

```sql
@01_schema.sql
@04_procedures.sql
@05_functions.sql
@02_seed_data.sql
@03_triggers.sql

SELECT object_name, object_type, status FROM user_objects WHERE status = 'INVALID';
SELECT name, type, line, position, text FROM user_errors ORDER BY name, sequence;
```

Schema are nevoie de `CREATE SESSION`, `CREATE TABLE`, `CREATE SEQUENCE`, `CREATE PROCEDURE`, `CREATE TRIGGER` și cotă în tablespace. Acordarea acestora și crearea utilizatorului sunt operații administrative în PDB. Rulează proiectul prin utilizatorul său, cu rol **Default**.

Parolele din notițele originale nu sunt reproduse în instrucțiunile de conectare. Ordinea de instalare, controlul DDL și efectele scenariilor demonstrative sunt explicate în [README-ul principal](../README.md).
