import sys
import os

# Agregar el directorio raíz del proyecto al sys.path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '../..')))


import logging
from ResponseModifier import ResponseModifier
from RequestInterceptor import RequestInterceptor
logger = logging.getLogger(__name__)


addons = [
    RequestInterceptor(),
    ResponseModifier()
]
