#!/bin/bash

# Builds the Dockerfile
DOCKER_BUILDKIT=1 docker build -t dohtest:latest .
