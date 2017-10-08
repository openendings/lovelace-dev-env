#!/bin/bash
set -eux

# Runs at 'docker run' time.

service postgresql start

trap : TERM INT; sleep infinity & wait
