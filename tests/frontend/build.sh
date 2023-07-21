#!/usr/bin/env bash

cp -fr ./frontend/* ./
docker buildx build . --output type=docker,name=elestio4test/infisical-frontend:latest | docker load
