#!/bin/bash

# Check if the certificate and key files exist, if not, generate them
if [ ! -f /certs/jupyter.crt ] && [ ! -f /certs/jupyter.key ]; then
    echo "Generating SSL certificates..."
    openssl req -x509 -newkey rsa:4096 -keyout /certs/jupyter.key -out /certs/jupyter.crt -days 365 -nodes \
        -subj "/C=US/ST=Oregon/L=Corvallis/O=AutoGenerated/OU=AutoGenerated/CN=localhost/emailAddress=na@AutoGenerated.com"
else
    echo "SSL certificates already exist, skipping generation."
fi

# Start JupyterLab
exec jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --certfile=/certs/jupyter.crt --keyfile=/certs/jupyter.key
