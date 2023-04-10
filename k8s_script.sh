#!/bin/bash

echo "Script Started Execution ...."

# Entering minikube environment to access docker images inside that virtual env.
eval $(minikube docker-env)

#Deleting Docker Images if created to remove redudancy
echo "Deleting Docker images"
docker rmi -f dhruvohra23/mypython_flaskapp
if [ $? -eq 0 ]; then
    echo "Images Deleted Successfully"
else
    echo "Images Not Present or Error Occured"
fi


# Set environment variables
export IMAGE_NAME=dhruvohra23/mypython_flaskapp
export IMAGE_TAG=latest
export DEPLOYMENT_NAME=mypython-flaskapp-deployment
export SERVICE_NAME=mypython-flaskapp-service


# Pull the latest image from DockerHub
docker pull ${IMAGE_NAME}:${IMAGE_TAG}

# Commands to run K8s Deployment and service for app1 and exposing port to hit from host machine.
cd k8s
kubectl apply -f deployment.yaml
if [ $? -eq 0 ]; then
    echo "Python Flask App Deployment Created"
else
    echo "Error Occured in Creating Python Flask App Deployment"
fi

kubectl apply -f service.yaml
if [ $? -eq 0 ]; then
    echo "Python Flask App Service Created"
else
    echo "Error Occured in Creating Python Flask App Service"
fi

cd ..

# Minikube exposing app to access on localhost
minikube service ${SERVICE_NAME} --url
