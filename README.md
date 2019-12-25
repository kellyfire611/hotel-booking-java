# cần chỉnh setting MYSQL
## UTF 8 Settings
init-connect=\'SET NAMES utf8mb4\'
collation_server=utf8mb4_unicode_ci
character_set_server=utf8mb4
#skip-character-set-client-handshake
#character_sets-dir="C:/xampp/mysql/share/charsets"

[mysqldump]
quick
max_allowed_packet = 16M

[mysql]
no-auto-rehash
# Remove the next comment character if you are not familiar with SQL
#safe-updates
default-character-set=utf8mb4


# Chỉnh CONFIG TOMCAT
/conf/server.xml
<Connector ... URIEncoding="UTF-8">