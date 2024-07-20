from datetime import datetime

class RequestModel:
    def __init__(self, method, url, headers, body):
        self.method = method
        self.url = url
        self.headers = headers
        self.body = body

class ResponseModel:
    def __init__(self, status_code, headers, body):
        self.status_code = status_code
        self.headers = headers
        self.body = body

class LogEntry:
    def __init__(self, request: RequestModel, response: ResponseModel):
        self.request = request
        self.response = response
        self.timestamp = datetime.now().isoformat()
