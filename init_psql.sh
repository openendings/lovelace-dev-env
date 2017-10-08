#!/bin/bash
set -eux

service postgresql start

# PSQL needs explicitly initialised roles
psql postgres -c 'CREATE ROLE sally;'
psql postgres -c 'CREATE ROLE lovelace;'

# train-dbinit needs keyboard input ;_;
cat <<EOF | train-dbinit train
sally
sally
c cpp caml java py
y
EOF

train-dbuser -o lovelace
