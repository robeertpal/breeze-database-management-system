# Oracle Database 19c in Docker

This guide describes the project's existing Docker environment. Automated image building and container provisioning are not included in this repository.

| Setting | Documented value |
| --- | --- |
| Database | Oracle Database 19c Enterprise Edition, reported version 19.19.0.0.0 |
| Local image | `oracle/database:19.3.0-ee` |
| Container | `homedb1` |
| Published port | `1521:1521` |
| SID / CDB | `HOMEDB1` |
| PDB / service name | `homedb1pdb` |
| Existing project user | `sgbd_homedb1` |

The image tag and reported database version describe different parts of the environment. Check your local configuration before connecting. The original Apple Silicon setup does not document the image build or emulation steps.

## Start the Existing Container

```sh
docker ps -a --filter name=homedb1
docker start homedb1
docker logs --tail 100 homedb1
docker inspect --format '{{.State.Health.Status}}' homedb1
```

Wait for `healthy`. If the container does not exist, provision an Oracle 19c image, container and persistent storage before following this guide.

## Connect

In SQL Developer, use host `localhost`, port `1521`, **Service name** `homedb1pdb`, user `sgbd_homedb1` and role **Default**. Enter your local password when prompted.

SQL*Plus inside the container also prompts for the password:

```sh
docker exec -it homedb1 sqlplus sgbd_homedb1@//localhost:1521/homedb1pdb
```

Verify the session:

```sql
SHOW USER
SHOW CON_NAME
SELECT sys_context('USERENV', 'SERVICE_NAME') AS service_name FROM dual;
```

## Install the Schema

Use an **empty schema**. If `sgbd_homedb1` already contains the project, have an administrator prepare a separate test schema and substitute that username in the connection commands.

The schema needs `CREATE SESSION`, `CREATE TABLE`, `CREATE SEQUENCE`, `CREATE PROCEDURE`, `CREATE TRIGGER` and a tablespace quota. User creation and grants are administrative operations in the PDB.

From the repository root, copy the scripts into the container and start SQL*Plus:

```sh
docker cp database homedb1:/tmp/breeze-database
docker exec -it -w /tmp/breeze-database homedb1 sqlplus sgbd_homedb1@//localhost:1521/homedb1pdb
```

Run the scripts in numerical order:

```sql
@01_schema.sql
@02_procedures.sql
@03_functions.sql
@04_seed_data.sql
@05_triggers.sql

SELECT object_name, object_type, status
FROM user_objects
WHERE status = 'INVALID';

SELECT name, type, line, position, text
FROM user_errors
ORDER BY name, sequence;
```

Both verification queries should return no rows. See the [main README](../README.md) for installation dependencies and demonstration scenarios.

## Subsequent DDL Changes

After installation, activate maintenance in the **same session** that will execute DDL:

```sql
BEGIN
    pkg_mentenanta.incepe('Controlled schema update');
END;
/
-- Execute the required DDL here.
BEGIN
    pkg_mentenanta.termina;
END;
/
```

Maintenance calls commit changes and record activity in `MENTENANTA`. End maintenance explicitly when the changes are complete.
