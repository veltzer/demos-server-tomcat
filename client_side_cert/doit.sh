#!/bin/sh

rm -rf certs
mkdir certs
cd certs
openssl genrsa -des3 -out myCA.key 2048
