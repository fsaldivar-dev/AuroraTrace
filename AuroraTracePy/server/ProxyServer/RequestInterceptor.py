from mitmproxy import http
import json
import logging

import sys
import os
# Agregar el directorio raíz del proyecto al sys.path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '../..')))

from server.SocketServer import send_request_to_swift

class RequestInterceptor:
    def __init__(self):
        self.logger = logging.getLogger('RequestInterceptor')
        self.logger.setLevel(logging.INFO)
        handler = logging.FileHandler('request_log.json')
        self.logger.addHandler(handler)

    def request(self, flow: http.HTTPFlow) -> None:
        # Mapear los datos de la solicitud
        request_data = {
            "method": flow.request.method,
            "url": flow.request.url,
            "path": flow.request.path,
            "headers": dict(flow.request.headers),
            "query": dict(flow.request.query),
            "host": flow.request.host,
            "port": flow.request.port,
        }

        # Añadir el cuerpo de la solicitud si existe
        if flow.request.content:
            content_type = flow.request.headers.get("Content-Type", "")
            if "application/json" in content_type:
                try:
                    request_data["body"] = json.loads(flow.request.content)
                except json.JSONDecodeError:
                    request_data["body"] = flow.request.content.decode('utf-8', 'ignore')
            else:
                request_data["body"] = flow.request.content.decode('utf-8', 'ignore')

        # Registrar los datos mapeados
        self.logger.info(json.dumps(request_data))

        # Imprimir un resumen en la consola
        print(f"Intercepted request: {flow.request.method} {flow.request.url}")
        send_request_to_swift(f"{flow.request.method} {flow.request.url}")

