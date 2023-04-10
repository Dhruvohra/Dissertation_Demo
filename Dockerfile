# Use an official Python runtime as a parent image
FROM python:3.8-slim-buster

# Set environment variables for Python and Docker
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV DOCKER_BUILD true

# Set the working directory to /app
WORKDIR /app

# Install OS security updates
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
        tzdata \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code into the container
COPY . /app

# Change to a non-root user
RUN useradd -m myuser
USER myuser

# Expose port 5000 for the Flask app to listen on
EXPOSE 5000

# Installing gunicorn
RUN pip install gunicorn

# Setting the path for gunicorn
ENV PATH="/home/myuser/.local/bin:${PATH}"

# Run the command to start the Flask app
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
