#!/usr/bin/env python3
import http.server
import socketserver
import os
import sys
from urllib.parse import urlparse, unquote

PORT = 52116  # Using the port provided in the runtime information

class CustomHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        self.directory = os.path.join(os.getcwd(), "GO Appeee - documentation")
        super().__init__(*args, **kwargs)
    
    def translate_path(self, path):
        """Translate a /-separated PATH to the local filename syntax."""
        # Extract the path from the URL
        parsed_path = urlparse(path)
        path = parsed_path.path
        path = unquote(path)
        
        # Make it relative to the directory we're serving
        path = path.strip('/')
        path = os.path.join(self.directory, path)
        
        # If it's a directory, look for index.html
        if os.path.isdir(path):
            index_path = os.path.join(path, 'index.html')
            if os.path.exists(index_path):
                return index_path
        
        return path

    def end_headers(self):
        # Add CORS headers
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'X-Requested-With, Content-Type')
        super().end_headers()

def run_server():
    handler = CustomHTTPRequestHandler
    
    with socketserver.TCPServer(("0.0.0.0", PORT), handler) as httpd:
        print(f"Serving documentation at http://localhost:{PORT}")
        print("Press Ctrl+C to stop the server")
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\nServer stopped.")
            sys.exit(0)

if __name__ == "__main__":
    run_server()