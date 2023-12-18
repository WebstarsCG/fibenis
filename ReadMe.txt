-- Install
1. Create your application folder, for example say "webpp"
2. Move the fibenis folders from def to theme & five other files to the folder "webapp"
3. The doc/db folder has the sql files 
    1.fibenis_nano_0.0.sql
    2.fibenis_nano_0.1.sql
4. Create a database, for example "webapp" for your application
5. If you have phpmyadmin, import the .sql files in the order 0.0 than 0.1
6. If you have to do by command prompt, check the SQL-Manual section
6.1 Once successfully inserted, you can remove the DB files are disable the permission to access for security reasons
7. Than update the DB info & app server path in the configuration file
   named - fE7zRhHqYfSLT9CRm55cBPGHjAGuhqhhjKGSZrB.php
8. Set the DB & configurations,
    "host"          => "localhost",       // host info
    "db_name"       => '<db_name>',
    "user"          => '<db_user_name>',
    "pass"          => "<db_password>",
    "domain_name"   => "https://localhost/webapp" // application path in http server
9. File execute permissions (If the server is Linux OS)
-- permission changes
chmod 755 index.php
chmod 755 router.php
chmod 777 terminal
10. If set, check you app domain path, https://localhost/webapp
    If configured correctly, it will ask for user name and password.

    Default Login Details:
    User: sa@webstarscg.com
    Password: test
---SQL-Manual----------------------------------------------------------------------------------------------------------------------------
-- Manual MySQL/MariaDB basic queries for DB 

-- DB creation
CREATE DATABASE <db_name>;

-- function creator permission
SET GLOBAL log_bin_trust_function_creators = 1;

-- db imports/run from system cmd
mysql -h localhost -u root <db_name> < doc/db/fibenis_nano_0.0.sql
mysql -h localhost -u root <db_name> < doc/db/fibenis_nano_0.1.sql

-- user creation
CREATE USER '<user>'@'<host_name>' IDENTIFIED BY '<password>';
GRANT ALL PRIVILEGES ON *.* TO '<user>'@'<host_name>' WITH GRANT OPTION;
-------------------------------------------------------------------------------------------------------------------------------


