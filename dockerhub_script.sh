#!/bin/bash

# Set environment variables
# export DOCKER_USERNAME=my_username
# export DOCKER_PASSWORD=my_password

IMAGE_NAME=dhruvohra23/mypython_flaskapp
IMAGE_TAG=latest

# Build Docker image
echo "Building Docker image..."
docker build -t $IMAGE_NAME:$IMAGE_TAG .

# Check if build succeeded
if [ $? -ne 0 ]; then
    echo "Docker build failed"
    exit 1
fi

# Login to Docker Hub
echo "Logging in to Docker Hub..."
echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin

# Push Docker image to Docker Hub
echo "Pushing Docker image to Docker Hub..."
docker push $IMAGE_NAME:$IMAGE_TAG

# Check if push succeeded
if [ $? -ne 0 ]; then
    echo "Docker push failed"
    exit 1
fi

echo "Docker image build and push complete"
