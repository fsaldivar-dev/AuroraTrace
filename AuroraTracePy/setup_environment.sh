#!/bin/bash

# Navegar al directorio del proyecto
cd "$(dirname "$0")"

# Crear un entorno virtual
python3 -m venv venv

# Activar el entorno virtual y ejecutar comandos en un subshell
(
  source venv/bin/activate
  pip install -r requirements.txt
)

echo "Environment setup complete and dependencies installed."
echo "To activate the virtual environment, run 'source venv/bin/activate'."
