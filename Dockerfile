FROM python:3.9-slim

# Install git and any necessary packages
RUN apt-get update && apt-get install -y git && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the requirements file first for caching
COPY requirements.txt .

# Upgrade pip and install the required Python packages
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Copy the rest of your application code
COPY . .

# Command to run your application
CMD ["python3", "tiny_optimizedSD/tiny_txt2img.py", "--prompt", "A prompt example"]
