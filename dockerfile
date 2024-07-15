#Use an official Python runtime as the base image
FROM python:3-slim

# Copy the host's CA certificates to the container
COPY resources/  resources/
RUN cat resources/cert/ca-certificates.cer  >> /etc/ssl/certs/ca-certificates.crt
ENV REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt

#Set the working directory in the container to app
WORKDIR /app

#Copy the current directory contents into the container at /app
COPY . /app

# Install the required packages
RUN pip install --no-cache-dir -r requirements.txt

# Set enviroment variable for Flask
ENV FLASK_APP=app.py

#Run the command to start the Flask application
CMD ["flask", "run", "--host=0.0.0.0"]
