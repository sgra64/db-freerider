## Assignment DB: Build FREERIDER_DB Database (MySQL)

The assignment will build a [*MySQL*](https://en.wikipedia.org/wiki/MySQL)
Database for the *freerider* car-sharing reservation service using Docker.

The [*Entity-Relationship Diagram*](https://en.wikipedia.org/wiki/Entity%E2%80%93relationship_model#Components)
shows the schema of the *freerider* database:

<img src="https://github.com/sgra64/docker/blob/markup/DB12-freerider/freerider_ERD.png?raw=true" alt="drawing" width="600"/>

---

### Steps

- DB.1: [Databases Recap](#db1-databases-recap) - (3 Pts)

    - Know basic database concepts:
        *Entity*, *Relation*, *Primary Key*, *Foreign Key*,
        *Cardinalities ( 1 : n, n : 1, n : m )*,
        *ER-Diagram (crow foot notation)*,

    - *Database Schema*, *Database Data*,
        *Database Queries*, *Join Queries (see DB.4)*, *Result Set*,
        *Schema Load*, *Data Load*,
        
    - *Insert*, *Update*, *Transaction*, *ACID Properties*. 

- DB.2: [Build the *MySQL* Database Server](#db2-build-the-mysql-database-server) - (3 Pts)

- DB.3: [Build a Simple Database](#db3-build-a-simple-database) - (1 Pts)

- DB.4: [*JOIN* Queries in Databases](#db4-join-queries-in-databases) - (1 Pts)

    - a) [*Cross Join*](#a-cross-join)

    - b) [*Inner Join*](#b-inner-join)

    - c) [*Outer Join (left, right)*](#c-outer-join-left-right)

    - d) [*Full Join*](#d-full-join)

- DB.5: [Build the *FREERIDER_DB* Database](#db5-build-the-freerider_db-database) - (4 Pts)


&nbsp;

### DB.1) Databases Recap

The [*Relational Data Model*](https://en.wikipedia.org/wiki/Relational_model)
was developer by English computer scientist
[*Edgar F. Codd*](https://en.wikipedia.org/wiki/Edgar_F._Codd) at IBM in 1969
and published in a paper: *"A Relational Model of Data for Large Shared Data
Banks"*, *Communications of the ACM*, June 1970.
It assumes all data is represented as *Tuples* (tables) and *Relations* based
on a mathematical model of
[*Relational Algebra*](https://en.wikipedia.org/wiki/Relational_algebra).

The *"Structured English Query Language (SEQUEL)"* was developed by IBM
Corporation based on that model. *SEQUEL* later became *"SQL"* (still
pronounced *"sequel"*).
In 1979, *Oracle* introduced the first commercially available implementation
of SQL, which became the foundation of the *Oracle Database*.

[*MySQL*](https://en.wikipedia.org/wiki/MySQL) is the second most popular
[*Relational Database Management System*](https://en.wikipedia.org/wiki/Relational_database)
(RDBMS), see [market shares](https://db-engines.com/en/ranking).

The [*Standard Query Language (SQL)*](https://www.w3schools.com/sql)
has been the standard language to define data and to perform operations in
relational databases since.

A **Relational Database** organizes data as tables, often also referred to
as *Entities* and *Relations*.

- An **Entity** in general is a *data object stored in a database*.

    - Examples of *entities* are *Customer* objects (rows, tuples) for
        *Eric*, *Tim* or *Tina*.

- Databases also store **Relations** to represent how *Entities* are related.

    - An example of a *relation* is between a *Customer* and the *Accounts*
        owned by that *Customer*.

- *Entities of the same type* (with same attributes) are stored in a **Table**
    with attributes (colums) describing the data stored for each *entity* as
    row or tuple in a table.

    - For example, all *Customer* entities are stored in a table *Customer*
        with attributes:

        - ID: INT (primary key), NAME: VARCHAR(36) and CONTACT: VARCHAR(60).

- *Relations* are stored as **Foreign Key** attributes, either as part of an
    *Entity Table* for cardinalities *1 : 1* or *1 : n* or factored out into
    a separate *Relationship Table* to represent an *n : m* relation between
    two entity tables.

    - For example, the *Account* table may have a *Customer.ID* foreign key
        attribute linking each *Account* entity to the *"owning"* *Customer*
        entity (case of a *1 : n* relation between *Customer* and *Account*).

    - In case of *n : m* *"shared accounts"* when multiple *Customers* (e.g.
        family members) can use one *Account* or may also have multiple
        *Accounts*, a separate relation table: *Customer_Account* must be
        created that stores foreign keys pointing at *Customer* and *Account*
        entities in respective tables.

- **Cardinalities** (number categories) define groups of multiplicities (how
    many may or must exist) at each side of a relation:

    - **[ 1 ]** - *"exactly one"* entity must exist (default in UML).

        - For example, a *Customer* must have exactly one *Account*. The
            number of *Accounts* matches the number of *Customers*. There is
            no *Customer* with no *Account*.

    - **[ 0..1 ]** - optional entity, which may be present *"at most once"*.

        - For example, if a *Customer* may or may not have an (one) *Account*.

    - **[ 0..n ]** or **[ n ]** or **[ * ]** - multiple entities including
        *"none"* ( *n >= 0* ).

        - For example, if a *Customer* may have multiple (including none)
            *Accounts* (there may be *Customers* with no *Accounts*).

    - **[ 1..n ]** or **[ + ]** - *"at least one"* entity must must be present
        ( *n > 0* ).

        - For example, if a *Customer* can have multiple *Accounts*, but must
            have at least one *Account* (there is no *Customer* with no
            *Account*).

            <img src="https://i.sstatic.net/rb3Ig.jpg" alt="drawing" width="240"/>


- A **Key** is an attribute (or a group of attributes) in a table that uniquely
    identifies each entity stored in a row.
    
    - **Primary-Key** is a single attribute often named *"ID"* that uniquely
        identifies entities stored in the table.

    - Entity Tables usually have one *Primary-Key* attribute (although this is
        not enforced) of a *Numbers* type (e.g. INT, preferred) or a String
        type ( VARCHAR ).

    - **Foreign-Key** is an attribute in one table linked to a *Primary-Key* in
        another table.

- A **Database Schema** is the definition of the *Data Model* stored in a
    database with definitions of *tables* with *attributes*, *primary* and
    *foreign keys*.

    - *Database schema* are defined through:

        - [*SQL Data Definition Statements*](https://dev.mysql.com/doc/refman/8.4/en/sql-data-definition-statements.html) such as *CREATE TABLE( ... )* .

        - or graphically as *Entity-Relationship Diagrams (ERD)*. Peter Chen's
            original
            [*1967 ERD*](https://en.wikipedia.org/wiki/Entity-relationship_model)
            with entity names in small boxes surrounded by circles for attributes
            should no longer be used.

            Instead,
            [*Crow foot notation*](https://vertabelo.com/blog/crow-s-foot-notation)
            (Gordon Everest, Fifth IEEE Computing Conference 1976) should be used.
            It is closer aligned to the more contemporary
            [UML Class Diagram](https://en.wikipedia.org/wiki/Class_diagram).

- A **Transaction** in databases is a *"logical unit of work"* that produces a
    desired result and is either fully executed or has no effect.

    - *Read-transactions* (*SELECT queries*) do not change data.

    - *Write-transactions* (*INSERT, UPDATE, DELETE*) change data.

    - *Singular SQL-statements* are always executed as transactions (fully or
        with no effect).

    - *Multiple SQL-statements* can be combined into transations using
        `START TRANSACTION`, `COMMIT` and `ROLLBACK` (see statements for
        [*SQL Transactions*](https://dev.mysql.com/doc/refman/8.0/en/commit.html)).

- **ACID** properties of *Transactions*:

    - *(A) Atomicity* -- an operation is either fully executed or not at all, which
        means nothing has changed (no side effects or partial data changes).
        Atomicity is guaranteed by the database for single SQL operations. For
        multiple operations, it must be guaranteed by wrapping operations as
        transactions.

    - *(C) Consistency* -- assurance that data is kept free of contradictions
        before and after transactions. Examples of contradictions are: same *ID*
        used for different data objects, NULL *ID*, *FOREIGN-KEYS* with invalid
        or dangling values (no corresponding referenced object).
        Consistency rules are described as *CONSTRAINTS* in SQL schema.

    - *(I) Isolation* -- assurance that concurrent or interleaved execution of
        transactions produces repeatable results expected by each transaction.

    - *(D) Durability* -- assurance that data is safely stored as result of a
        transaction until explicitely deleted.


&nbsp;

DB.1) Questions, tasks:

1. Write one sentence in your own words for each bold-marked term above.

1. Draw a (crow-foot) ERD that shows that a reservation can be paid in multiple
    installments (payments). For example, Eric has reserved a car for a week
    on Mallorca that costs 786€. Eric pays in three installments: 200€ upfront,
    550€ at pickup at the airport and the remaining 36€ for tolls and parking
    two weeks after return.

1. Define a query that lists Eric's payments for that reservation.

1. What is a [*JOIN*](https://en.wikipedia.org/wiki/Join_(SQL)) operation?

1. What is the difference between *"implicit"* and *"explicit"* JOIN?
    Which should be preferred?



&nbsp;
---
### DB.2) Build the *MySQL* Database Server

Most *Database Management Systems (DBMS)* use a
[*Client-Server Model*](https://www.geeksforgeeks.org/client-server-model/),
also *MySQL:*

- A *server process* called *mysqld* runs on a server machine or in a
    Docker container. The machine or the container can be reached over
    that network and may not be located on your laptop.

  The *d* in *mysqld* stands for *daemon*-process, which is in Unix a
    continuously running process.
    
- Process *mysqld* continuously expects requests arriving at TCP-port
    [3306](https://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers)
    (default).

- Client processes such as the command-line client: *mysql* (no *d*) send
    database requests (SQL statements) to port `3306` where the server
    process *mysqld* must be listening.

    The server process *mysqld* answers SQL requests and sends the
    *"Result Set"* back to the client in form of a table. The client *mysql*
    then outputs the result in the terminal.

*Building a database* means to install and configure the *mysqld* server
software on a machine or in a container and configure the *mysqld* server.
[*Manually installing MySQL*](https://dev.mysql.com/doc/refman/8.4/en/installing.html)
is not trivial depending on the target system.

Docker images are a convenient alternative and can be found in the global
Docker registry under tag: [*mysql*](https://hub.docker.com/_/mysql).
Based on that image, a container can be launched with a working *MySQL* database.

The following command pulls image `mysql:8.4` from the Docker registry and
creates a container named: `mysqld-container` that runs a *mysqld* server process
inside: 

```sh
# create transient container named 'mysqld' from image 'mysql:8.4'
docker run --name mysqld-container -d \
    -e MYSQL_ALLOW_EMPTY_PASSWORD=yes \
    -e MYSQL_ROOT_PASSWORD= \
    -p3306:3306 \
    mysql:8.4
```

Show the *mysqld* container is running:

```sh
docker ps       # show container is running
```
```
CONTAINER ID   IMAGE       CREATED     STATUS   PORTS                    NAMES
ea6cbabc15a7   mysql:8.4   a min ago   Up       0.0.0.0:3306->3306/tcp   mysqld-container
```

Show the running processes inside container including process *mysqld:*

```sh
# show running processes inside container (including process 'mysqld')
docker top mysqld-container
```
```
UID            PID         PPID        C
STIME          TTY         TIME        CMD
19:15          ?           00:00:07    mysqld  <-- mysqld process
19:20          ?           00:00:00    bash
```

Start a new *bash* process in the container and *"attach"* its &lt;stdin&gt; /
&lt;stdout&gt; (input/output) to the terminal:

```sh
docker exec -it mysqld-container bash
```
The prompt `bash-5.1#` of the *bash* process running inside the container appears:

```sh
bash-5.1# whoami
root
bash-5.1# pwd
/
bash-5.1# ls -la
...
```

Inside the container, the client-program *mysql* is available that can
be used to connect to the *mysqld* database server process:

```sh
bash-5.1# mysql --user=root     # log into the database server as user 'root'
```
```
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 9
Server version: 8.4.0 MySQL Community Server - GPL

Copyright (c) 2000, 2024, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
```

SQL commands can be typed at the `mysql>` prompt (mind the `;` at the end
of each SQL statement):

```sh
mysql> show databases;
```

Only system databases are shown, there is no other database yet:

```
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.00 sec)
```

User and access information can be queried in the `mysql` table:

```sh
mysql> SELECT host, user, plugin FROM mysql.user;
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
5 rows in set (0.00 sec)
```



&nbsp;

### DB.3) Build a Simple Database

Create a new database `UNI`, switch to this database and create two
tables `PROFESSOR` and `STUDENT`:

```sh
mysql> create database UNI;
mysql> use UNI;
mysql> 
```

Tables can now be created and records filled in:

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

show tables;

INSERT INTO PROFESSOR (NAME) VALUES
    ('Graupner'), ('Meyer'), ('Lohmann')
;
INSERT INTO STUDENT (NAME) VALUES
    ('Brinkmann, C.'), ('Akyil, B.'), ('Albaryak, K.'), ('Bernier, A.'), ('Blenau, H.'), ('Bui, P.')
;
```

SQL-queries:

```sh
mysql> select * from PROFESSOR;
```
```
+----+----------+
| ID | NAME     |
+----+----------+
|  1 | Graupner |
|  2 | Meyer    |
|  3 | Lohmann  |
+----+----------+
```

```sh
mysql> select * from STUDENT;
```
```
+----+---------------+
| ID | NAME          |
+----+---------------+
|  1 | Brinkmann, C. |
|  2 | Akyil, B.     |
|  3 | Albaryak, K.  |
|  4 | Bernier, A.   |
|  5 | Blenau, H.    |
|  6 | Bui, P.       |
+----+---------------+
6 rows in set (0.00 sec)
```

<!-- Extend the database to store that:
- `Prof. Graupner` has students: `1, 3, 5, 2, 4, 6`
- `Prof. Meyer` has students: `2, 4, 6`
- `Prof. Lohmann` has students: `3, 4, 6, 1`
```sql
CREATE TABLE PROFESSOR_STUDENT (
  `ID` int AUTO_INCREMENT,
  `PROFESSOR_ID` int NOT NULL,
  `STUDENT_ID` int NOT NULL,

  PRIMARY KEY (ID),
  CONSTRAINT PROFESSOR_ID FOREIGN KEY (PROFESSOR_ID) REFERENCES PROFESSOR (ID),
  CONSTRAINT STUDENT_ID FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT (ID)
);
INSERT INTO PROFESSOR_STUDENT (PROFESSOR_ID, STUDENT_ID) VALUES
    (1, 1), (1, 3), (1, 5), (1, 2), (1, 4), (1, 6),
    (2, 1), (2, 1), (2, 1),
    (3, 3), (3, 4), (3, 6), (3, 1);
```
Run a query that shows all students (names) of `Prof. Meyer`.
Select STUDENT.NAME FROM STUDENT WHERE STUDENT.ID=PROFESSOR_STUDENT.STUDENT_ID
AND PROFESSOR.NAME='Prof. Meyer';

Select STUDENT.NAME FROM STUDENT
INNER JOIN PROFESSOR_STUDENT ON PROFESSOR_STUDENT.STUDENT_ID=STUDENT.ID
INNER JOIN PROFESSOR_STUDENT ON PROFESSOR_STUDENT.PROFESSOR_ID=PROFESSOR.ID
-->

Database servers should be properly shut down from the server (not by stopping
the container) such that the server has a chance to write caches back to storage:

```sh
mysql> shutdown;
```

The command shuts down the database server, which in turn stops the container
if 'mysqld' was the last active process in the container.
<!-- (which was created as a *transient container* with `--rm`). -->



&nbsp;

### DB.4) *JOIN* Queries in Databases

Build a new database *"Employees"* from the
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



&nbsp;

### DB.5) Build the *FREERIDER_DB* Database

This part of the assignment demonstrates how to *"build a database"*, including

- the **Database Server** process named *"mysqld"* that is running in a

  - *Container* named *"freerider-db"* based on a

  - *Customized image* named *"freerider-db-img:0.8"*,

    - built based on an underlying image
        [*"mysql:8.4"*](https://hub.docker.com/_/mysql),
        see also
        [*MySQL8.4 Release notes*](https://dev.mysql.com/doc/relnotes/mysql/8.4/en/) pulled from the registry
        [*Docker Hub*](https://hub.docker.com/)
        and a dedicated

  - *Volume* named *"freerider-db-vol"*
    - that stores the database data.

- A second part of the *"database build"* is the creation of the database
    *"FREERIDER_DB"* itself inside the *Database Server* with:

  - *Access (log-in) information* for a user *"freerider"* to access the
    database, the

  - *Schema* for the database with definitions of tables and some

  - *Initial Database Data*.


### Steps

1. [*Create Volume to hold Database Data*](#db-51-create-volume-to-hold-database-data)

1. [*Create Image for Database Container*](#db-52-create-image-for-database-container)

1. [*Create Database Container*](#db-53-create-database-container)

1. [*Database Lifecycle (start, stop)*](#db-54-database-lifecycle-start-stop)

1. [*Schema Load*](#db-55-schema-load)

1. [*Data Load*](#db-56-data-load)



&nbsp;

### DB 5.1) *Create Volume to hold Database Data*

Processes running in containers only see the filesystem presented to them in
the container through the stack of images based on which the container was
created. These images are *read-only*, except for the top-image that is
attached to the container and *writable*.

When processes such as *mysqld* write files, those writes are made to the
top-image only. The top-image is bound to the container, which means, it
disappears when the container is removed.

Containers are meant to be transient and replaceable constructs that can be
deleted, rebuild and redeployed at any time. Therefore,
[*containers should not hold state (data)*](https://developers.redhat.com/blog/2016/02/24/10-things-to-avoid-in-docker-containers)
and permanent data be stored outside the container.

Docker introduces
[*Docker Volumes*](https://docs.docker.com/engine/storage/volumes/)
as *"storage facilities"* outside containers and a mechanism of
[*Mounts*]()
to attach volumes to containers. Inside a container, storage from a mounted
volume appears under a certain file system path, e.g. under path
`/var/lib/mysql`, which is also called a *"mount point"*.
Files and directories passed that path are not part of the regular filesystem
created from the image stack of the container. Those files and directories
actually reside outside in the mounted volume.
The concept of *"mountable filesystems"* has been introduced in Unix early on.

*Volumes* can reside anywhere such as in the host system's filesystem or on a
separate diskon your laptop. *Volumes* may also exist in dedicate storage
devices such as
[*RAID arrays*](https://en.wikipedia.org/wiki/RAID) or can be provided as
[cloud storage](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Storage.html)
mounted over the network.

Docker supports two types of mounts:

- [*Bind mounts*](https://docs.docker.com/storage/bind-mounts) connect a path
    of the host system's filesystem to the mount point in the container.
    Files and directories from the host file system are visible inside the
    container under the mount point and, if mounted with read-write permission,
    can be altered by container processes.

    A problem with *Bind mounts* is when the host file system is of different
    type as the filesystem inside the container, e.g. when the container
    filesystem is a Unix-type filesystem and the host-filesystem is *NTFS*
    (Windows). Attemting to *mount incompatible filesystems* may fail or cause
    problems and therefore is not recommended.

- [*Volume mounts*](https://docs.docker.com/storage/volumes) attach an existing
    volume (created separately) to the container making its content accessible
    under the mount point in the container.

    There is the assumption that the filesystem of the volume is compatible
    to the container filesystem. Is the volume created, e.g. as a file in NTFS,
    its internal structure can hold a Unix filesystem. NTFS, in this case, only
    sees a BLOB (binary file).

Creating a new (empty) volume with an internal Unix filesystem is simple:

```sh
# create volume named 'freerider-db-vol' to store the FREERIDER_DB database data
# outside the container
docker volume create "freerider-db-vol"
```

Verify the new volume exists in Docker Desktop's Volume view and with:

```sh
docker volume ls                # list (ls) existing volumes
```
```
DRIVER    VOLUME NAME
local     freerider-db-vol      <-- new volume
```

More detail can be leared about the new volume:

```sh
docker volume inspect "freerider-db-vol"
```

The volume name can be used in a *Volume mount* when a container is created:
`freerider-db-vol:/var/lib/mysql`, which means that the created volume
(*"freerider-db-vol"*) will be mounted inside the container under the path:
*"/var/lib/mysql"*.



&nbsp;

### DB 5.2) *Create Image for Database Container*

Next, the image for the container running *mysqld* is created using a
[*Dockerfile*](Dockerfile), which must exist (under this name) in the project
directory:

```dockerfile
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Dockerfile is used to create a docker image:
# - docker build -t freerider-db-img:0.8 --no-cache -f Dockerfile .
# - docker image rm -f freerider-db-img:0.8
# - docker volume create freerider-db-vol
# 
# Create and start container:
# - docker run --name freerider-db -d -p 3306:3306 \
#       -v freerider-db-vol:/var/lib/mysql freerider-db-img:0.8
# 
# Attach 'bash' process in running container (log into container)
# - docker exec -it "freerider-db" /bin/bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# 
# MySQL:8.4 is the base image for the image created with this Dockerfile
# FROM docker.io/mysql:8.4
FROM mysql:8.4

# define environment variables for 'mysqld' process started by the container
ENV MYSQL_NATIVE_PASSWORD="ON"
ENV MYSQL_ALLOW_EMPTY_PASSWORD="yes"
ENV MYSQL_ROOT_PASSWORD=""

# pass login data to 'mysql'-client in container as environment variables
# data can be passed alternatively through file 'access.sql' below
ENV MYSQL_DATABASE="FREERIDER_DB"
ENV MYSQL_USER="freerider"
ENV MYSQL_PASSWORD="free.ride"

# define 'db_init.sql' file inside the container image that is interpreted
# by the 'mysqld' process
ARG DB_INIT_FILE=/docker-entrypoint-initdb.d/db_init.sql

# copy init files into the created image under path '/tmp' (in the image)
# include 'access.sql' only when login 'MYSQL_' env variables are not used
# COPY init-db/access.sql /tmp
COPY init-db/freerider-init-schema.sql /tmp
COPY init-db/freerider-init-data.sql /tmp

# aggregate init files in 'db_init.sql' that is interpreted by 'mysqld'
# RUN cat /tmp/access.sql            > $DB_INIT_FILE
RUN cat /tmp/freerider-init-schema.sql >> $DB_INIT_FILE
RUN cat /tmp/freerider-init-data.sql   >> $DB_INIT_FILE
```

The new image *"freerider-db-img:0.8"* created from the *Dockerfile* is based
on the image [*"mysql:8.4"*](https://hub.docker.com/_/mysql), see also
[*MySQL8.4 Release notes*](https://dev.mysql.com/doc/relnotes/mysql/8.4/en/)
pulled from the registry [*Docker Hub*](https://hub.docker.com/).

Create the image *"freerider-db-img:0.8" :*

```sh
# create image for the database container using 'Dockerfile'
docker build -t "freerider-db-img:0.8" --no-cache -f Dockerfile .
```

The [*logs/docker-build.log*](logs/docker-build.log) shows the log of the build operation.

Verify the new image exists in Docker Desktop's Image view and with:

```sh
docker image ls                 # list (ls) existing volumes
```
```
REPOSITORY         TAG       IMAGE ID       CREATED        SIZE
freerider-db-img   0.8       43bb22c1112a   31 hours ago   777MB  <-- new image
mysql              8.4       8f360cd2e6e4   8 weeks ago    777MB  <-- underlying base image
```

More detail can be printed using the image id:

```sh
docker image inspect 43bb22c1112a
```

<!-- ```
[+] Building 0.0s (0/0)  docker:default
2024/05/30 22:56:22 http2: server: error reading preface from client //./pipe/do
[+] Building 2.0s (10/10) FINISHED                               docker:default
 => [internal] load build definition from Dockerfile                       0.1s
 => => transferring dockerfile: 745B                                       0.0s
 => [internal] load metadata for docker.io/library/mysql:8.4               0.0s
 => [internal] load .dockerignore                                          0.0s
 => => transferring context: 2B                                            0.0s
 => CACHED [1/5] FROM docker.io/library/mysql:8.4                          0.0s
 => [internal] load build context                                          0.0s
 => => transferring context: 127B                                          0.0s
 => [2/5] COPY init_freerider_access.sql /tmp                              0.2s
 => [3/5] COPY init_freerider_schema.sql /tmp                              0.1s
 => [4/5] COPY sample_data.sql /tmp                                        0.2s
 => [5/5] RUN cat /tmp/init_freerider_access.sql /tmp/init_freerider_sche  0.5s
 => exporting to image                                                     0.4s
 => => exporting layers                                                    0.2s
 => => writing image sha256:334389640cbce38486863c521a464952dd3bade844bb6  0.0s
 => => naming to docker.io/library/freerider-mysqld-img:1.0                0.0s
``` -->



&nbsp;

### DB 5.3) *Create Database Container*

Based on the image *"freerider-db-img:0.8"*, a new container can be created.
The container will have the volume mounted (`-v`) and a port mapping (`-p`)
that opens the internal TCP-port *3306* (number right of `:`) at which process
*mysqld* is listening for SQL requests inside the container to TCP-port *3306*
(the number left of `:`) in the host system.

The command will *create* and *start* the container and the database process
*mysqld* within:

```sh
# create container based on the 'freerider-db-img:0.8' image with mapped
# port 3306 and volume mount 'freerider-db-vol:/var/lib/mysql'
docker run --name "freerider-db" -d \
    -p 3306:3306 \
    -v "freerider-db-vol:/var/lib/mysql" \
    "freerider-db-img:0.8"
```

Verify the container is running:

```sh
# show running containers
docker ps
docker ps --format 'table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}'

# show all containers (including passive containers)
docker ps -a
```
```
CONTAINER ID   NAMES          IMAGE                  STATUS         PORTS
a75cd974b75b   freerider-db   freerider-db-img:0.8   Up 5 minutes   0.0.0.0:3306->3306/tcp,
                                                                    [::]:3306->3306/tcp
```

Show processes running inside the container:

```sh
# show processes running in the container
docker container top "freerider-db"
```
```
UID    PID    PPID    C    STIME    TTY        TIME       CMD
999    534     511    2    20:47      ?    00:00:10    mysqld   <-- database process is running
```

Logs created by the *mysqld* process can be accessed to see WARNINGS (ignored)
and/or ERROR messages (prevent *mysqld* from being started). Logs should be
inspected when the container fails to start.

```sh
# show container log
docker log "freerider-db"
```

The log of a successfull start of the *mysqld* process may show *"Warning"*
messages (ignored). Look for *"Error"* message that may indicate why *mysqld*
failed to start - and with it the entire container:

```
2025-06-11 13:00:06+00:00 [Note] [Entrypoint]: Entrypoint script for MySQL Server 8.4.5-1.el9 started.
2025-06-11 13:00:07+00:00 [Note] [Entrypoint]: Switching to dedicated user 'mysql'
2025-06-11 13:00:07+00:00 [Note] [Entrypoint]: Entrypoint script for MySQL Server 8.4.5-1.el9 started.
'/var/lib/mysql/mysql.sock' -> '/var/run/mysqld/mysqld.sock'
2025-06-11T13:00:07.856884Z 0 [System] [MY-015015] [Server] MySQL Server - start.
2025-06-11T13:00:08.068787Z 0 [System] [MY-010116] [Server] /usr/sbin/mysqld (mysqld 8.4.5) starting as process 1
2025-06-11T13:00:08.093775Z 1 [System] [MY-013576] [InnoDB] InnoDB initialization has started.
2025-06-11T13:00:08.847614Z 1 [System] [MY-013577] [InnoDB] InnoDB initialization has ended.
2025-06-11T13:00:09.518700Z 0 [Warning] [MY-010068] [Server] CA certificate ca.pem is self signed.
2025-06-11T13:00:09.518796Z 0 [System] [MY-013602] [Server] Channel mysql_main configured to support TLS. Encrypted connections are now supported for this channel.
2025-06-11T13:00:09.526597Z 0 [Warning] [MY-011810] [Server] Insecure configuration for --pid-file: Location '/var/run/mysqld' in the path is accessible to allOS users. Consider choosing a different directory.
2025-06-11T13:00:09.596097Z 0 [System] [MY-011323] [Server] X Plugin ready for connections. Bind-address: '::' port: 33060, socket: /var/run/mysqld/mysqlx.sock
2025-06-11T13:00:09.596256Z 0 [System] [MY-010931] [Server] /usr/sbin/mysqld: ready for connections. Version: '8.4.5'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  MySQL Community Server - GPL.
```


The new container with the *mysqld* process is running. It can be accessed,
e.g. by *"attaching a bash process"* to the container:

```sh
# create shell process in container and connect with the terminal ('-it')
docker exec -it "freerider-db" /bin/bash
```
```
bash-5.1#               <-- prompt of bash process running in the container
bash-5.1# ls -la        # list files
```

One can *"log into the database server"* using the *mysql* client that is also
installed in the container:

```sh
# use 'mysql' client to log into the 'mysqld' server process
bash-5.1# mysql -u root
```

After the login message, the prompt of the *mysqld* server `mysql>` appears:

```
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 8
Server version: 8.4.5 MySQL Community Server - GPL

Copyright (c) 2000, 2025, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
```

SQL commands can now be entered:

```
mysql> show databases;
```

Database *"FREERIDER_DB"* is already present, created by the actions in the
[*Dockerfile*](Dockerfile).

```
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| FREERIDER_DB       | <-- database 'FREERIDER_DB' exists
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.01 sec)
```

Verify that user account *"freerider"* exists for database *FREERIDER_DB* that
was created from file [*init-db/access.sql*](init-db/access.sql) or
(alternatively) through environment variables ( *MYSQL_DATABASE*, *MYSQL_USER*,
 *MYSQL_PASSWORD* ) in [*Dockerfile*](Dockerfile) when the image was built.

```
mysql> SELECT host, user, plugin FROM mysql.user;
```
```
+-----------+------------------+-----------------------+
| host      | user             | plugin                |
+-----------+------------------+-----------------------+
| %         | freerider        | caching_sha2_password | <-- user account exists
| %         | root             | caching_sha2_password |
| localhost | mysql.infoschema | caching_sha2_password |
| localhost | mysql.session    | caching_sha2_password |
| localhost | mysql.sys        | caching_sha2_password |
| localhost | root             | caching_sha2_password |
+-----------+------------------+-----------------------+
6 rows in set (0.00 sec)
```



&nbsp;

### DB 5.4) *Database Lifecycle (start, stop)*

The database process must be properly shut down in order to prevent data
corruption. Proper shutdown of the *mysqld* process is done by the `shutdown`
command issued to the *mysqld* process:

```
mysql> shutdown;
```

This command will shut down the *mysqld* process and log-out the bash process
from the container. The state of the container will transition to `EXITED`:

```sh
# show status of the container
 docker ps --all --format 'table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Status}}'
```
```
CONTAINER ID   NAMES          IMAGE                  STATUS
a75cd974b75b   freerider-db   freerider-db-img:0.8   Exited (0)     <-- status changed
```

The container can be restarted:

```sh
# restart the database server 'mysqld'
docker container start freerider-db
```

Alternatively, the container can be restarted with *Docker Desktop*.

The `shutdown` command can also be sent from the host system to the
*mysqld* process:

```sh
# send 'shutdown' to the database server 'mysqld'
# echo "shutdown" | docker exec -i -e MYSQL_USER="root" freerider-db mysql
echo "shutdown" | docker exec -i freerider-db mysql --user=root
```

The container log will show messages of *mysqld's* shutdown appended after
the prior startup log messages:

```sh
# show container log
docker log "freerider-db"
```
```
...

2025-06-11T13:09:14.098769Z 0 [System] [MY-013172] [Server] Received SHUTDOWN from user <via user signal>. Shutting down mysqld (Version: 8.4.5).
2025-06-11T13:09:15.324935Z 0 [System] [MY-010910] [Server] /usr/sbin/mysqld: Shutdown complete (mysqld 8.4.5)  MySQL Community Server - GPL.
2025-06-11T13:09:15.324984Z 0 [System] [MY-015016] [Server] MySQL Server - end.
```

Stopping the container directly can be dangerous and corrupt data since the
*mysqld* process may not have the chance to write caches back to the database:

```sh
docker container stop freerider-db
```



&nbsp;

### DB 5.5) *Schema Load*

The *FREERIDER_DB* has been initialized in the image by a file in the
container `/docker-entrypoint-initdb.d/db_init.sql` that is used by *mysqld*
to initialize when a new database is created.

The file is initialized by `COPY` and `RUN` actions in the
[*Dockerfile*](Dockerfile):

```dockerfile
# define 'db_init.sql' file inside the container image that is interpreted
# by the 'mysqld' process
ARG DB_INIT_FILE=/docker-entrypoint-initdb.d/db_init.sql

# copy init files into the created image under path '/tmp' (in the image)
COPY init-db/freerider-init-schema.sql /tmp
COPY init-db/freerider-init-data.sql /tmp

# aggregate init files in one 'db_init.sql' file that is interpreted
# by the 'mysqld' process
RUN cat /tmp/freerider-init-schema.sql >> $DB_INIT_FILE
RUN cat /tmp/freerider-init-data.sql   >> $DB_INIT_FILE
```

Files from the project contain the initial information for the database:

- [*init-db/access.sql*](init-db/access.sql) -- creation of the *FREERIDER_DB*
    database (`CREATE DATABASE IF NOT EXISTS FREERIDER_DB;`) and account and
    password information. This file is used when environment variables that
    achieve the same effect: *MYSQL_DATABASE*, *MYSQL_USER* and *MYSQL_PASSWORD*
    are not used in [*Dockerfile*](Dockerfile).

- [*init-db/freerider-init-schema.sql*](init-db/freerider-init-schema.sql) --
    the initial schema created for *FREERIDER_DB* and

- [*init-db/freerider-init-data.sql*](init-db/freerider-init-data.sql) --
    the initial data set for *FREERIDER_DB*.

Log into the *FREERIDER_DB* database and verify that the schema and the data
set exit in the initial database:

```
docker exec -it $cnt /bin/bash          # log into container
bash-5.1# 
bash-5.1#                               # log into database as user 'freerider'
bash-5.1# mysql --user=freerider --password=free.ride

mysql> use FREERIDER_DB;                # change to database 'FREERIDER_DB'
Database changed
mysql> 
mysql> show tables;
+------------------------+
| Tables_in_FREERIDER_DB |
+------------------------+
| CUSTOMER               |              <-- table CUSTOMER exists
+------------------------+
1 row in set (0.00 sec)

mysql> select * from CUSTOMER;          # show CUSTOMER records
+------+--------------+-----------------+----------------+
| ID   | NAME         | CONTACT         | STATUS         |
+------+--------------+-----------------+----------------+
| 1000 | Meyer, Eric  | eme22@gmail.com | Active         |
| 1001 | Sommer, Tina | 030 22458 29425 | Active         |
| 1002 | Schulze, Tim | +49 171 2358124 | InRegistration |
+------+--------------+-----------------+----------------+
3 rows in set (0.00 sec)
```

Complete the schema in file
[*init-db/freerider-init-schema.sql*](init-db/freerider-init-schema.sql)
for tables *VEHICLE* and *RESERVATION* according to the
[*ER-Diagram*](https://github.com/sgra64/docker/blob/markup/DB12-freerider/freerider_ERD.png?raw=true)
and reload into the database.

Load the schema file into the database and verify all tables are present:

```
mysql> show tables;
+------------------------+
| Tables_in_FREERIDER_DB |
+------------------------+
| CUSTOMER               |              <-- table CUSTOMER exists
| RESERVATION            |              <-- table RESERVATION exists
| VEHICLE                |              <-- table VEHICLE exists
+------------------------+
3 row in set (0.00 sec)
```



&nbsp;

### DB 5.6) *Data Load*

When the schema is complete, uncommend data for tables `VEHICLE` and
`RESERVATION` in
[*init-db/freerider-init-data.sql*](init-db/freerider-init-data.sql)
and load the full data set.

Verify that data records show for all tables:

```
mysql> select * from CUSTOMER;
+------+--------------+-----------------+----------------+
| ID   | NAME         | CONTACT         | STATUS         |
+------+--------------+-----------------+----------------+
| 1000 | Meyer, Eric  | eme22@gmail.com | Active         |
| 1001 | Sommer, Tina | 030 22458 29425 | Active         |
| 1002 | Schulze, Tim | +49 171 2358124 | InRegistration |
+------+--------------+-----------------+----------------+
3 rows in set (0.00 sec)


mysql> select * from VEHICLE;
+------+----------+---------------+-------+----------+----------+----------+
| ID   | MAKE     | MODEL         | SEATS | CATEGORY | POWER    | STATUS   |
+------+----------+---------------+-------+----------+----------+----------+
| 8000 | VW       | ID.3          |     4 | Sedan    | Electric | Active   |
| 8001 | VW       | Golf          |     4 | Sedan    | Gasoline | Active   |
| 8002 | VW       | Golf          |     4 | Sedan    | Hybrid   | Active   |
| 8003 | BMW      | 320d          |     4 | Sedan    | Diesel   | Active   |
| 8004 | Mercedes | EQS           |     4 | Sedan    | Electric | Active   |
| 8005 | VW       | Multivan Life |     8 | Van      | Gasoline | Active   |
| 8006 | Tesla    | Model 3       |     4 | Sedan    | Electric | Active   |
| 8007 | Tesla    | Model S       |     4 | Sedan    | Electric | Serviced |
+------+----------+---------------+-------+----------+----------+----------+
8 rows in set (0.00 sec)


mysql> select * from RESERVATION;
+--------+-------------+------------+---------------------+---------------------+----------------+----------------+----------+
| ID     | CUSTOMER_ID | VEHICLE_ID | RBEGIN              | REND                | PICKUP         | DROPOFF        | STATUS   |
+--------+-------------+------------+---------------------+---------------------+----------------+----------------+----------+
| 145373 |        1001 |       8002 | 2025-07-04 20:00:00 | 2025-07-04 23:00:00 | Berlin Wedding | Hamburg        | Inquired |
| 201235 |        1000 |       8002 | 2025-07-20 10:00:00 | 2025-07-20 20:00:00 | Berlin Wedding | Berlin Wedding | Booked   |
| 351682 |        1002 |       8001 | 2025-06-10 22:51:54 | 2025-06-11 00:51:54 | Berlin Wedding | Hamburg        | Inquired |
| 382565 |        1000 |       8006 | 2025-07-18 18:00:00 | 2025-07-18 18:10:00 | Berlin Wedding | Hamburg        | Inquired |
| 682351 |        1002 |       8003 | 2025-07-18 09:00:00 | 2025-07-18 18:00:00 | Potsdam        | Teltow         | Inquired |
+--------+-------------+------------+---------------------+---------------------+----------------+----------------+----------+
5 rows in set (0.00 sec)
```

Show that data also can be accessed from the host system
(login information `--user=freerider --password=free.ride` has been set as
environment variables *MYSQL_DATABASE*, *MYSQL_USER* and *MYSQL_PASSWORD*
in the container)
:

```sh
# full command to send SQL query to 'mysqld' in the container
echo "select * FROM CUSTOMER;" | \
    docker exec -i "freerider-db" \
        mysql -D FREERIDER_DB --user=freerider --password=free.ride

# shorter version using container environment variables
echo "select * FROM CUSTOMER;" | \
    docker exec -i "freerider-db" mysql -D FREERIDER_DB
```

Output shows the tables of the *CUSTOMER* table (without table borders):

```
ID      NAME            CONTACT STATUS
1000    Meyer, Eric     eme22@gmail.com Active
1001    Sommer, Tina    030 22458 29425 Active
1002    Schulze, Tim    +49 171 2358124 InRegistration
```

Create a function that runs

```sh
# shell-function 'show_tables' shows the content of all tables
function show_tables() {
    for table in CUSTOMER VEHICLE RESERVATION; do
        echo -e "--------\n$table:"

        echo "select * FROM $table;" | \
            docker exec -i "freerider-db" mysql -D -D FREERIDER_DB

    done; echo "--------"
}

show_tables             # invoke function
```

```
--------
CUSTOMER:
ID      NAME            CONTACT STATUS
1000    Meyer, Eric     eme22@gmail.com Active
1001    Sommer, Tina    030 22458 29425 Active
1002    Schulze, Tim    +49 171 2358124 InRegistration
--------
VEHICLE:
ID      MAKE     MODEL    SEATS   CATEGORY  POWER       STATUS
8000    VW       ID.3     4       Sedan     Electric    Active
8001    VW       Golf     4       Sedan     Gasoline    Active
8002    VW       Golf     4       Sedan     Hybrid      Active
8003    BMW      320d     4       Sedan     Diesel      Active
8004    Mercedes EQS      4       Sedan     Electric     Active
8005    VW       Multivan 8       Van       Gasoline     Active
8006    Tesla    Model 3  4       Sedan     Electric     Active
8007    Tesla    Model S  4       Sedan     Electric     Serviced
--------
RESERVATION:
ID      CUSTOMER_ID VEHICLE_ID RBEGIN               REND                 PICKUP          DROPOFF  STATUS
145373  1001        8002       2025-07-04 20:00:00  2025-07-04 23:00:00  Berlin Wedding  Hamburg  Inquired
201235  1000        8002       2025-07-20 10:00:00  2025-07-20 20:00:00  Berlin Wedding  Berlin Wedding  Booked
351682  1002        8001       2025-06-10 22:51:54  2025-06-11 00:51:54  Berlin Wedding  Hamburg  Inquired
382565  1000        8006       2025-07-18 18:00:00  2025-07-18 18:10:00  Berlin Wedding  Hamburg  Inquired
682351  1002        8003       2025-07-18 09:00:00  2025-07-18 18:00:00  Potsdam         Teltow   Inquired
--------
```

