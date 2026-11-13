# check=skip=SecretsUsedInArgOrEnv  # suppress this warning
# 
FROM mysql:8.4
# 
# Build docker image 'mysql-demo-image'
# - docker build -t mysql-demo-image .
# - DOCKER_BUILDKIT=1 docker build -t mysql-demo-image .
# 
# Create & Run container
# - docker run --name mysql-demo-container -p 3306:3306 -d mysql-demo-image
# - docker-compose up
# 
# - docker exec -it mysql-demo-container bash
# 
# - docker exec -it mysql-demo-container mysql -u root -e "SHOW DATABASES;"
# - cat db-data.sql | docker exec -i mysql-demo-container mysql -u root demo_DB
# - docker exec -it mysql-demo-container mysql -u root -e "USE demo_DB; SELECT * FROM users;"
# 
# Clean-up:
# - docker stop mysql-demo-container && docker rm mysql-demo-container && docker rm mysql-demo-image
# 
# Set environment variables for the root user and default database
ENV MYSQL_NATIVE_PASSWORD="ON"
ENV MYSQL_ALLOW_EMPTY_PASSWORD=yes
ENV MYSQL_ROOT_PASSWORD=

# Copy the schema file into the container's entrypoint initialization folder
COPY db-schema.sql /docker-entrypoint-initdb.d/schema.sql

# Expose the default MySQL port
EXPOSE 3306
