# syntax=docker/dockerfile:1.0.0-experimental
FROM python:slim
RUN apt-get update && apt-get -y upgrade \
  && apt-get install -y --no-install-recommends \
    git \
    wget \
    g++ \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"
COPY ./environment.yml/ /app/
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh \
    && echo "Running $(conda --version)" && \
    conda init bash && \
    . /root/.bashrc && \
    conda update conda && \
    conda env create -f /app/environment.yml && \
	conda activate gai-jupyter-server
COPY ./dev/ /app/dev/
RUN echo "conda activate gai-jupyter-server \n" >> /root/.bashrc
ENTRYPOINT [ "/bin/bash", "-l" ]
CMD ["/app/dev/sh/start-jupyter-server.sh"]
EXPOSE 8686