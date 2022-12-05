###########################################################################
# Project environment inside MySQL container. Source with:
#   source /mnt/.env.sh
#
MYSQL_HOME="/usr/bin"
export MYSQL_DATABASE="FREERIDER_DB"
export MYSQL_USER="freerider"
export MYSQL_PASSWORD="free.ride"
export MYSQL_ROOT_PASSWORD="password"

# overload mysql client command
function mysql() {
    "${MYSQL_HOME}/mysql" \
        --default-character-set=utf8 \
        --user="${MYSQL_USER}" --password="${MYSQL_PASSWORD}" \
    ;
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
