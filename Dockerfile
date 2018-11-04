# Use an official Python runtime as a parent image
FROM python:3.5-slim

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip3 install --trusted-host pypi.python.org -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 5678

# Run app.py when the container launches
# CMD ["gunicorn", "-w", "4", "-b", "[::]:5678", "--certfile=ssl-cert-snakeoil.pem", "--keyfile=ssl-cert-snakeoil.key", "myapp:app"]
CMD ["gunicorn", "-w", "4", "-b", "[::]:5678", "myapp:app"]
