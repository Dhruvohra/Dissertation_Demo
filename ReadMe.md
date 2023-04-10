
## Dockerfile Explaination

### Here's a brief explanation of each section and how it follows best practices and security measures:

### 1) FROM python:3.8-slim-buster: This starts with an official Python runtime image based on Debian 10 (Buster) with a minimal set of packages installed.

### 2) ENV PYTHONDONTWRITEBYTECODE 1 and ENV PYTHONUNBUFFERED 1: These prevent Python from writing .pyc files and buffering output to the console, respectively.

### 3) ENV DOCKER_BUILD true: This is an environment variable that can be used to conditionally run specific commands during Docker builds (in this case, to install OS security updates).

### 4) WORKDIR /app: This sets the working directory to /app, which is a best practice for organizing application files.

### 5) RUN apt-get update \ && apt-get upgrade -y \ && apt-get install -y --no-install-recommends \ tzdata \ ca-certificates \ && rm -rf /var/lib/apt/lists/*: This installs OS security updates, sets the timezone, and installs ca-certificates for verifying SSL certificates. The --no-install-recommends flag ensures that only required packages are installed.

### 6) COPY requirements.txt /app/: This copies the requirements.txt file into the container.

### 7) RUN pip install --no-cache-dir -r requirements.txt: This installs Python dependencies using pip with the --no-cache-dir flag to avoid caching pip packages in the container.

### 7) COPY . /app: This copies the rest of the application code into the container.

### 8) RUN useradd -m myuser and USER myuser: This creates a non-root user called myuser and switches to that user, which is a best practice for running applications in containers.

### 9) EXPOSE 5000: This exposes port 5000 for the Flask app to listen on.

### 10 & 11) Installing gunicorn and creating a path for it.

### 12) CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]: This starts the Flask app using Gunicorn, which is a production-ready WSGI server. The --bind flag binds Gunicorn to port 5000, and app:app specifies the Flask app object to run.

### 13) Overall, this Dockerfile follows best practices by using a minimal base image, installing only required packages, setting environment variables, and running the app as a non-root user.


## Shell Scripts Insights:

### As we have created the dockerfile and build the images, plus executes the k8s deployments and service via shell script now its the time to open the external ports for apps to access from host machine. #This is an additional step becuz of minikube.

### 1) dockerhub_script.sh: this file builds the dockerfile and pushes it onto dockerhub. 

## Note: To run this you need to have environment variables set as :

### export DOCKER_USERNAME=my_username
### export DOCKER_PASSWORD=my_password

### 2) k8s_script.sh: It enter's minukube env delete existing image if any, pull new image from docker image, start deployment for our app and then creates a service for it after that exposes an endpoint to be accessible in our localhost.

### 3) remove_resources.sh: This is deleting the already created deployment and service so the memory is free once your work is done.



## Application Insights: 
## app.py: This file is the main Python Flask application that sets up the server and defines the various routes for handling incoming requests. In this specific project, there is only one route defined for the root URL ("/"), and it simply renders the index.html template.

## index.html: This file is an HTML file that defines the structure and content of the web page that will be served to the user. It includes a header section, a main section with multiple columns, and a couple of blog post sections. It also includes a reference to a stylesheet (style.css) that defines the visual appearance of the web page.

## style.css: This file is a CSS file that defines the visual appearance of the web page. It includes rules for styling various HTML elements such as headers, images, columns, and blog posts.