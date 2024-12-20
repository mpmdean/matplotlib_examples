FROM jupyter/scipy-notebook:ubuntu-20.04

USER root
ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN apt-get update -y
RUN apt install libgl1-mesa-glx xvfb -y

RUN mamba install -c conda-forge --yes pyvista lmfit

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

