# ConverseJS

Jabber chat with OMEMO encryption

## How to update

### Conversejs
Download the latest conversejs release from the github page https://github.com/conversejs/converse.js/releases, the full release not the headless one. Delete src/www/dist and drop in the dist folder from the new release. Assuming nothing major has changed in how conversejs is initialized everything else should work. In the event that the initialization is changed then you will need to edit src/index.html and update the startconversejs function at the bottom.

### Webserver
The webserver is located in the libs folder and the actual source comes from here https://github.com/azadkuh/qhttp, this webserver is not maintained anymore but is one of the only webservers that can be ran from the version of QT that ubuntu touch 16.04 has access too. This can be replaced with a more modern web server once ubuntu touch is updated for 20.04+. Attempts were made to use pythons builtin web server but ran into issues with having that run concurently as ubuntu touch did not allow me to use QProcess to run it in another thread. If this is resolved then something like pythons http.server should work or something else thats more performant such as sanic would be better https://github.com/sanic-org/sanic using the static file hosting to host the entire src/www folder.

## License

Copyright (C) 2022  luigi311

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License version 3, as published
by the Free Software Foundation.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranties of MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
