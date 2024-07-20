import sys
from server.SocketServer import setup_proxy

if __name__ == "__main__":
    if len(sys.argv) > 1:
        if sys.argv[1] == "setup_proxy":
            setup_proxy()
        else:
            print(f"Unknown function {sys.argv[1]}")
    else:
        print("No function specified")
