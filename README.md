<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
<!-- A1 (SE-2)
-->
# Project: *MySQL Database Server*

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
The assignment demonstates a full *"database build"* for the
[*MySQL*](https://dev.mysql.com/doc/refman/8.4/en/)
database.

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

1. [Install Docker](#1-install-docker)

1. [Pull the *MySQL* Docker Image](#2-pull-the-mysql-docker-image)

1. [Create a Docker Container based on that Image](#3-create-a-docker-container-based-on-that-image)

1. [Attach Shell process (*"log-into Container"*)](#4-attach-shell-process-log-into-container)

1. [*Log-into Database*](#5-log-into-database)

1. [Create New Database](#6-create-new-database)

1. [*JOIN* Queries](#7-join-queries)

1. [Create and Mount *Volume*](#8-create-and-mount-volume)

1. [Create/Load *Database Schema*](#9-createload-database-schema)

1. [Create/Load *Database Data*](#10-createLoad-database-data)

1. [Connect from Application through *JDBC*](#11-connect-from-application-through-jdbc)


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

&nbsp;

## 1. Install Docker

Docker (*"engine"*), which is the daemon-process of Docker `dockerd` can be
installed separately, see
[*"Install Docker Engine"*](https://docs.docker.com/engine/install).

Easier is the installation of an integrated desktop-application
[*"Docker Desktop"*](https://docs.docker.com/desktop), which includes all
needed parts, in particular the *Hyper-V* or *WSL* extensions needed on
[*Windows*](https://docs.docker.com/desktop/setup/install/windows-install/).

<img src="https://www.docker.com/app/uploads/2025/05/DD-hiroko.png" width="520"/>

It is furthermore recommended:

- to configure the Docker
    [*Command-Line-Interface (CLI)*](https://docs.docker.com/reference/cli/docker)
    such that docker commands are available.
    This is done by setting *"DOCKER_HOME"* and configuring it on *"PATH"*
    in *.bashrc*.

- to install the
    [*VSCode Containers Plugin*](https://code.visualstudio.com/docs/containers/overview).

Test your setup by launching *Docker Desktop* and testing the CLI:

```sh
docker --version
```

The docker-daemon process *"dockerd"* returns:

```
Docker version 28.2.2, build e6534b4
```


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

&nbsp;

## 2. Pull the *MySQL* Docker Image

Pulling an image from [*"docker-hub"*](https://hub.docker.com) into the local
image cache is simply done
by:

```sh
docker image pull mysql:8.4
```

Output shows multiple image layers being pulled that constitute the image
*mysql:8.4*:

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

The new image should appear in Docker Desktop (under *"Container Images"*)
and also with:

```sh
docker image ls                 # show images from the local image cache
```
```
REPOSITORY         TAG       IMAGE ID       CREATED         SIZE
mysql              8.4       20d0be4ee452   2 weeks ago     785MB
```


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

&nbsp;

## 3. Create a Docker Container based on that Image

The command for creating a new Docker container named *"mysqld-container"* is
`run` (not *"create"*):

```sh
# create transient container named 'mysqld-container' from image 'mysql:8.4'
docker run --name mysqld-container -d \
    -e MYSQL_ALLOW_EMPTY_PASSWORD=yes \
    -e MYSQL_ROOT_PASSWORD= \
    -p3306:3306 \
    mysql:8.4
```

Argument `-d` means the image launches a *mysqld* daemon process waiting for
connection requests from outside.

Two environment variables are set for the *mysqld* server process with `-e`
that permit access to the database with no (empty) password.

Argument `-p3306:3306` maps TCP port *3306* (right), at which the *mysqld*
server process is listening inside the container, to TCP-port `3306` (left)
making the port accessible on the host system.

The last argument `mysql:8.4` refers to the image used to launch the container
containing the MySQL installation and the script to launch the *mysqld*
database server process.

After the command, the new container will appear in *Docker Desktop* with a
green light indicating the *mysqld* process is running.

Command `docker ps` shows all active containers:

```sh
docker ps                       # show active containers
docker ps -a                    # show all containers (active and dormant)
```
```
CONTAINER ID   IMAGE       COMMAND                  CREATED          STATUS     PORTS                                         NAMES
500d67155d34   mysql:8.4   "docker-entrypoint.s…"   24 seconds ago   Up 23 seconds   0.0.0.0:3306->3306/tcp, [::]:3306->3306/tcp   mysqld-container
```

Containers are considered *"active"* when they have at least one active process.
*"Dormant"* containers exist as configured environment, but have no active
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

## 4. Attach Shell process (*"log-into Container"*)

Docker has no concept of *"logging into"* a container. Instead, a new *shell*
process can be launched inside the container and connected (*"attached"*) to
an interactive (`-it`) terminal process outside the container:

```sh
# launch 'bash' inside the container and attach the current terminal
docker exec -it "mysqld-container" bash
```

This command starts a new *bash* shell process and attaches the terminal to its
*stdin/stdout* channels. The prompt of the bash shell process appears in the
terminal. Commands can be entered and are executed by the *bash* process running
inside the container:

```
bash-5.1# 
```

This behavior makes the command appear like *"logging into a container"*.

Alternatively, *shell* processes can also be attached in *VSCode Docker*
extension and in *Docker Desktop*.


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

&nbsp;

## 5. *Log-into Database*

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
mysql --user=root                   # log into database as user 'root'
```
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

The answer shows databases that pre-exist in *MySQL*:

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

User and access information can be queried in the mysql table:

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

## 6. Create New Database

Create a new database *"UNI"* and select this database:

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

What does `START TRANSACTION;` and `COMMIT;` achieve?

What is the difference to the following command?

```sql
INSERT INTO PROFESSOR (NAME) VALUES ('Graupner');
INSERT INTO PROFESSOR (NAME) VALUES ('Meyer');
INSERT INTO PROFESSOR (NAME) VALUES ('Lohmann');
```

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

## 7. *JOIN* Queries

Create a new database *"DEPARTMENTS"* and run the examples for *JOIN* queries:
[*https://en.wikipedia.org/wiki/Join_(SQL)*](https://en.wikipedia.org/wiki/Join_(SQL))

Understand:

- *Cross JOIN*,

- *Inner JOIN*,

- *Outer JOIN* (left, right).


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

&nbsp;

## 8. Create and Mount *Volume*

No volume was used for the database examples. Database files were created
inside the container under path: `/var/lib/mysql`.

```sh
mysql> quit;                        # exit the database

bash-5.1# cd /var/lib/mysql         # back to 'bash'
bash-5.1# ls -la UNI                # show database files
```

The database files appear:

```
total 232
drwxr-x--- 2 mysql mysql   4096 Dec 19 00:30 .
drwxrwxrwt 8 mysql mysql   4096 Dec 19 00:30 ..
-rw-r----- 1 mysql mysql 114688 Dec 19 00:31 PROFESSOR.ibd
-rw-r----- 1 mysql mysql 114688 Dec 19 00:31 STUDENT.ibd
```

Physically, database files reside in the *"writeable image layer"* that is
attached to the container. When the container is deleted, that image layer
will also be removed and database files lost.

Docker considers containers as transient, not as permanent entities, which
means containers should be removed and re-created at any time.

Therefore, Docker containers *"should not keep state"* (the writeable images
attached to them) and hence, external storage be used to store data, see
[*"10 things to avoid in docker containers"*](https://developers.redhat.com/blog/2016/02/24/10-things-to-avoid-in-docker-containers).

Docker has two methods to attach external storage to a container and *mount*
into the container under a specified path:

- [*bind mount*](https://docs.docker.com/engine/storage/bind-mounts) --
    mount a directory from the host system into a container under a specified
    path (with host filesystem) and

- [*volume mount*](https://docs.docker.com/engine/storage/volumes) --
    mount a logical disk into a container under a specified path.


Create a new *Volume* named *"mysqld-volume"*
([*VOLUME CREATE*](https://docs.docker.com/reference/cli/docker/volume/create/)):

```sh
docker volume create "mysqld-volume"

docker volume ls                # list (ls) existing volumes
```
```
DRIVER    VOLUME NAME
local     mysqld-volume         <-- new created volume
```

The new volume can now be mounted when a new container is created.

Shutdown and remove the container *"mysqld-container"*:

```sh
docker stop mysqld-container        # stop container (all processes)
docker rm mysqld-container          # remove the container

docker ps                           # container no longer exists
```

Re-create the container under the same name, but with the volume mounted
with: `-v mysqld-volume:/var/lib/mysql` making the volume appear inside the
container under the path `/var/lib/mysql`:

```sh
# create new container named 'mysqld-container' from image 'mysql:8.4'
docker run --name mysqld-container -d \
    -e MYSQL_ALLOW_EMPTY_PASSWORD=yes \
    -e MYSQL_ROOT_PASSWORD= \
    -v mysqld-volume:/var/lib/mysql \
    -p3306:3306 \
    mysql:8.4
```

Show logs of the *mysqld* start-up:

```sh
docker container logs mysqld-container      # show docker container logs
```
```
2025-12-19T01:18:10.942674Z 0 [Warning] [MY-011810] [Server] Insecure configuration for --pid-file: Location '/var/run/mysqld' in the path is accessible to all OS users. Consider choosing a different directory.
2025-12-19T01:18:11.036252Z 0 [System] [MY-011323] [Server] X Plugin ready for connections. Bind-address: '::' port: 33060, socket: /var/run/mysqld/mysqlx.sock
2025-12-19T01:18:11.036528Z 0 [System] [MY-010931] [Server] /usr/sbin/mysqld: ready for connections. Version: '8.4.7'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  MySQL Community Server - GPL.
```


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

&nbsp;

## 9. Create/Load *Database Schema*

Prepare a database schema file from the previous
[*JDBC assignment*](https://github.com/sgra64/mvn-fun/tree/mvn-jdbc-h2)
as a local file in the project directory `db-init-schema.sql` with
content:

1. Create a new database: `TEST_DB` (if not exists - for idempotency).

1. select that database.

1. Load the schema for the three tables: *CUSTOMER*, *VEHICLE* and *RESERVATION*.

Load the file into the database server.

There are multiple ways, one is to *"pipe"* the schema-file from the host
system into the container, and there, into the database server process *mysqld*
using the *mysql* client:

```sh
cnt="mysqld-container"          # set variable with container-name

# make sure file 'db-init-schema.sql'
cat db-init-schema.sql | docker exec -i $cnt mysql -D "TEST_DB"
```

Show the new database has been created:

```sh
echo "SHOW DATABASES;" | docker exec -i $cnt mysql -D "TEST_DB"
```
```
Database
TEST_DB                 <-- new TEST_DB appears
information_schema
mysql
performance_schema
sys
```

Show tables of the new database:

```sh
echo "USE TEST_DB; SHOW TABLES;" | docker exec -i $cnt mysql -D "TEST_DB"
```
```
Tables_in_TEST_DB
CUSTOMER
RESERVATION
VEHICLE
```

Show the definition of the *CUSTOMER* table:

```sh
echo "USE TEST_DB; DESCRIBE CUSTOMER;" | docker exec -i $cnt mysql -D "TEST_DB"
```
```
+---------------+----------------------------------------------+------+-----+---------+----------------+
| Field         | Type                                         | Null | Key | Default | Extra          |
+---------------+----------------------------------------------+------+-----+---------+----------------+
| ID            | bigint                                       | NO   | PRI | NULL    | auto_increment |
| NAME          | varchar(60)                                  | NO   |     | NULL    |                |
| FIRSTNAME     | varchar(60)                                  | YES  |     | NULL    |                |
| CONTACT       | varchar(60)                                  | YES  |     | NULL    |                |
| STATUS        | enum('Active','InRegistration','Terminated') | YES  |     | NULL    |                |
| STATUS_CHANGE | timestamp                                    | YES  |     | NULL    |                |
+---------------+----------------------------------------------+------+-----+---------+----------------+
6 rows in set (0.01 sec)
```

Fetch the *"schema-dump"* of the database using the
[*mysqldump*](https://dev.mysql.com/doc/en/mysqldump.html)
command:

```sh
# extract schema-dump from 'TEST_DB' and save to file 'db-dump-schema.sql'
echo "mysqldump --no-data TEST_DB" | docker exec -i $cnt /bin/bash | \
    tee db-dump-schema.sql
```

Inspect file *db-dump-schema.sql* and compare with the original schema file.


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

&nbsp;

## 10. Create/Load *Database Data*

Prepare a database data file from the previous
[*JDBC assignment*](https://github.com/sgra64/mvn-fun/tree/mvn-jdbc-h2)
as a local file in the project directory `db-init-data.sql` with
data for the three tables: *CUSTOMER*, *VEHICLE* and *RESERVATION*.

Load the file into the database server, e.g. by.

```sh
# make sure file 'db-init-schema.sql'
cat db-init-data.sql | docker exec -i $cnt mysql -D "TEST_DB"
```



<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

&nbsp;

## 11. Connect from Application through *JDBC*

After schema-load and data-load has been successful for the *TEST_DB*, build
the actual database `FREERIDER_DB` with the same schema and the full
dataset:

```sh
# make sure file 'db-init-data.sql'
cat db-init-data.sql | docker exec -i $cnt mysql -D "TEST_DB"
```



<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
<!-- TEMPLATE -->
<!-- 
&nbsp;

## 1. Project Structure ("*Scaffold*")

Project `se1-play` is comprised of files and sub-directories. The directory
structure is called the project *"scaffold" :*

```sh
<workspaces>    # workspace folder within which project directories exist
 |
 +-<se1-play>       # project folder of the 'se1-play' project
   +--.project          # VSCode/eclipse file with project settings (*)
   +--.classpath        # VSCode/eclipse project file with CLASSPATH information (*)
   |
   +-<libs>             # git-module with libraries required by the project
   |  +--install.sh     # install-script for libraries
   |  |
   |  |  # JUnit test-runner and .jar files for unit tests
   |  +--junit-platform-console-standalone-1.9.2.jar
   |  +-<junit>
   |     +--apiguardian-api-1.1.2.jar
   |
   |  # files marked with (*) are created during sourcing
```

<img src="https://raw.githubusercontent.com/sgra64/se1-play/refs/heads/markup/img/junit-run-2.png" width="360"/>
 -->
