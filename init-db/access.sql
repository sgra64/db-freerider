-- create database 'FREERIDER_DB', if not exists, to assign account
CREATE DATABASE IF NOT EXISTS FREERIDER_DB;

-- create account 'freerider' and grant all privileges
-- - mysql --user=freerider --password=free.ride
-- - mysql -u freerider -p free.ride
-- 
CREATE USER 'freerider'@'%' IDENTIFIED BY 'free.ride';
-- CREATE USER 'freerider'@'%' IDENTIFIED WITH mysql_native_password BY 'free.ride';
GRANT ALL PRIVILEGES ON FREERIDER_DB.* to 'freerider'@'%';


-- test user has been created:
-- mysql> SELECT host, user, plugin FROM mysql.user;
-- +-----------+------------------+-----------------------+
-- | host      | user             | plugin                |
-- +-----------+------------------+-----------------------+
-- | %         | freerider        | caching_sha2_password |
-- | %         | root             | caching_sha2_password |
-- | localhost | mysql.infoschema | caching_sha2_password |
-- | localhost | mysql.session    | caching_sha2_password |
-- | localhost | mysql.sys        | caching_sha2_password |
-- | localhost | root             | caching_sha2_password |
-- +-----------+------------------+-----------------------+
-- 6 rows in set (0.00 sec)
-- 
-- see:
-- https://dev.mysql.com/doc/refman/8.0/en/creating-accounts.html
-- https://github.com/docker-library/mysql/issues/275
