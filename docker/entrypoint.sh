#!/bin/sh
set -eu

# Initialise once before starting workers; preserve existing products on restart.
python seed_data.py --if-empty
exec "$@"
