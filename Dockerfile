FROM python:3.9-slim
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt  # Convert `environment.yaml` using `pip`
CMD ["python3", "tiny_optimizedSD/tiny_txt2img.py", "--prompt", "A prompt example"]
