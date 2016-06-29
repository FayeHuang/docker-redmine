#!/bin/bash

pg_ip=$1
export PGPASSWORD='redmine'
psql -h $pg_ip -p 5432 -U redmine << EOF
\echo ok
\q
EOF