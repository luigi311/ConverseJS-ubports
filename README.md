# ConverseJS

Jabber chat with OMEMO encryption

## How to update

### Conversejs
Download the latest conversejs release from the github page https://github.com/conversejs/converse.js/releases, the full release not the headless one. Delete www/dist and drop in the dist folder from the new release. Assuming nothing major has changed in how conversejs is initialized everything else should work. In the event that the initialization is changed then you will need to edit www/index.html and update the startconversejs function at the bottom.

### Webserver
Webserver is utilizing actix_web in a seperate thread. This utilizes version 3 as ubuntu touch 16.04 builtin rust version does not support version 4+. Once ubuntu touch is updated with a newer base and a higher version of rust we can update this to the latest version by editing the Cargo.toml file and do the same with actix-files. This should hopefully be a simple update process as we are not doing anything special with the web server as it just serves static files.

## License

Copyright (C) 2022  luigi311

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License version 3, as published
by the Free Software Foundation.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranties of MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
