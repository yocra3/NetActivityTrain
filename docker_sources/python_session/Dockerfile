FROM tensorflow/tensorflow:2.7.0
LABEL authors="Carlos Ruiz-Arenas" \
      description="Docker image containing the python packages for Episignatures project"

## Install python dependencies
RUN pip install -U scikit-learn matplotlib scipy pandas
RUN apt-get update
RUN apt-get install -y git python3.8-venv

RUN pip install -q tensorflow-model-optimization
