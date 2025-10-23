FROM jupyter/scipy-notebook:ubuntu-20.04

USER root

RUN apt-get update -y
RUN apt install libgl1-mesa-glx xvfb -y

RUN mamba install -c conda-forge --yes pyvista lmfit matplotlib>=3.10 cmcrameri

USER ${NB_USER}

# Make sure the contents of our repo are in ${HOME}
COPY --chown=${NB_USER}:${NB_USER} . ${HOME}

