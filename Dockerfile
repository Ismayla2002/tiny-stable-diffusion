# Base image
FROM nvidia/cuda:11.7.1-cudnn8-devel-ubuntu20.04

# Install Conda
RUN apt-get update && apt-get install -y wget bzip2 git && \
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda3-latest-Linux-x86_64.sh

# Set PATH for Conda
ENV PATH=/opt/conda/bin:$PATH

# Copy the environment file and install dependencies
COPY environment.yaml /app/
WORKDIR /app
RUN conda env create -f environment.yaml

# Install the package from the setup.py
COPY . /app
RUN pip install -e .

# Activate environment and run the text-to-image script
SHELL ["conda", "run", "-n", "ldm", "/bin/bash", "-c"]
CMD ["python3", "tiny_optimizedSD/tiny_txt2img.py", "--prompt", "Enter your prompt here"]
