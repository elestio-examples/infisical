#!/usr/bin/env bash

cp -r ./backend/* ./
docker buildx build . --output type=docker,name=elestio4test/infisical-backend:latest | docker load
