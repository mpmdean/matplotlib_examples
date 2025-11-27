FROM ghcr.io/pyvista/pyvista:v0.46.4

USER root

RUN apt-get update && apt-get install -y \
    dvipng \
    texlive-latex-extra \
    texlive-fonts-recommended \
    cm-super \
    fonts-recommended \
    ghostscript \
    # Clean up apt lists to reduce image size
    && rm -rf /var/lib/apt/lists/*

USER jovyan

RUN pip install scipy lmfit cmcrameri ipympl ipywidgets
