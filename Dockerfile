FROM continuumio/miniconda3
MAINTAINER James Jeffryes <jamesgjeffryes@gmail.com>

ENV PATH /opt/conda/bin:$PATH
ENV LANG C

# 3.7 seems to be supported now
RUN conda install python=3.7
# install the RDKit:
RUN conda config --add channels  https://conda.anaconda.org/rdkit
# note including jupyter in this brings in rather a lot of extra stuff
RUN conda install -y cairo \
                     cairocffi \
                     nomkl \
                     pandas \
                     pymongo \
                     rdkit

COPY minedatabase/ /mine/minedatabase/
RUN apt-get -y update && apt-get -y install libxrender1 && rm -rf /var/lib/apt/lists/*
ENV PYTHONPATH $PYTHONPATH:/mine
WORKDIR /mine/minedatabase
ENTRYPOINT ["python", "pickaxe.py"]
