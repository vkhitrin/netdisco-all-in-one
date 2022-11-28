#! /usr/bin/env sh
su postgres -c 'pg_ctl start -D /var/lib/postgresql/data'
/root/netdisco_deploy.expect
netdisco-backend foreground &
netdisco-web foreground &
wait -n
