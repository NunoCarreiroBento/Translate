# Use the official Apache image from the Docker Hub
FROM httpd:2.4

# Install required packages: Python and mod_wsgi
RUN apt-get update && \
    apt-get install -y python3 python3-pip apache2-dev && \
    pip3 install mod_wsgi && \
    apt-get clean

# Install required Python packages
COPY requirements.txt /app/requirements.txt
RUN pip3 install --no-cache-dir -r /app/requirements.txt

# Copy the Flask app into the container
COPY app.py /app/app.py

# Configure Apache to serve the Flask app
COPY flaskapp.conf /usr/local/apache2/conf/httpd.conf

# Expose the port Apache is running on
EXPOSE 80
