#!/usr/bin/env bash
rm -rf ./nginx/
mv nginx-new/ nginx/
cp -r ./backend/* ./
docker buildx build . --output type=docker,name=elestio4test/infisical-backend:latest | docker load
