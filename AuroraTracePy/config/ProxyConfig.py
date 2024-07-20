import os
import socket
import logging

logger = logging.getLogger(__name__)

def enable_proxy(http_proxy, https_proxy):
    # Comandos para habilitar el proxy en macOS
    logger.info(f"Configuring proxy: networksetup -setwebproxy Wi-Fi {http_proxy} 8080")
    os.system(f'networksetup -setwebproxy Wi-Fi {http_proxy} 8080')
    os.system(f'networksetup -setsecurewebproxy Wi-Fi {https_proxy} 8080')
    os.system('networksetup -setwebproxystate Wi-Fi on')
    os.system('networksetup -setsecurewebproxystate Wi-Fi on')

def disable_proxy():
    # Comandos para deshabilitar el proxy en macOS
    os.system('networksetup -setwebproxystate Wi-Fi off')
    os.system('networksetup -setsecurewebproxystate Wi-Fi off')

def get_local_ip():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    try:
        s.connect(('8.8.8.8', 1))
        ip = s.getsockname()[0]
    except Exception:
        ip = '127.0.0.1'
    finally:
        s.close()
    return ip
