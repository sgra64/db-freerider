## Known Issues

---
Known issues capture problems and describe solutions.

1. [Issue 1:](#1-issue-1)
    Mac with *M1*-CPU:  *"image platform does not match host platform"*
2. [Issue 2:](https://github.com/sgra64/docker-se2/blob/main/Known_Issues.md#2-issue-2)
    with *GitBash*: *"failed to create shim task: OCI runtime create failed"*
3. [Issue 3:](https://github.com/sgra64/docker-se2/blob/main/Known_Issues.md#3-issue-3)
    with *GitBash*: *"the input device is not a TTY"*
4. [Issue 4:](#4-issue-4) No *File Sharing* option in Docker Desktop with
    *Windows HOME*.
5. [Issue 5:](#5-issue-5) *mysql_root*, *mysql --user=root ...* access denied
6. [Issue 6:](#6-issue-6) *mysql* access denied
7. [Issue 7:](#7-issue-7-container-mount-not-working) Container mount not working


&nbsp;

---

### 1.) Issue 1:

Error on Mac with *M1*-Chip: *"The requested image's platform (linux/amd64) does not match the detected host platform"*.

- Solution I: use the `arm64v8/mysql:8.0` image instead of `mysql:8.0`
in Dockerfile, see article: *Emmanuel Gautier:*
[MySQL Docker Image for Mac ARM M1](https://www.emmanuelgautier.com/blog/mysql-docker-arm-m1), Feb 2022.
    ```
    FROM arm64v8/mysql:8.0
    ```

- Solution II: try `--platform=linux/amd64` before `mysql:8.0` in Dockerfile:

    ```
    FROM --platform=linux/amd64 adoptopenjdk/openjdk11:alpine
    ```


&nbsp;

---

### 4.) Issue 4
Problem: *Windows HOME* edition does not allow mounting directories
from the Host-system into containers.
Docker Desktop does not show the `File sharing` option to add a host
path as sharable mount point:

Docker Desktop Settings:
```perl
-> Settings -> Resources -> File sharing    # not present for Win HOME
```

The solution is to upgrade Windows from *HOME* to *Pro* or to not use
shared volumes by ommitting the `--mount` flag during container build:

```perl
docker run \
    --name="${container_name}" \
    \
    --env MYSQL_DATABASE="${MYSQL_DATABASE}" \
    --env MYSQL_USER="${MYSQL_USER}" \
    --env MYSQL_PASSWORD="${MYSQL_PASSWORD}" \
    --env MYSQL_ROOT_PASSWORD="${MYSQL_ROOT_PASSWORD}" \
    \
    --publish 3306:3306 \
    --mount type=bind,src="${project_path}/db.mnt",dst="/mnt" \     # <-- remove
    -d "${image_name}"
```

This means that Host-directory: `${project_path}/db.mnt` is not visible inside
the container. Its content must be added in Dockerfile and copied into the
image when it is built:

1. zip `db.mnt` in Host system (use Unix `tar` command to zip).
1. `ADD` .zip file to container image (in Dockerfile)
1. `RUN` unzip in Dockerfile to place content under path `/mnt`.

```perl
tar cvf db.mnt.tar db.mnt           # zip/tar directory db.mnt to db.mnt.tar

ADD db.mnt.tar /tmp                     # add .tar to image under /tmp
RUN tar -xf /tmp/db.mnt.tar -C /mnt     # unpack archive to /mnt
```

If this does not work, use the mysql base image `mysql:8.0` to create the
container:

```perl
docker run \
    --name="${container_name}" \
    \
    --env MYSQL_DATABASE="${MYSQL_DATABASE}" \
    --env MYSQL_USER="${MYSQL_USER}" \
    --env MYSQL_PASSWORD="${MYSQL_PASSWORD}" \
    --env MYSQL_ROOT_PASSWORD="${MYSQL_ROOT_PASSWORD}" \
    \
    --publish 3306:3306 \
    -d "mysql:8.0"                  # <-- use mysql base image
```

References:
- *"Docker Bind Mounts"*,
[Docker docs](https://docs.docker.com/storage/bind-mounts).
- *"Docker Volumes"*,
[Docker docs](https://docs.docker.com/storage/volumes).


&nbsp;

---

### 5.) Issue 5
The problem `mysql --user=root --password=password` access denied
occurs when the container image was built without *"sourcing"*.

The database root password is defined in variable `MYSQL_ROOT_PASSWORD`
in `.env.sh`. Unsourced, the root password is not set during database
initialization.

Solution: remove the image (and container), source the project with
`source .env.sh` and rebuild the image and container.

Alternatively, try the default root passwords:

```perl
mysql --user=root --password=           # try empty password
mysql --user=root --password=root       # "root" as root password
```

Note that commands `mysql_root` and `mysql` are defined with project-specific
settings in `/mnt/.env.sh`.


&nbsp;

---

### 6.) Issue 6
The problem `mysql` access denied occurs when the database user *freerider*
does not exist. This typically occurs when the container image is built
unsourced (`source .env.sh ` was not executed).

Solution: add database user *freerider* manually.

Log into the database as root-user and create user account manually.

```perl
mysql --user=root --password=password       # log into database as root user

mysql> CREATE USER 'freerider'...   # perform SQL-statements from file:
                                    # db.mnt/init_users.sql
```

Note that command `mysql` is overloaded in `/mnt/.env.sh` using arguments
`--user="freerider" --password="free.ride"` (and few more).
When sourced, `mysql` logs into the database under these credentials.

To call the native `mysql`-client, use the full path:

```perl
/usr/bin/mysql          # native mysql client
mysql                   # function from /mnt/.env.sh with project settings
```


&nbsp;

---
### 7.) Issue 7: Container mount not working
Symptom: When creating the container with `docker run` option:
`--mount type=bind,src="${project_path}/db.mnt",dst="/mnt"`
does not work.

Fix: directory `/mnt` (inside the container) is not mounted from the
project in the host system `./db.mnt`, but file are copied into the
container:

```
db.mnt/.env.sh
db.mnt/data_customers.sql
db.mnt/data_reservations.sql
db.mnt/data_vehicles.sql
db.mnt/db_data/.touch
db.mnt/db_logs/.touch
db.mnt/init_freerider_data.sql
db.mnt/init_freerider_schema.sql
db.mnt/init_users.sql
db.mnt/my.cnf
db.mnt/shutdown.sh
```

Database files then live inside the container's filesystem, which is
not desirable, but it works for running the database for the
assignments.

Use files from
[fix_no_mnt]()
directory, not from project directory to build the image:

```perl
cd fix_no_mnt       # change to fix_no_mnt directory
ls -la              # list files
```

updated files:

```
Dockerfile          # updated Dockerfile
db.mnt.tar          # archive with db.mnt-content copied into container under /mnt
```


1.) Build image `mysql/db-freerider_img_no_mnt:8.0` (name updated) from Dockerfile:

```perl
source ../.env.sh   # source from the project directory
                    # update image and container names
export image_name="mysql/db-freerider_img_no_mnt:8.0"
export container_name="db-freerider_MySQLServer_no_mnt"

echo "building image: ${image_name}"
docker build -t "${image_name}" --no-cache .
```

Output:

```
[+] Building 5.6s (18/18) FINISHED
 => [internal] load .dockerignore                                          0.1s
 => => transferring context: 2B                                            0.0s
 => [internal] load build definition from Dockerfile                       0.1s
 => => transferring dockerfile: 2.48kB                                     0.0s
 => [internal] load metadata for docker.io/library/mysql:8.0               0.0s
 => [internal] load build context                                          0.1s
 => => transferring context: 33B                                           0.0s
 => CACHED [ 1/13] FROM docker.io/library/mysql:8.0                        0.0s
 => [ 2/13] COPY db.mnt.tar /tmp/db.mnt.tar                                0.1s
 => [ 3/13] RUN tar xvfo /tmp/db.mnt.tar -C /tmp                           0.7s
 => [ 4/13] RUN mv /tmp/db.mnt/* /mnt                                      0.4s
 => [ 5/13] RUN ln -s /mnt/my.cnf /etc/mysql/conf.d/my.cnf                 0.3s
 => [ 6/13] RUN touch /docker-entrypoint-initdb.d/db_init.sql              0.4s
 => [ 7/13] RUN cat /mnt/init_freerider_schema.sql >> /docker-entrypoint-  0.3s
 => [ 8/13] RUN cat /mnt/init_freerider_data.sql >> /docker-entrypoint-in  0.4s
 => [ 9/13] RUN chmod 777 -R /mnt                                          0.6s
 => [10/13] RUN rm -rf /mnt/db_data/.touch                                 0.3s
 => [11/13] RUN rm -rf /var/lib/mysql /var/log/mysql /mnt/db_data/.touch   0.3s
 => [12/13] RUN ln -s /mnt/db_data /var/lib/mysql                          0.4s
 => [13/13] RUN ln -s /mnt/db_logs /var/log/mysql                          0.4s
 => exporting to image                                                     0.6s
 => => exporting layers                                                    0.6s
 => => writing image sha256:c5e61c4cdd203b7b2749e8fc2406d6a109ab429d3db63  0.0s
 => => naming to docker.io/mysql/db-freerider_img_no_mnt:8.0  
```

Show new image:

```
docker image ls "${image_name}"

REPOSITORY                      TAG       IMAGE ID       CREATED         SIZE
mysql/db-freerider_img_no_mnt   8.0       c5e61c4cdd20   2 minutes ago   538MB
```


2.) Create container `db-freerider_MySQLServer_no_mnt` from image *not* using
`--mount` option:

```perl
echo "creating container: ${container_name} from ${image_name}"
docker run \
    --name="${container_name}" \
    \
    --env MYSQL_DATABASE="FREERIDER_DB" \
    --env MYSQL_USER="freerider" \
    --env MYSQL_PASSWORD="free.ride" \
    --env MYSQL_ROOT_PASSWORD="password" \
    \
    --publish 3306:3306 \
    -d "${image_name}"
```

Container appears running (green) in *Docker Desktop*.

Show that new container is running:

```
docker ps           # when output is empty, use: docker ps -a

CONTAINER ID   IMAGE                              COMMAND                 STATUS  PORTS                              NAMES
ac7b967f4a51   mysql/db-freerider_img_no_mnt:8.0  "docker-entrypoint.s…"  Up      0.0.0.0:3306->3306/tcp, 33060/tcp  db-freerider_MySQLServer_no_mnt
```

Check container logs for ERRORs when container does not run.

```perl
docker logs "${container_name}"
```

Container with MySQL database server (*mysqld*) is now up and running
and can be used like expected.

To test, log into the container and run SQL-query:

```perl
# open (attach) a terminal shell to the container
docker exec -it "${container_name}" /bin/bash
```

Command starts *bash*-process running inside the container.
The prompt of this shell appears: `bash-4.4#`.

Enter commands that are executed inside the container:
```
bash-4.4# ls -la /mnt           # show files from /mnt copied into container
```

Output of `/mnt` directory inside the container:

```
total 72
drwxrwxrwx 1 root  root  4096 Jun  4 15:13 .
drwxr-xr-x 1 root  root  4096 Jun  4 15:18 ..
-rwxrwxrwx 1 root  root 12067 Jun  1 21:17 data_customers.sql
-rwxrwxrwx 1 root  root   846 Jun  1 21:17 data_reservations.sql
-rwxrwxrwx 1 root  root 16211 Jun  1 21:17 data_vehicles.sql
drwxrwxrwx 8 mysql root  4096 Jun  4 15:18 db_data
drwxrwxrwx 1 root  root  4096 Jun  4 15:13 db_logs
-rwxrwxrwx 1 root  root  2861 Jun  1 21:17 init_freerider_data.sql
-rwxrwxrwx 1 root  root  1444 Jun  1 21:23 init_freerider_schema.sql
-rwxrwxrwx 1 root  root   980 Jun  1 21:17 init_users.sql
-rwxrwxrwx 1 root  root  2768 Jun  2 21:32 my.cnf
-rwxrwxrwx 1 root  root   247 Dec 12 23:06 shutdown.sh
```

Log into database with *mysql*-client:

```
bash-4.4# mysql --user=root --password=password

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| FREERIDER_DB       |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.00 sec)

mysql> SELECT host, user FROM mysql.user;
+-----------+------------------+
| host      | user             |
+-----------+------------------+
| %         | freerider        |
| %         | root             |
| localhost | mysql.infoschema |
| localhost | mysql.session    |
| localhost | mysql.sys        |
| localhost | root             |
+-----------+------------------+
6 rows in set (0.00 sec)

mysql> use FREERIDER_DB;
mysql> show tables;
+------------------------+
| Tables_in_FREERIDER_DB |
+------------------------+
| CUSTOMER               |
| RESERVATION            |
| VEHICLE                |
+------------------------+
3 rows in set (0.00 sec)

mysql> select * from CUSTOMER;
+----+--------------+-----------------+--------+
| ID | NAME         | CONTACT         | STATUS |
+----+--------------+-----------------+--------+
|  1 | Meyer, Eric  | eme22@gmail.com | Active |
|  2 | Sommer, Tina | 030 22458 29425 | Active |
|  3 | Schulze, Tim | +49 171 2358124 | Active |
+----+--------------+-----------------+--------+
3 rows in set (0.00 sec)
```


&nbsp;

---
