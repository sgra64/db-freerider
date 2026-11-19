## C1: Building a *Database*
<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
The exercise demonstates how to build a database with
[*MySQL*](https://dev.mysql.com/doc/refman/8.4/en/).

*MySQL* is a *client-server* database with the:

- MySQL database ***server process*** `mysqld` (*"d"* stands for *"daemon"*,
    the historically used name for permanent processes on a system waiting to
    serve requests -- today these processes are also called *"services"*).

    When started, the database server process listena at (default)
    ***TCP-Port:*** `3306`
    for incomming TCP-connection requests from client processes.

    Since client processes connect to the database server process over TCP/IP,
    they can be located at different machines, which is a difference to
    embedded databases (such as *h2*) that are embedded (part of) the application
    process.

- `mysql` is a command starting a ***client process*** connecting to the database
    server process *mysqld* and opening a session with the database or sending
    an SQL command to the *mysqld* server process.

    Many client processes can simultaneously have connections with the database
    server process. The server process executes incoming SQL operations
    simultaneously for best performance.

- Client processes connect over TCP to the database server process, which is
    listening at the (default) TCP port: `3306`.

- In the default configuration, the MySQL database server process stores the
    database in the file-system under ***path:*** `/var/lib/mysql`.

    Often, this path is *"mounted"* from an external ***volume*** such that the
    actual database state resides on that external volume (e.g. mounted
    from a storage [*RAID*](https://en.wikipedia.org/wiki/Standard_RAID_levels)
    array) and not in the local filesystem.

Setting up a MySQL database server can be done by

- a *local installation*, e.g. as descibed in
    [*"Chapter 2 Installing MySQL"*](https://dev.mysql.com/doc/refman/8.4/en/installing.html)
    or by

- a [*Virtual Machine Image (VMI)*](https://www.oracle.com/downloads/developer-vm/mysql-oem-vm-downloads.html)
    for *VirtualBox* or *VMWare* virtual machines (17 GB) or by

- creating a Docker Container based on a
    [*Docker MySQL image*](https://hub.docker.com/_/mysql)
    (750 MB) available in the central registry for docker images
    [*"docker-hub"*](https://hub.docker.com).

Here, the docker-container is used.


&nbsp;

Docker concepts:

- ***Docker Container*** -- a docker container is an *environment* in which
    processes run on a host system that is fully isolated from processes that
    run in other containers on the same host system.

    Docker containers can be in states: *ACTIVE* (at least one running process)
    or *STOPPED* (inactive, no running process).

- ***Docker image*** -- is (thin) layer containing files and directories that
    overlay files and directories from underlying images. The bottom layer of
    a *layered image stack* is formed by a *base image* that contains a
    (minimal) Unix system. Popular
    [*base images*](https://www.infoworld.com/article/3804073/4-tiny-docker-images-for-lightweight-containers.html) are: *Alpine* (5 MB), *BusyBox* (1-5 MB), *Debian Slim* (35.9 MB)
    and , *Red Hat UBI Micro/Minimal* (50-75 MB).

    The *MySQL* image is built on the
    [*oraclelinux:9-slim*](https://hub.docker.com/_/oraclelinux/tags)
    base image by Oracle (90 MB), see the
    [*Dockerfile*](https://github.com/docker-library/mysql/blob/ddb031e406121b1a298563775d521c044452a508/8.4/Dockerfile.oracle)
    that was used to build the *mysql*-image.

- ***Volume*** -- *logical disk* that is created and permanently exists outside
    a container that can be *mounted* into the container's filesystem under a
    specified path.

- ***Port Mapping*** -- maps a TCP-port from inside a container to a port on
    the host system (outside the container). No ports are mapped as default.


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

&nbsp;

---

Steps:

1. [Pull the *MySQL* Docker Image](#1-pull-the-mysql-docker-image)

1. [Create a Docker Container based on that Image](#2-create-a-docker-container-based-on-that-image)

1. [Attach Shell Process (*"log-into Container"*)](#3-attach-shell-process-log-into-container)

1. [*Log-into Database*](#4-log-into-database)

1. [Create a New Database](#5-create-a-new-database)

1. [*JOIN* Queries](#6-join-queries)

    - a) [*Cross Join*](#a-cross-join)

    - b) [*Inner Join*](#b-inner-join)

    - c) [*Outer Join (left, right)*](#c-outer-join-left-right)

    - d) [*Full Join*](#d-full-join)

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

&nbsp;

## 1. Pull the *MySQL* Docker Image

Pull image *mysql:8.4* from [*"docker-hub"*](https://hub.docker.com) into
the local image cache:

```sh
docker image pull mysql:8.4
```

When the pull occurs for the first time, output shows multiple image layers
are being pulled and assembled to the resulting image *mysql:8.4*:

```
8.4: Pulling from library/mysql
7a5e1e917526: Pull complete
54c71e5d2da5: Pull complete
57bd38a2d740: Pull complete
782c57ddb1a7: Pull complete
17ff14fd324e: Pull complete
e84ca20366cc: Pull complete
fea5342c4477: Pull complete
24b65e61bf70: Pull complete
9e2f31baa56a: Pull complete
f13e37513b38: Pull complete
Digest: sha256:5cdee9be17b6b7c804980be29d1bb0ba1536c7afaaed679fe0c1578ea0e3c233
Status: Downloaded newer image for mysql:8.4
docker.io/library/mysql:8.4
```

The new image should appear in *Docker Desktop* (under *"Container Images"*)
and can also be verified with:

```sh
docker image ls                 # show images from the local image cache
```
```
REPOSITORY         TAG       IMAGE ID       CREATED         SIZE
mysql              8.4       20d0be4ee452   2 weeks ago     810MB
```


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

&nbsp;

## 2. Create a Docker Container based on that Image

The command for creating a new Docker container named *"mysqld-container"* is
`run` (not *"create"*):

```sh
# create container named 'mysqld-container' from the image 'mysql:8.4'
docker run --name mysqld-container -d \
    -e MYSQL_ALLOW_EMPTY_PASSWORD=yes \
    -e MYSQL_ROOT_PASSWORD= \
    -p3306:3306 \
    mysql:8.4
```

Argument `-d` means the container launches the *mysqld* *"daemon"* process
waiting for connection requests from clients.

Two environment variables are set for the *mysqld* server process with `-e`
that permit access to the database with no (empty) password.

Argument `-p3306:3306` maps the TCP port *3306* (right), at which the *mysqld*
server process is listening inside the container, to TCP-port `3306` (left)
on the host system making the port accessible.

The last argument `mysql:8.4` refers to the image used to launch the container
containing the MySQL installation and the launch script for the *mysqld*
database server process.

After the command, the new container will appear in *Docker Desktop* with a
green light indicating the *mysqld* process is running.

Command `docker ps` shows active containers:

```sh
docker ps                       # show active containers (with at least one running process)
docker ps -a                    # show all containers (active and dormant)
```
```
CONTAINER ID   IMAGE       COMMAND                  CREATED          STATUS     PORTS                                         NAMES
500d67155d34   mysql:8.4   "docker-entrypoint.s…"   24 seconds ago   Up 23 seconds   0.0.0.0:3306->3306/tcp, [::]:3306->3306/tcp   mysqld-container
```

Containers are considered *"active"* when they have at least one active process.
*"Dormant"* containers exist as the configured environment, but have no active
process.

Show processes running inside a container:

```sh
docker top mysqld-container     # show processes running inside a container
```
```
UID    PID   PPID   CSTIME    TTY   TIME         CMD
999    537   514    1 Dec18    ?    00:00:34    mysqld      <-- 'mysqld' process running
root   857   514    0 00:03    ?    00:00:00    bash        <-- attached 'bash' process running
```

Stop container:

```sh
docker stop "mysqld-container"
```

Restart the container ()

```sh
docker start "mysqld-container"
```


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

&nbsp;

## 3. Attach Shell Process (*"log-into Container"*)

Docker has no concept of *"logging into"* a container. Instead, a new *shell*
process can be launched inside the container and connected (*"attached"*) to
an interactive terminal process (`-it`) running outside the container:

```sh
# launch 'bash' inside the container and attach the current terminal
docker exec -it "mysqld-container" bash
```

This command starts a new *bash* shell process and attaches the terminal
through its *stdin/stdout* channels. The prompt of the bash shell process
appears in the terminal. Commands can be entered and are executed by the
*bash* process running inside the container:

```
bash-5.1# 
```

This behavior makes the command appear like *"logging into a container"*.

Alternatively, *shell* processes can also be attached via the *VSCode Docker*
extension and also in *Docker Desktop* (little-three-dots -> Open-in-Terminal).


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

&nbsp;

## 4. *Log-into Database*

There is likely no *mysql* client program installed on your host system. It
can be installed, e.g. see
[*"Installing the MySQL Client"*](https://dev.mysql.com/doc/mysql-shell/9.5/en/mysql-shell-install-windows-quick.html),
but this not necessary since the *mysql* client program is part of the *MySQL*
image. Hence, one can use it from a *shell* process running inside the container:

```sh
mysql --version                     # show 'mysql' version
```
```
mysql  Ver 8.4.7 for Linux on x86_64 (MySQL Community Server - GPL)
```

One can also connect to the *mysqld* database server process (aka *"logging
into the database"*):

```sh
mysql --user=root                   # log into database as database-user 'root'

# or"
mysql -u root                       # log into database as database-user 'root'
```

The database responsds with:

```
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 8
Server version: 8.4.7 MySQL Community Server - GPL

Copyright (c) 2000, 2025, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> 
```

A first SQL command can be entered after the `mysql>` prompt (mind the trailing
semicolon `;`):

```sh
mysql> show databases;
```

The answer shows the databases that pre-exist in *MySQL*:

```
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.04 sec)
```

User and access information can be queried in the *"mysql"* table:

```sh
SELECT host, user, plugin FROM mysql.user;
```
```
+-----------+------------------+-----------------------+
| host      | user             | plugin                |
+-----------+------------------+-----------------------+
| %         | root             | caching_sha2_password |
| localhost | mysql.infoschema | caching_sha2_password |
| localhost | mysql.session    | caching_sha2_password |
| localhost | mysql.sys        | caching_sha2_password |
| localhost | root             | caching_sha2_password |
+-----------+------------------+-----------------------+
```


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

&nbsp;

## 5. Create a New Database

Create a new database named *"UNI"* and select this database:

```sh
mysql> create database UNI;             # create new database 'UNI'
mysql> use UNI;                         # select database
mysql> 
```

Create two tables *"PROFESSOR"* and *"STUDENT"* in the database:

```sql
CREATE TABLE PROFESSOR (
  `ID` int AUTO_INCREMENT,
  `NAME` varchar(60) DEFAULT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE STUDENT (
  `ID` int AUTO_INCREMENT,
  `NAME` varchar(60) DEFAULT NULL,
  PRIMARY KEY (ID)
);

SHOW TABLES;
```
```
+---------------+
| Tables_in_UNI |
+---------------+
| PROFESSOR     |
| STUDENT       |
+---------------+
2 rows in set (0.01 sec)
```

Insert data records into the database:

```sql
START TRANSACTION;

INSERT INTO PROFESSOR (NAME) VALUES
    ('Graupner'),
    ('Meyer'),
    ('Lohmann');

INSERT INTO STUDENT (NAME) VALUES
    ('Brinkmann, C.'),
    ('Akyil, B.'),
    ('Albaryak, K.'),
    ('Bernier, A.'),
    ('Blenau, H.'),
    ('Bui, P.');

COMMIT;
```

Answer questions:

1. What does `START TRANSACTION;` and `COMMIT;` achieve?

1. What is the difference of the commands above to the following command?

    ```sql
    INSERT INTO PROFESSOR (NAME) VALUES ('Graupner');
    INSERT INTO PROFESSOR (NAME) VALUES ('Meyer');
    INSERT INTO PROFESSOR (NAME) VALUES ('Lohmann');
    ```

1. What could happen when *Data Load* is not executed *"as a transaction"*?


&nbsp;

Run basic queries:

```sql
SELECT * FROM PROFESSOR;
```
```
+----+----------+
| ID | NAME     |
+----+----------+
|  1 | Graupner |
|  2 | Meyer    |
|  3 | Lohmann  |
+----+----------+
3 rows in set (0.00 sec)
```

```sql
SELECT * FROM STUDENT WHERE NAME in ('Bernier, A.', 'Blenau, H.');
```
```
+----+-------------+
| ID | NAME        |
+----+-------------+
|  4 | Bernier, A. |
|  5 | Blenau, H.  |
+----+-------------+
2 rows in set (0.00 sec)
```


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

&nbsp;

## 6. *JOIN* Queries
<!-- 
Create a new database *"JOIN_DB"* and run the examples for *JOIN* queries:
[*https://en.wikipedia.org/wiki/Join_(SQL)*](https://en.wikipedia.org/wiki/Join_(SQL))

Understand:

- *Cross JOIN*,

- *Inner JOIN*,

- *Outer JOIN* (left, right). -->


Build another database *"Employees"* from the
[*example*](https://en.wikipedia.org/wiki/Join_(SQL))
demonstrating the use of *SQL JOIN* queries.

Create tables: *"department"* and *"employee"* as shown in the example.
Fill in sample data.

Run queries:

```sql
SELECT * FROM employee;
SELECT * FROM department;
```

```
mysql> SELECT * FROM employee;          mysql> SELECT * FROM department;
+------------+--------------+           +--------------+----------------+
| LastName   | DepartmentID |           | DepartmentID | DepartmentName |
+------------+--------------+           +--------------+----------------+
| Rafferty   |           31 |           |           31 | Sales          |
| Jones      |           33 |           |           33 | Engineering    |
| Heisenberg |           33 |           |           34 | Clerical       |
| Robinson   |           34 |           |           35 | Marketing      |
| Smith      |           34 |           +--------------+----------------+
| Williams   |         NULL |           4 rows in set (0.00 sec)
+------------+--------------+
6 rows in set (0.01 sec)
```


### a) *Cross Join*

The full *cross-join* (*cross product* or
[*cartesian product*](https://en.wikipedia.org/wiki/Cartesian_product))
combines attributes (columns) of both tables and each line of the first table
with each line of the second table (rows).

```sql
-- CROSS JOIN creates full cross product (carthesian product) of the two tables
SELECT * FROM employee CROSS JOIN department;
SELECT * FROM employee, department;
```

*Cross join* does not connect attributes (columns) and always spawns the
full table. Rows can be selected with WHERE.

*Inner join* connect attributes (columns) from both tables, e.g. attribute
*DepartmentID* to only include matching rows, in the example *departments*
in which *employees* are working (omitting none-mathching rows).

Queries yield output of the full *cross product* of the two tables.

```
+------------+--------------+--------------+----------------+
| LastName   | DepartmentID | DepartmentID | DepartmentName |
+------------+--------------+--------------+----------------+
| Rafferty   |           31 |           35 | Marketing      |
| Rafferty   |           31 |           34 | Clerical       |
| Rafferty   |           31 |           33 | Engineering    |
| Rafferty   |           31 |           31 | Sales          | <-- matching DepartmentId
| Jones      |           33 |           35 | Marketing      |     (33=33)
| Jones      |           33 |           34 | Clerical       |
| Jones      |           33 |           33 | Engineering    | <-- matching DepartmentId
| Jones      |           33 |           31 | Sales          |     (33=33)
| Heisenberg |           33 |           35 | Marketing      |
| Heisenberg |           33 |           34 | Clerical       |
| Heisenberg |           33 |           33 | Engineering    | <-- matching DepartmentId
| Heisenberg |           33 |           31 | Sales          |     (33=33)
| Robinson   |           34 |           35 | Marketing      |
| Robinson   |           34 |           34 | Clerical       | <-- matching DepartmentId
| Robinson   |           34 |           33 | Engineering    |     (34=34)
| Robinson   |           34 |           31 | Sales          |
| Smith      |           34 |           35 | Marketing      |
| Smith      |           34 |           34 | Clerical       | <-- matching DepartmentId
| Smith      |           34 |           33 | Engineering    |     (34=34)
| Smith      |           34 |           31 | Sales          |
| Williams   |         NULL |           35 | Marketing      |
| Williams   |         NULL |           34 | Clerical       |
| Williams   |         NULL |           33 | Engineering    |
| Williams   |         NULL |           31 | Sales          |
+------------+--------------+--------------+----------------+
24 rows in set (0.00 sec)
```


### b) *Inner Join*

The *"explicit join notation"* uses the *JOIN* keyword, optionally preceded
by the *INNER* keyword, to specify the table to join, and the *ON* keyword
to specify the predicates for the join, as in the following example:

```sql
-- INNER JOIN selects rows of matching linkage attributes from both tables
-- explicit join notation linking both tables via 'DepartmentID'
SELECT * FROM employee INNER JOIN department ON
    employee.DepartmentID = department.DepartmentID;

-- equi-join notation omits 'INNER'
SELECT * FROM employee JOIN department ON
    employee.DepartmentID = department.DepartmentID;
```

The *"implicit join notation"* replaces: `FROM employee INNER JOIN department ON`
with listing both (or more) tables after FROM: `FROM employee, department` and
using a regular WHERE clause to specify the join condition (the linkage
between the tables):

```sql
-- implicit join notation lists tables after FROM and links tables with WHERE clause
SELECT * FROM employee, department
    WHERE employee.DepartmentID = department.DepartmentID;
```

Both queries show only rows with matching *DepartmentID* from both tables:

```
+------------+--------------+--------------+----------------+
| LastName   | DepartmentID | DepartmentID | DepartmentName |
+------------+--------------+--------------+----------------+
| Rafferty   |           31 |           31 | Sales          |
| Jones      |           33 |           33 | Engineering    |
| Heisenberg |           33 |           33 | Engineering    |
| Robinson   |           34 |           34 | Clerical       |
| Smith      |           34 |           34 | Clerical       |
+------------+--------------+--------------+----------------+
5 rows in set (0.00 sec)
```

Further variations of joins are *"equi-join"* and *"natural join"* that
consolidate the linkage attributes from both tables into one attribute,
here *DepartmentID*.

*"Natural join"* is a special form of an *"equi-join"* with implicit
matching of column names to link tables.

```sql
-- equi-join notation with 'USING'
SELECT * FROM employee JOIN department USING (DepartmentID);

-- natural join notation with implicit column name matching between tables
SELECT * FROM employee NATURAL JOIN department;
```

Output shows one consolidated *DepartmentID* column:

```
+--------------+------------+----------------+
| DepartmentID | LastName   | DepartmentName |
+--------------+------------+----------------+
|           31 | Rafferty   | Sales          |
|           33 | Jones      | Engineering    |
|           33 | Heisenberg | Engineering    |
|           34 | Robinson   | Clerical       |
|           34 | Smith      | Clerical       |
+--------------+------------+----------------+
5 rows in set (0.00 sec)
```


### c) *Outer Join (left, right)*

*"Outer Join"* considers the case of none-matching linkeage attributes,
which are omitted in the resulting table for *inner joins*.
*Outer joins* retain such rows and further subdivide into *"left joins"*
(rows from the left table with none-matching attributes are included) and
*"right joins"* (rows from the right table are included accordingly).

In the example, employee *Williams* has no valid *DepartmentId* (NULL)
and hence was excluded in *"inner joins"* before.

```sql
-- Left-outer-join includes rows from the left table with none-matching
-- linkeage attributes
SELECT * FROM employee LEFT OUTER JOIN department ON
    employee.DepartmentID = department.DepartmentID;
```

Output shows the row of employee Williams with a none-matching linkeage
attribute (NULL) from the left table (employee) included with attributes
from the right table filled with NULL:

```
+------------+--------------+--------------+----------------+
| LastName   | DepartmentID | DepartmentID | DepartmentName |
+------------+--------------+--------------+----------------+
| Rafferty   |           31 |           31 | Sales          |
| Jones      |           33 |           33 | Engineering    |
| Heisenberg |           33 |           33 | Engineering    |
| Robinson   |           34 |           34 | Clerical       |
| Smith      |           34 |           34 | Clerical       |
| Williams   |         NULL |         NULL | NULL           | <-- include 'Williams'
+------------+--------------+--------------+----------------+     from left table
6 rows in set (0.00 sec)
```

Similarly, a *"right outer join"* fills in rows from the right table
with no matches in likeage attributes. In the example, department
*Marketing* was not matched by any employee record.

```sql
-- Right-outer-join includes rows from the right table with none-matching
-- linkeage attributes
SELECT * FROM employee RIGHT OUTER JOIN department ON
    employee.DepartmentID = department.DepartmentID;
```

```
+------------+--------------+--------------+----------------+
| LastName   | DepartmentID | DepartmentID | DepartmentName |
+------------+--------------+--------------+----------------+
| Rafferty   |           31 |           31 | Sales          |
| Heisenberg |           33 |           33 | Engineering    |
| Jones      |           33 |           33 | Engineering    |
| Smith      |           34 |           34 | Clerical       |
| Robinson   |           34 |           34 | Clerical       |
| NULL       |         NULL |           35 | Marketing      | <-- include 'Marketing'
+------------+--------------+--------------+----------------+     from right table
6 rows in set (0.01 sec)
```


### d) *Full Outer Join*

Finally, a *"full outer join"* includes rows from both tables
with no matches in likeage attributes.

```sql
-- Full-outer-join includes rows from the both tables with none-matching
-- linkeage attributes (MySQL does not support full-outer-join syntax)
SELECT * FROM employee FULL OUTER JOIN department ON
  employee.DepartmentID = department.DepartmentID;

-- emulated full-outer-join as UNION of left- and right-outer joins
SELECT * FROM employee
  LEFT JOIN department ON employee.DepartmentID = department.DepartmentID
  UNION
  SELECT * FROM employee
  RIGHT JOIN department ON employee.DepartmentID = department.DepartmentID;
```

```
+------------+--------------+--------------+----------------+
| LastName   | DepartmentID | DepartmentID | DepartmentName |
+------------+--------------+--------------+----------------+
| Rafferty   |           31 |           31 | Sales          |
| Jones      |           33 |           33 | Engineering    |
| Heisenberg |           33 |           33 | Engineering    |
| Robinson   |           34 |           34 | Clerical       |
| Smith      |           34 |           34 | Clerical       |
| Williams   |         NULL |         NULL | NULL           | <-- include 'Williams'
| NULL       |         NULL |           35 | Marketing      | <-- include 'Marketing'
+------------+--------------+--------------+----------------+
7 rows in set (0.00 sec)
```

