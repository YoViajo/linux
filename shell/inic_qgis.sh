#!/bin/bash

# Activar el ambiente de Anaconda
source /home/yoviajo/anaconda3/etc/profile.d/conda.sh
conda activate qgis

# Ejecutar QGIS
qgis

# Desactivar el ambiente de Anaconda al salir de QGIS
conda deactivate
