# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# define assets
cnt="freerider-db"              # container name running the 'mysqld' process
img="freerider-db-img:0.8"      # image name used to create container
vol="freerider-db-vol"          # volume mounted to container to store database
 db="FREERIDER_DB"              # name of the database
# 
# names produced by 'docker-compose up -d'
# cnt="freerider-freerider-db-1"
# vol="freerider_freerider-db-vol"
# 
# MYSQL="docker exec -i $cnt mysql --user=freerider --password=free.ride -D $db"
# MYSQL="docker exec -i -e MYSQL_USER=freerider -e MYSQL_PASSWORD=free.ride $cnt mysql -D $db"
MYSQL="docker exec -i \$cnt mysql -D \$db"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# 
# show processes running in a container
docker container top $cnt
# 
# send SQL from host-shell to 'mysql' client in 'freerider-db' container
echo "select * FROM CUSTOMER;" | docker exec -i $cnt mysql -D "FREERIDER_DB"
# 
# shorter expressions using variable 'MYSQL' defined above
echo "select * FROM CUSTOMER;" | $MYSQL
$MYSQL <<< "select * FROM CUSTOMER;"
$MYSQL <<< "show tables;"

# show content of all tables
function show_tables() {
    for table in CUSTOMER VEHICLE RESERVATION; do
        echo -e "--------\n$table:"
        eval $MYSQL <<< "select * FROM $table;"
    done; echo "--------"
}

# create a local mysql() function that accepts SQL as arguments
function mysql() {
    [ "$1" = "--sql" ] && shift && local sql="$@" && set -f
    # set -f; or bash: set -o noglob; # zsh: set -o localoptions -o noglob
    [ "$sql" ] && local stmt=() && \
        for p in $@; do
            stmt+=($p)
        done && set +f && $MYSQL <<< "${stmt[@]}" || $MYSQL
}
mysql --sql select \* FROM CUSTOMER;
mysql --sql 'select * FROM CUSTOMER;'
# 
echo 'select * FROM CUSTOMER;' | mysql
# 
# type input, end with EOF (^Z or ^D)
mysql
> select * from CUSTOMER;

# - - - - - - - - - - - - - - - - - - - - - - -
# load schema into database from file (removes all prior content)
cat "init-db/freerider-schema.sql" | $MYSQL
# 
# load data into database from file (removes all prior content)
cat "init-db/freerider-data.sql" | $MYSQL

# load complete schema and data sets (not distributed)
cat "init-db-complete/freerider-schema.sql" | $MYSQL
cat "init-db-complete/freerider-data.sql"   | $MYSQL
cat "freerider-full-data.sql"   | $MYSQL

# - - - - - - - - - - - - - - - - - - - - - - -
# create volume to store the FREERIDER_DB database data outside the container
docker volume create "$vol"

# create image for the database container using 'Dockerfile'
docker build -t "$img" --no-cache -f Dockerfile .

# create container based on the 'freerider-db-img:0.8' image with mapped
# port 3306 and volume mount 'freerider-db-vol:/var/lib/mysql'
# --mysql-native-password=ON
docker run --name "$cnt" -d -p 3306:3306 -v "$vol:/var/lib/mysql" "$img"

# show processes running in container
docker container top $cnt

# show 'mysqld' startup logs
docker logs $cnt

# start/stop the container with the 'mysqld' database server
# shut down database server 'mysqld' safely
echo "shutdown" | docker exec -i -e MYSQL_USER="root" freerider-db mysql
docker container start freerider-db
docker container stop freerider-db

# remove assets
docker container rm -f "freerider-db"
docker image rm -f "freerider-db-img:0.8"
docker volume rm -f "freerider-db-vol"

# - - - - - - - - - - - - - - - - - - - - - - -
# create shell process in container and connect with the terminal ('-it')
docker exec -it $cnt /bin/bash

# send command to shell process started in container
echo "ls -la" | docker exec --interactive $cnt /bin/bash

# create database dump
echo "mysqldump $db" | \
    docker exec -i "$cnt" /bin/bash > database-dump.sql

# - - - - - - - - - - - - - - - - - - - - - - -
