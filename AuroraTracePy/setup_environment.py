import os
import subprocess
import sys

def create_virtual_environment():
    print("Creating virtual environment...")
    subprocess.run([sys.executable, '-m', 'venv', 'venv'])

def activate_virtual_environment():
    print("Activating virtual environment...")
    activate_script = os.path.join('venv', 'bin', 'activate')
    
    # Use exec to replace the shell with the virtual environment shell
    os.execv(sys.executable, [sys.executable, "-c", f"import os; os.system('. {activate_script} && /bin/bash')"])


def install_dependencies():
    print("Installing dependencies...")
    subprocess.run([sys.executable, '-m', 'pip', 'install', '-r', 'requirements.txt'])

if __name__ == "__main__":
    create_virtual_environment()
    activate_script = activate_virtual_environment()
    print(f"To activate the virtual environment, run 'source {activate_script}'")
    install_dependencies()
    print("Environment setup complete and dependencies installed.")
