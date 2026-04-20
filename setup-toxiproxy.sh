#!/bin/bash

echo "Creating proxy..."

curl -X POST http://localhost:8474/proxies \
  -H "Content-Type: application/json" \
  -d '{
    "name": "flask_proxy",
    "listen": "0.0.0.0:8666",
    "upstream": "app:5000"
  }'

echo "Done!"