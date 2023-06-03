#!/bin/sh

rm -rf certs
mkdir certs
cd certs
# generate ca key
# generate root certificate
# openssl req -x509 -new -nodes -key ca.key -sha256 -days 1825 -out req.csr -subj "/C=IL/L=Holon/O=Meta/CN=veltzer.com" 
# openssl x509 -req -days 365 -in req.csr -signkey ca.key -out ca.crt
openssl req -x509 \
	-sha256 -days 356 \
	-nodes \
	-newkey rsa:2048 \
	-subj "/CN=demo.mlopshub.com/C=US/L=San Fransisco" \
	-keyout rootCA.key -out rootCA.crt
openssl genrsa -passout pass:'' -out server.key
openssl req -new -key server.key -out server.csr -subj "/C=IL/L=Holon/O=Meta/CN=veltzer.com"
openssl x509 -req \
    -in server.csr \
    -CA rootCA.crt -CAkey rootCA.key \
    -CAcreateserial -out server.crt \
    -days 365 \
    -sha256 
