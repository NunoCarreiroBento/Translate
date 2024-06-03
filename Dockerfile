# Use the official Apache image from the Docker Hub
FROM httpd:2.4

# Install required packages: Python and mod_wsgi
RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv libapache2-mod-wsgi-py3 && \
    apt-get clean

# Create a directory for the app
WORKDIR /app

# Copy the Flask app and requirements file into the container
COPY app.py /app/app.py
COPY requirements.txt /app/requirements.txt

# Create a virtual environment
RUN python3 -m venv venv

# Install required Python packages in the virtual environment
RUN /app/venv/bin/pip install --no-cache-dir -r /app/requirements.txt

# Copy the WSGI entry point into the container
COPY app.wsgi /app/app.wsgi

# Copy the Apache configuration file
COPY flaskapp.conf /usr/local/apache2/conf/extra/flaskapp.conf

# Include the Flask app configuration in the main Apache config
RUN echo "Include /usr/local/apache2/conf/extra/flaskapp.conf" >> /usr/local/apache2/conf/httpd.conf

# Expose the port Apache is running on
EXPOSE 80

# Command to start Apache in the foreground
CMD ["httpd-foreground"]
