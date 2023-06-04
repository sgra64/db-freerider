# use modified image and container names with "_no_mnt"
# soure project and update image and container names
source ../.env.sh
export image_name="mysql/db-freerider_img_no_mnt:8.0"
export container_name="db-freerider_MySQLServer_no_mnt"

export copy_files=" \
    db.mnt/.env.sh \
    db.mnt/data_customers.sql \
    db.mnt/data_reservations.sql \
    db.mnt/data_vehicles.sql \
    db.mnt/db_data/.touch \
    db.mnt/db_logs/.touch \
    db.mnt/init_freerider_data.sql \
    db.mnt/init_freerider_schema.sql \
    db.mnt/init_users.sql \
    db.mnt/my.cnf \
    db.mnt/shutdown.sh"

# build tar from ../db.mnt
(cd ..; tar cvf fix_no_mnt/db.mnt.tar $(echo "$copy_files"))

# build image from modified Dockerfile that copies db.mnt.tar into image
echo "building image: ${image_name}"
docker build -t "${image_name}" --no-cache .

# show new image
docker image ls "${image_name}"

# create container from image without using:
# --mount type=bind,src="${project_path}/db.mnt",dst="/mnt"
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

# show new container running (when output is empty, use: docker ps -a)
docker ps

# show container logs, check for ERROR lines when container does not start
docker logs "${container_name}"

# open (attach) a terminal shell to the container
docker exec -it "${container_name}" /bin/bash

# log into database (inside running container)
mysql --user=root --password=password
\\
mysql> show databases;
mysql> SELECT host, user FROM mysql.user;
mysql> use FREERIDER_DB;
mysql> show tables;
mysql> select * from CUSTOMER;
+----+--------------+-----------------+--------+
| ID | NAME         | CONTACT         | STATUS |
+----+--------------+-----------------+--------+
|  1 | Meyer, Eric  | eme22@gmail.com | Active |
|  2 | Sommer, Tina | 030 22458 29425 | Active |
|  3 | Schulze, Tim | +49 171 2358124 | Active |
+----+--------------+-----------------+--------+
3 rows in set (0.01 sec)

