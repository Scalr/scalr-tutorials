#!/bin/bash
set -o errexit
set -o nounset

apt-get install -y monit

# Configure and start replmon

cat > /etc/replmon.ini << EOF
[mysql]
user = $MYSQL_USERNAME
passwd = $MYSQL_PASSWORD
EOF

/usr/local/bin/replmon

# Configure and start monit
cat > /etc/monit/conf.d/replmon.conf << EOF
check process replmon with pidfile /var/run/replmon.pid
    start program = "/usr/local/bin/replmon"
    stop program = "/bin/bash -c '/bin/kill \`/bin/cat /var/run/replmon.pid\`'"
    if 3 restarts within 5 cycles then timeout
    depends on replmon.ini

check file replmon.ini with path /etc/replmon.ini
    if changed checksum
        then restart

check file replicationStatus with path /var/run/replmon.status
    if timestamp > 10 seconds then exec "/usr/local/bin/szradm --fire-event=ReplicationFailed"
EOF

service monit restart
