#!/bin/bash

dir="/var/lib/postgresql/data"
# PostgreSQL admin creation
adduser --no-create-home postgres

# make data directory & owner configuration
mkdir -p ${dir}
chown -R postgres:postgres ${dir}