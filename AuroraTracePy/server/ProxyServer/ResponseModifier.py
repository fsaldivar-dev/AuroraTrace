from mitmproxy import http

class ResponseModifier:
    def request(self, flow: http.HTTPFlow) -> None:
        if flow.request.pretty_host == "example.com":
            print("Enter google example")
            print("Mapp Mock")
            flow.response = http.Response.make(
                200,  # status code
                b"Respuesta de prueba",  # response body
                {"Content-Type": "text/html"}  # headers
            )
        else :
           socket_response = self.handle_response_from_socket(flow)
           if socket_response:
                flow.response = socket_response
    
    def handle_response_from_socket(self, flow: http.HTTPFlow):
        return None

