#!/bin/bash
dir="/var/lib/postgresql/data"
# init db with non-root user

# bring ip address of backend container 
# pg_hba.conf file update

su - postgres <<EOF
/usr/lib/postgresql/16/bin/initdb -D ${dir}
pg_createcluster 16 main --start
EOF

/usr/sbin/service postgresql start

sleep 1

while true; do
    db_ip=$(getent hosts db | cut -d' ' -f1)
    if [ -n "$db_ip" ]; then
        echo "db_ip: ${db_ip}"
        echo "host all all ${db_ip}/24 md5" >> /etc/postgresql/16/main/pg_hba.conf
        break
    else
        sleep 1
    fi
    tail -5 /etc/postgresql/16/main/pg_hba.conf
done


su - postgres <<EOF
/usr/lib/postgresql/16/bin/psql -c "ALTER USER postgres WITH PASSWORD 'n1234';"
EOF
# start PostgreSQL service
/usr/sbin/service postgresql restart

while true; do sleep 1000; done