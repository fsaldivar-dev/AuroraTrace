import sys
import os

# Agregar el directorio raíz del proyecto al sys.path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '../..')))

import json
import logging
from mitmproxy import http
from datetime import datetime
from models.Models import RequestModel, ResponseModel, LogEntry
from ResponseModifier import ResponseModifier
from RequestInterceptor import RequestInterceptor
logger = logging.getLogger(__name__)


addons = [
    RequestInterceptor(),
    ResponseModifier()
]
