#!/usr/bin/env bash
rm -rf ./nginx/
mv nginx-new/ nginx/
rm -f ./frontend/README.md
cp -r ./frontend/* ./
docker buildx build . --output type=docker,name=elestio4test/infisical-frontend:latest | docker load
