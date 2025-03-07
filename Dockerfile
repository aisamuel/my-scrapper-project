# Use the official Python image
FROM python:3.12-slim

# Set the working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y netcat && apt-get clean

# Copy the requirements.txt first and install dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy the project files
COPY . /app/

# Copy and make entrypoint.sh executable
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose the application port
EXPOSE 8000

# Set entrypoint to start the Django application
ENTRYPOINT ["/entrypoint.sh"]
