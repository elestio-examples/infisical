#!/usr/bin/env bash

cp -r ./frontend/* ./
docker buildx build . --output type=docker,name=elestio4test/infisical-frontend:latest | docker load
