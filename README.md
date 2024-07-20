# AuroraTrace

AuroraTrace is a powerful and poetic proxy application designed to reflect, trace, and display the requests and responses of your application. Whether you are a developer seeking to debug your app or an enthusiast exploring the dynamics of request handling, AuroraTrace provides a luminous path to clarity and insight.

## Features

- **Request and Response Logging**: Capture and display detailed logs of all requests and responses passing through the proxy.
- **Mock Responses**: Easily configure and return mock responses to simulate different scenarios and test your application.
- **User-Friendly Interface**: Intuitive and easy-to-use interface for monitoring and managing logs.
- **Flexible Configuration**: Highly customizable to fit various use cases and requirements.

## Project Structure

The project is divided into two main parts:

1. `AuroraTrace/`: Contains the Xcode project with the iOS application developed in SwiftUI.
2. `AuroraTracePy/`: Contains the Python proxy server based on mitmproxy.


## Getting Started

Follow these steps to set up and run the complete project.

### Prerequisites

- Xcode 14.0 or higher
- Python 3.8 or higher
- pip (Python package manager)

### Python Server Setup

1. Navigate to the Python server directory:
   ```
   cd AuroraTracePy
   ```

2. (Optional) Create and activate a virtual environment:
   ```
   python3 -m venv venv
   source venv/bin/activate
   ```

3. Install dependencies:
   ```
   pip install -r requirements.txt
   ```

4. Start the server manually:
   ```
   python main.py setup_proxy
   ```

   The server should now be running on `localhost:8080`.

### iOS Application Setup

1. Open the Xcode project:
   ```
   open AuroraTrace/AuroraTrace.xcodeproj
   ```

2. In Xcode, select an iOS simulator or device as the target.

3. Run the application by pressing `Cmd + R` or clicking the play button.

### Connecting the Application to the Server

To enable communication between the iOS application and the proxy server:

1. Ensure that both the iOS device (or simulator) and the machine running the server are on the same Wi-Fi network.

2. In the iOS application, go to settings and enter your machine's IP address and the server port (default is 8080).

3. Activate the option to use the proxy in the application.

## Development

- To modify the proxy server logic, edit the files in `AuroraTracePy/server/ProxyServer/`.
- For changes to the iOS application, work on the SwiftUI files within the Xcode project in `AuroraTrace/`.

## Troubleshooting

- If you encounter issues connecting the application to the server, verify that both are on the same network and that the firewall is not blocking connections.
- For Python server issues, check the logs in `AuroraTracePy/logs/`.

# Usage
AuroraTrace can be used to:

Debug Applications: Monitor and analyze the traffic between your application and the server.
Simulate Scenarios: Use mock responses to test your application under different conditions.
Educate and Learn: Explore the inner workings of HTTP requests and responses.
License
AuroraTrace is licensed under the MIT License. For more details, see the LICENSE file.

# License
AuroraTrace is licensed under the MIT License. For more details, see the [LICENSE](./LICENSE) file.

# Disclaimer
Please read the [DISCLAIMER](./DISCLAIMER.md) before using AuroraTrace.

# Code of Ethics
By using AuroraTrace, you agree to adhere to our [Code of Ethics](./ETHICS.md).
