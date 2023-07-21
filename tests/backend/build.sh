#!/usr/bin/env bash

cp -fr ./backend/* ./
docker buildx build . --output type=docker,name=elestio4test/infisical-backend:latest | docker load
