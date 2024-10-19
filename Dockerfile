FROM continuumio/miniconda3

WORKDIR /app

COPY environment.yaml .
RUN conda env create -f environment.yaml

SHELL ["conda", "run", "-n", "your-env-name", "/bin/bash", "-c"]

COPY . .

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
