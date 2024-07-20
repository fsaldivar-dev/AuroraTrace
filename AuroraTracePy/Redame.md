# AuroraTrace - Environment Setup for macOS

## Setting Up the Python Environment

### Create a Virtual Environment

1. **Navigate to your project directory**:

   ```sh
   cd /path/to/AuroraTracePy
   ```
2. **Create a virtual environment**:

```Python
python3 -m venv venv
```

3.- **Activate the virtual environment**:

```Python
source venv/bin/activate

```

4.- **Install the necessary dependencies:**:

```sh
pip install -r requirements.txt
```

Deactivate the Virtual Environment
When you have finished working, you can deactivate the virtual environment:

5.- **Update Pip**:

```sh
pip install --upgrade pip
```

6.- **Execute**:
```sh
python3 main.py setup_proxy
```

7.- **Desactive**:
``` sh
deactivate
```