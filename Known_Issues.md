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
