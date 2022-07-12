'''
 Copyright (C) 2022  luigi311

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; version 3.

 conversejs is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
'''
import http.server
import socketserver

def handler_from(directory):
    def _init(self, *args, **kwargs):
        return http.server.SimpleHTTPRequestHandler.__init__(self, *args, directory=self.directory, **kwargs)
    return type("HandlerFrom<"+directory+">", (http.server.SimpleHTTPRequestHandler,), {'__init__': _init, 'directory': directory})


def main():
    PORT = 9050
    DIRECTORY = "src/www"
    #server directory src/www
    with socketserver.TCPServer(("", PORT), handler_from(DIRECTORY)) as httpd:
        print("serving at port", PORT)
        httpd.serve_forever()

    
if __name__ == "__main__":
    main()
