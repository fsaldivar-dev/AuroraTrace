import socket
import json
import logging

# Configuración del logger
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def send_request_to_swift(request_data):
    host = '127.0.0.1'
    port = 65432
    
    try:
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.connect((host, port))
            message = json.dumps(request_data)
            s.sendall(message.encode('utf-8'))

            # Receive the response from the server
            response = s.recv(65536)
            
            # Decode the response
            decoded_response = response.decode('utf-8')
            
            # Handle empty response
            if not decoded_response:
                # If the response is empty, you can simply return a default value or continue
                return {}  # You can change this to whatever is appropriate in your case
            else:
                # Process the response as JSON
                logger.info(f"Socket response: {decoded_response}")
                return {}
    except socket.error as e:
        error_message = (
            f"Socket error: Unable to connect to the socket at {host}:{port}. "
            f"To receive information, please ensure that the socket is up and running on {host} and port {port}."
        )
        logger.warning(error_message)
        return {}

