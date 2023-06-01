
## Übung D3: Schema- and Data-loading, Queries &nbsp; (<span style="color:red">10 Pts</span>)

&nbsp;

The *Standard Query Language* [SQL](https://www.w3schools.com/sql) is used to express
operations in a database for:

- CREATING DATABASES and TABLES: Schema;

- INSERTING, UPDATING and DELETING data records;

- SELECTING data by running queries. 


&nbsp;

### Challenges
1. [Challenge 1:](#1-challenge-1) Client access to the database - (2 Pts)
2. [Challenge 2:](#2-challenge-2) Load the Schema - (2 Pts)
3. [Challenge 3:](#3-challenge-3) Load Data - (2 Pts)
4. [Challenge 4:](#4-challenge-4) Running Queries - (2 Pts)
5. [Challenge 5:](#5-challenge-5) Updating Data - (2 Pts)

Refer to [known issues](https://github.com/sgra64/db-freerider/blob/main/Known_Issues.md)
for problems.


&nbsp;

---
### 1.) Challenge 1
Data in a database is managed by a database server process `mysqld`
( *-d* for *daemon* process), which listens on a TCP network port.
MySQL uses TCP port: *3306* as default port).
Only the server processes have direct access to database data.

A client-program is used to connect to the server process listening
on TCP port: *3306* (as default) in order to access data in the database.

A variety of client programs exist:

- [mysql](https://dev.mysql.com/doc/refman/8.0/en/mysql.html) is the MySQL-client,
    which reads SQL-statements from `stdin`, sends them to the MySQL-server and
    prints results to `stdout` in a terminal.

- IDE Plugins can be used as clients to connect to a database.
    [SQLTools](https://marketplace.visualstudio.com/items?itemName=mtxr.sqltools)
    is an example of a plugin for Visual Studio Code.

- API Libraries in programming languages can make applications connect to a database
    server. [JDBC](https://docs.oracle.com/javase/tutorial/jdbc/basics/index.html)
    is an example of a basic library for Java (JDBC: Java Database Connectivity).

Use the `mysql`-client to connect to the database and run basic queries.

You can use a `mysql`-client that may be installed on your host-system (laptop),
e.g. from MySQL Workbench (not needed here). Test your local configuration.

```
> mysql --version

-> command not found
```

A `mysql`-client is preinstalled in the database container. To access, start the database
container and attach a bash process.

Inspect file `.env.sh` in the project directory, which sets a local project environemt
for the executing shell.

A *.env* file or *dotenv* file is a simple text file for controlling the application 
environment. Read: *Liam Hall*, *What are .env files and how to use them*,
[link](https://levelup.gitconnected.com/what-are-env-files-and-how-to-use-them-in-nuxt-7f194f083e3d).

Source the `.env.sh` file making its definitions effective for the executing shell.
One of the environment variables set in this file is: `${container_name}`.

```perl
> cd <project-directory>

> echo ${container_name}      # empty, environment variable not yet set

> source .env.sh              # source project environment in executing shell

> echo ${container_name}      # now environment is set to container name
db-freerider_MySQLServer
```

The `.env.sh`-script also defines two shell-functions that are used to shortcut
longer commands:

- `dock` for shortcut docker container commands:

    - `dock build | start | stop | bash | logs | clean ... `

- `mysql` function to supplement *mysql*-client with project-specific arguments:

    - `mysql --user="${MYSQL_USER}" --password="${MYSQL_PASSWORD}" ... `

After sourcing `.env.sh`, the database should be started with:

```perl
> dock start      # starts MySQL-container with project-specific settings
```

Long-form without settings from `.env.sh`:

```perl
> docker start db-freerider_MySQLServer      # start with regular docker command
```

The database container should be running.

Attach a shell-process:

```sh
short:  dock bash               # using shortcut from dock-function in .env.sh
bash-4.4$

long:   docker exec -it "db-freerider_MySQLServer" /bin/bash
bash-4.4$
```

Verify the presence of `mysql`-client program inside the container-shell:

```
bash-4.4$ mysql --version
-> mysql  Ver 8.0.31 for Linux on x86_64 (MySQL Community Server - GPL)
```

*"Log into the database"* by opening a connection with the `mysql`-client.
Specify the connection information (host, port), database (freerider_db) and
access credentials (user, password):

```
bash-4.4$ mysql --host=localhost --port=3306 \
            --user=freerider --password=free.ride freerider_db

mysql: [Warning] Using a password on the command line interface can be insecure.
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 12
Server version: 8.0.31 MySQL Community Server - GPL

Copyright (c) 2000, 2022, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> 
```

Alternatively, a second `./db.mnt/.env.sh` - script exists that is mapped from the host
system folder `./db.mnt` into the container under the mount point `/mnt` (mounts were
created during container-build).

Sourcing this `.env.sh`-file will shortcut commands also inside the container:

```
bash-4.4$ source /mnt/.env.sh
bash-4.4$ mysql
...
mysql> show tables;
+------------------------+      # assuming tables have been created
| Tables_in_freerider_db |
+------------------------+
| CUSTOMER               |
| RESERVATION            |
| VEHICLE                |
+------------------------+
3 rows in set (0.01 sec)
```

A third method of executing database commands is *"piping"* them into the database.
Exit from the mysql-client (with `exit` or `quit`) back to the shell in the container.

The following command uses `echo` to output arguments ("show tables;") to `stdout`,
which is output to the terminal with no redirection (first example).

Output to `stdout` can be redirected to a file with `>` (new file) or `>>` (append),
which is shown in the second example.

```sh
bash-4.4$ echo "show tables;"               # output to terminal
-> show tables;

bash-4.4$ echo "show tables;" > file.out    # output redirected to file: file.out
bash-4.4$ cat file.out                      # print file: file.out
-> show tables;
```

The next example uses `|` (pipe) to connect `stdout` of the preceding process (echo)
to `stdin` of a following process (here: *mysql* ) with the effect that echo's output:
`"show tables;"` is *"piped"* to the `mysql` - client as input and executing it.

```sh
bash-4.4$ echo "show tables;" | mysql       # pipe output to mysql-client
```

Output (no lines are shown):

```
CUSTOMER
RESERVATION
VEHICLE
```

This method can be used to load data into the database by *"piping"* INSERT-statements
into the `mysql`-client, which passes them on to the `mysqld`-server process over a
TCP connection. The `mysqld`-server, in turn, writes them into the database.

Pull from [db.mnt](https://github.com/sgra64/db-freerider/tree/main/db.mnt)
data files and place them into the project `db.mnt`-directory, which will make data
files available inside the container under the mount point `/mnt`:

- `data_customers.sql` with CUSTOMER data (200+ customer records),

- `data_vehicles.sql` with VEHICLE data,

- `data_reservations.sql` with RESERVATION data,


Show the first 8 and last 4 lines of CUSTOMER records inside the container:

```sh
bash-4.4$ cat /mnt/data_customers.sql | (head -8; tail -4)
```

Output:

```
USE FREERIDER_DB;

DELETE FROM CUSTOMER;
INSERT INTO CUSTOMER (ID, NAME, CONTACT, STATUS) VALUES
    (1, 'Meyer, Eric', 'eme22@gmail.com', 'Active'),
    (2, 'Sommer, Tina', '030 22458 29425', 'Active'),
    (3, 'Schulze, Tim', '+49 171 2358124', 'Active'),
    (4, 'Landmann, Max', '+49 030 8123524', 'Terminated'),
    (212, 'Klaus, Christos', '05341 48586', 'Active'),
    (213, 'Bauer, John', 'bauer200@gmail.com', 'Active'),
    (214, 'Reuter, Birgitt', '04242 2025', 'InRegistration')
;
```

The SQL in the output tells to use FREERIDER_DB. All records are deleted
from CUSTOMER in order to avoid insertion conflicts.

The output is valid SQL and can be piped into the database for execution.

```
bash-4.4$ cat /mnt/data_customers.sql | (head -8; tail -4) | mysql
```

Next, run a query to show records:

```
bash-4.4# echo "select * from CUSTOMER;" | mysql
```

Output:

```
ID      NAME            CONTACT             STATUS
1       Meyer, Eric     eme22@gmail.com     Active
2       Sommer, Tina    030 22458 29425     Active
3       Schulze, Tim    +49 171 2358124     Active
4       Landmann, Max   +49 030 8123524     Terminated
212     Klaus, Christos 05341 48586         Active
213     Bauer, John     bauer200@gmail.com  Active
214     Reuter, Birgitt 04242 2025          InRegistration
```

Repeat after logging into the database:

```
bash-4.4# mysql
...
mysql> select * from CUSTOMER;
```

Output (with border lines):

```
+-----+-----------------+--------------------+----------------+
| ID  | NAME            | CONTACT            | STATUS         |
+-----+-----------------+--------------------+----------------+
|   1 | Meyer, Eric     | eme22@gmail.com    | Active         |
|   2 | Sommer, Tina    | 030 22458 29425    | Active         |
|   3 | Schulze, Tim    | +49 171 2358124    | Active         |
|   4 | Landmann, Max   | +49 030 8123524    | Terminated     |
| 212 | Klaus, Christos | 05341 48586        | Active         |
| 213 | Bauer, John     | bauer200@gmail.com | Active         |
| 214 | Reuter, Birgitt | 04242 2025         | InRegistration |
+-----+-----------------+--------------------+----------------+
7 rows in set (0.00 sec)
```

Repeat in IDE (here with Visual Studio Code SQLTools extension):

![Customer Query with SQLTools](./img_30.png)


(2 Pts)


&nbsp;

---
### 2.) Challenge 2
Loading the schema is the first step in building (rebuilding) a database.

A database should always have an external `*_schema.sql`-file with SQL statements
that remove all prior data and schema and rebuilds the database schema from scratch
creating all necessary tables.

The `*_schema.sql`-file for the FREERIDER_DB exists:

- in the project directory under path:
    - `db.mnt/init_freerider_schema.sql`

- It is available inside the container under the mount path `/mnt` (same file, not a copy):
    - `/mnt/init_freerider_schema.sql`

Loading a schema implies all data (schema, tables, records) of a database are lost!

```sql
DROP SCHEMA IF EXISTS FREERIDER_DB;

CREATE SCHEMA IF NOT EXISTS FREERIDER_DB;
USE FREERIDER_DB;

DROP TABLE IF EXISTS CUSTOMER;
CREATE TABLE CUSTOMER (
  ID INT NOT NULL,
  NAME VARCHAR(60) DEFAULT NULL,
  CONTACT VARCHAR(60) DEFAULT NULL,
  STATUS ENUM('Active', 'InRegistration', 'Terminated') DEFAULT NULL,
  PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
...
```

Perform following tasks. Figure out where to input them (bash, mysql):

1. Drop the schema for FREERIDER_DB database.

    - ```
      drop schema FREERIDER_DB;
      show databases;
      --> no FREERIDER_DB
      ```

1. Reload (*pipe*) the schema back into the database (the root-script with
    root-account must be used since FREERIDER_DB used by mysql script
    no longer exists).

    - ```
      cat /mnt/init_freerider_schema.sql | mysql_root
      ```

2. Show databases and tables.

    - ```
      show databases;               show tables;
      +--------------------+        +------------------------+
      | Database           |        | Tables_in_freerider_db |
      +--------------------+        +------------------------+
      | FREERIDER_DB       |        | CUSTOMER               |
      | information_schema |        | RESERVATION            |
      | performance_schema |        | VEHICLE                |
      +--------------------+        +------------------------+
      ```

3. Show CUSTOMER records (empty).

    - ```
      select * from CUSTOMER;
      Empty set (0.00 sec)
      ```

(2 Pts)


&nbsp;

---
### 3.) Challenge 3

Load the full data sets for customers, vehicles and reservations into the database:

- `data_customers.sql` with CUSTOMER data (200+ customer records),

- `data_vehicles.sql` with VEHICLE data,

- `data_reservations.sql` with RESERVATION data,

Count the number of customer and vehicle records:

```
mysql> select count(*) from customer;
+----------+
| count(*) |
+----------+
|      214 |
+----------+

mysql> select count(*) from vehicle;
+----------+
| count(*) |
+----------+
|      265 |
+----------+
```

(2 Pts)

&nbsp;

---
### 4.) Challenge 4
Running queries is a main use case for a database.

```
select * from CUSTOMER;
```

Output:

```
+-----+---------------------------------+--------------------+----------------+
| ID  | NAME                            | CONTACT            | STATUS         |
+-----+---------------------------------+--------------------+----------------+
|   1 | Meyer, Eric                     | eme22@gmail.com    | Active         |
|   2 | Sommer, Tina                    | 030 22458 29425    | Active         |
|   3 | Schulze, Tim                    | +49 171 2358124    | Active         |
|   4 | Landmann, Max                   | +49 030 8123524    | Terminated     |

...

| 211 | Rau, Engelbert                  | 0201 439580        | Active         |
| 212 | Klaus, Christos                 | 05341 48586        | Active         |
| 213 | Bauer, John                     | bauer200@gmail.com | Active         |
| 214 | Reuter, Birgitt                 | 04242 2025         | InRegistration |
+-----+---------------------------------+--------------------+----------------+
214 rows in set (0.00 sec)

```

1 . Find all Customers who are still in registration stage:
<!--
select * from customer where status='InRegistration';
-->
```
+-----+---------------------------+--------------+----------------+
| ID  | NAME                      | CONTACT      | STATUS         |
+-----+---------------------------+--------------+----------------+
|  13 | Noll, Willibald           | 04532 21619  | InRegistration |
|  30 | Hübner, Hanne             |              | InRegistration |
|  31 | Krug-Schreiber, Brunhilde | 08551 911757 | InRegistration |
|  63 | May, Maren                | 0941 22505   | InRegistration |
| 106 | Noack, Christiane         | 0841 7943737 | InRegistration |
| 214 | Reuter, Birgitt           | 04242 2025   | InRegistration |
+-----+---------------------------+--------------+----------------+
```

2 . Find all Customers who cannot make reservations since they have not
completed the regitration process or they have been terminated:
<!--
select * from customer where not status='Active';
-->
```
+-----+---------------------------+-----------------+----------------+
| ID  | NAME                      | CONTACT         | STATUS         |
+-----+---------------------------+-----------------+----------------+
|   4 | Landmann, Max             | +49 030 8123524 | Terminated     |
|   8 | Kühn-Fuchs, Sieglinde     | 037437 2550     | Terminated     |
|  13 | Noll, Willibald           | 04532 21619     | InRegistration |
|  30 | Hübner, Hanne             |                 | InRegistration |
|  31 | Krug-Schreiber, Brunhilde | 08551 911757    | InRegistration |
|  63 | May, Maren                | 0941 22505      | InRegistration |
|  95 | Falk, Hilde               | 0201 511353     | Terminated     |
| 106 | Noack, Christiane         | 0841 7943737    | InRegistration |
| 120 | Herold, Michel            | 09573 6369      | Terminated     |
| 128 | Witte, Helge              | 05321 80642     | Terminated     |
| 140 | Bock, Friedrich           | 0531 23627787   | Terminated     |
| 161 | Köhler, Detlev            | 089 54329790    | Terminated     |
| 209 | Lange, Patricia           | 02842 2258      | Terminated     |
| 214 | Reuter, Birgitt           | 04242 2025      | InRegistration |
+-----+---------------------------+-----------------+----------------+
14 rows in set (0.00 sec)
```

3 . Find all Customers with even ID in range 100 - 120:
<!--
select * from customer where MOD(ID, 2)=0 and ID >= 100 and ID <= 120;
-->
```
+-----+---------------------------+--------------+----------------+
| ID  | NAME                      | CONTACT      | STATUS         |
+-----+---------------------------+--------------+----------------+
| 100 | Pohl, Rüdiger             | 05733 2772   | Active         |
| 102 | Schaller, Theodor         | 0800 4555500 | Active         |
| 104 | Adam, Margrit             |              | Active         |
| 106 | Noack, Christiane         | 0841 7943737 | InRegistration |
| 108 | Wunderlich, Danny         |              | Active         |
| 110 | Falk, Janine              | 02104 76597  | Active         |
| 112 | Hentschel, Silvia         | 0871 9658680 | Active         |
| 114 | Herold, Kai-Uwe           | 02131 75250  | Active         |
| 116 | Kellner, Harald           | 0371 304193  | Active         |
| 118 | Singer-Hempel, Karl-Josef | 0170 8304083 | Active         |
| 120 | Herold, Michel            | 09573 6369   | Terminated     |
+-----+---------------------------+--------------+----------------+
```

4 . Find all Customers from Stuttgart (phone number starts with area code 0711,
[hint](https://stackoverflow.com/questions/14908142/sql-like-search-string-starts-with)
):
<!--
select * from customer where contact like '0711%';
-->
```
+-----+------------------------+------------------+--------+
| ID  | NAME                   | CONTACT          | STATUS |
+-----+------------------------+------------------+--------+
|  44 | Grossmann, Charlotte   | 0711 6402122     | Active |
|  76 | Reichel-Weiss, Eckhard | 0711 8875004     | Active |
| 142 | Schmidt, Stefan        | 0711 4569612     | Active |
| 170 | Conrad, Christian      | 0711 6599613     | Active |
| 171 | Scholz, Frank          | 0711 6783 ext. 3 | Active |
+-----+------------------------+------------------+--------+
```

5 . Find the customer ("owner") of reservation with ID: `145373`:
<!--
select customer.ID, customer.NAME, customer.CONTACT, customer.STATUS
    from customer, reservation
    where reservation.customer_id=customer.id and reservation.id=145373;
-->
```
+----+--------------+-----------------+--------+
| ID | NAME         | CONTACT         | STATUS |
+----+--------------+-----------------+--------+
|  2 | Sommer, Tina | 030 22458 29425 | Active |
+----+--------------+-----------------+--------+
1 row in set (0.00 sec)
```

6 . Find other reservations that customer has (leave out PICKUP, DROP locations):
<!--
select ID, CUSTOMER_ID, VEHICLE_ID, BEGIN, END
    from reservation
    where reservation.customer_id=2;
-->
```
+--------+-------------+------------+---------------------+---------------------+
| ID     | CUSTOMER_ID | VEHICLE_ID | BEGIN               | END                 |
+--------+-------------+------------+---------------------+---------------------+
| 145373 |           2 |       1009 | 2022-12-04 20:00:00 | 2022-12-04 23:00:00 |
| 351682 |           2 |       8000 | 2022-12-06 22:28:12 | 2022-12-07 00:28:12 |
| 382565 |           2 |       3000 | 2022-12-18 18:00:00 | 2022-12-18 18:10:00 |
| 682351 |           2 |       8001 | 2022-12-18 10:00:00 | 2022-12-18 16:00:00 |
+--------+-------------+------------+---------------------+---------------------+
4 rows in set (0.00 sec)
```


(2 Pts)

&nbsp;

---
### 5.) Challenge 5
Updating Data

(2 Pts)
