#!/usr/bin/env bash
rm -rf ./nginx
cp -r ./frontend/* ./
docker buildx build . --output type=docker,name=elestio4test/infisical-frontend:latest | docker load
