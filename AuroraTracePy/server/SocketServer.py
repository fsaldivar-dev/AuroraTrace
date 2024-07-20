import signal
import sys
import logging
import subprocess
from config.ProxyConfig import enable_proxy, disable_proxy, get_local_ip
import os

logger = logging.getLogger(__name__)
process = None

def handle_exit(signum, frame):
    print("Shutting down and disabling proxy...")
    disable_proxy()
    sys.exit(0)

# Configure signals to capture application shutdown
signal.signal(signal.SIGINT, handle_exit)  # Ctrl+C
signal.signal(signal.SIGTERM, handle_exit) # Termination from the OS

def setup_proxy():
    global process
    local_ip = get_local_ip()
    enable_proxy(local_ip, local_ip)
    logger.info(f"Proxy enabled with IP: {local_ip}")
    print("Hi Javi")
    process = subprocess.Popen(["mitmdump", "-s", "server/ProxyServer/ProxyServer.py"])
    process.wait()
    if process.returncode != 0:
        logger.error("Failed to start mitmdump")
        print("Error: Failed to start mitmdump")
        return

if __name__ == "__main__":
    if len(sys.argv) > 1:
        if sys.argv[1] == "setup_proxy":
            setup_proxy()
        else:
            print(f"Unknown function {sys.argv[1]}")
    else:
        print("No function specified")
