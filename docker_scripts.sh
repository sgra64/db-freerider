#----------------------------------------------------------------------------
# Helper file with command snippets to
# - function d_clean()
# - function d_build_image()
# - function d_build_container()
# - function d_start()
# - function d_stop()
# - function d_bash()
# - function d_logs()
# - function d_show()
#

# set variable with full local path to project
project_path="$(pwd -LP)"
#
# set image and container names for MySQL server
image_name="mysql/db-freerider_img:8.0"
container_name="db-freerider_MySQLServer"
#
# show variable values
# echo ${project_path}
# echo ${image_name}
# echo ${container_name}
alias dock="$(basename $BASH_SOURCE)"


function d_clean() {
    #
    # clear container, image and db_data and db_logs files
    docker stop ${container_name}; \
    docker rm ${container_name}; \
    docker rmi ${image_name}; \
    rm -rf db.mnt/db_data/* db.mnt/db_logs/*; \
    touch db.mnt/db_data/.touch; \
    touch db.mnt/db_logs/.touch;
    #
}


function d_build_image() {
    #
    # create new image from Dockerfile .
    docker build -t "${image_name}" --no-cache . ;
    #
}


function d_build_container() {
    #
    # create container from image
    docker run \
        --name=${container_name} \
        \
        --env MYSQL_DATABASE='FREERIDER_DB' \
        --env MYSQL_USER='freerider' \
        --env MYSQL_PASSWORD='free.ride' \
        --env MYSQL_ROOT_PASSWORD='password' \
        \
        --publish 3306:3306 \
        --mount type=bind,src=${project_path}/db.mnt,dst=/mnt \
        -d ${image_name}
    #
}


function d_start() {
    #
    # start container
    docker start ${container_name};
    #
}

function d_stop() {
    #
    # stop container
    docker stop ${container_name};
    #
}


function d_bash() {
    #
    # attach bash to running container
    docker exec -it "${container_name}" /bin/bash
    #
}


function d_logs() {
    #
    # attach bash to running container
    docker logs "${container_name}"
    #
}


function d_show() {
    #
    # attach bash to running container
    grep "^function " "$(basename $BASH_SOURCE)" \
        | awk '/./ {print $2}'
    #
}


# log into database
# mysql --user=root --password=password
# \\
# SELECT host, user FROM mysql.user;
# mysql> SELECT host, user FROM mysql.user;
# +-----------+------------------+
# | host      | user             |
# +-----------+------------------+
# | %         | freerider        |
# | %         | root             |
# | localhost | mysql.infoschema |
# | localhost | mysql.session    |
# | localhost | mysql.sys        |
# | localhost | root             |
# +-----------+------------------+
# 6 rows in set (0.01 sec)
