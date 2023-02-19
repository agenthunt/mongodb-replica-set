#!/bin/bash 

mongodb1=host.docker.internal
mongodb2=host.docker.internal
mongodb3=host.docker.internal

port1=27021
port2=27022
port3=27023

echo ${mongodb1}:${port1}
echo ${mongodb2}:${port2}
echo ${mongodb3}:${port3}

port=${PORT:-27017}

echo "Waiting for startup.."
until mongosh --host ${mongodb1}:${port1} --eval 'quit(db.runCommand({ ping: 1 }).ok ? 0 : 2)' &>/dev/null; do
  printf '.'
  sleep 1
done

echo "Started.."

echo setup.sh time now: `date +"%T" `
mongosh --host ${mongodb1}:${port1} <<EOF
   var cfg = {
        "_id": "${RS}",
        "version": 1,
        "members": [
            {
                "_id": 0,
                "host": "${mongodb1}:${port1}",
                "priority": 3
            },
            {
                "_id": 1,
                "host": "${mongodb2}:${port2}",
                 "priority": 2
            },
            {
                "_id": 2,
                "host": "${mongodb3}:${port3}",
                 "priority": 1
            }
        ]
    };
    rs.initiate(cfg, { force: true });
    rs.status();
EOF