#!/bin/bash
./certs.sh
mkdir -p ./gitlab/config
mkdir -p ./gitlab/data
mkdir -p ./gitlab/logs
mkdir -p ./netdata/netdata_cache
mkdir -p ./netdata/netdata_config
mkdir -p ./netdata/netdata_lib
mkdir -p ./backup
cp ./config.toml ./runner/config/
echo "Most már futtathatod: docker-compose up -d"