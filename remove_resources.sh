echo "Deleting Python Flask App Deployment"
kubectl delete deployment mypython-flaskapp
if [ $? -eq 0 ]; then
    echo "Python Flask App Deployment Deleted Successfully"
else
    echo "Error Occured in Deleting Python Flask App Deployment"
fi

echo "Deleting Python Flask App Service"
kubectl delete service mypython-flaskapp-service
if [ $? -eq 0 ]; then
    echo "Python Flask App Service Deleted Successfully"
else
    echo "Error Occured in Deleting Python Flask App Service"
fi