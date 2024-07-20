import socket
import json

def send_request_to_swift(request_data):
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.connect(('127.0.0.1', 65432))
        message = json.dumps(request_data)
        s.sendall(message.encode('utf-8'))

        # Recibe la respuesta del servidor
        response = s.recv(65536)
        
        # Decodifica la respuesta
        decoded_response = response.decode('utf-8')
        
        # Maneja la respuesta vacía
        if not decoded_response:
            # Si la respuesta está vacía, puedes simplemente retornar un valor por defecto o continuar
            return {}  # Puedes cambiar esto a lo que consideres adecuado en tu caso
        else:
            # Procesa la respuesta como JSON
            print(f"response Socket {decoded_response}")
            return {}
