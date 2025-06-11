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
