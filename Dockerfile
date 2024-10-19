FROM python:3.9-slim

# Install git
RUN apt-get update && apt-get install -y git

WORKDIR /app
COPY . .

# Install the required Python packages
RUN pip install -r requirements.txt

# Command to run your application
CMD ["python3", "tiny_optimizedSD/tiny_txt2img.py", "--prompt", "A prompt example"]
