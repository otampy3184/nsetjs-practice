#!/bin/bash -eu

mysql=( mysql --protocol=socket -uroot -p"${MYSQL_ROOT_PASSWORD}" )

"${mysql[@]}" <<-EOSQL
    GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'%' WITH GRANT OPTION;
EOSQL