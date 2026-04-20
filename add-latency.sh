#!/bin/bash

curl -X POST http://localhost:8474/proxies/flask_proxy/toxics \
  -H "Content-Type: application/json" \
  -d '{
    "type": "latency",
    "attributes": {
      "latency": 3000
    }
  }'