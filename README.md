# ConverseJS

Original Implementation: https://github.com/poVoq/conversejs-ubports

This is an unofficial HTML5 wrapper for the ConverseJS Jabber / XMPP chat client. Thanks a lot to the ConverseJS team, they did all the hard work! Check it out here: https://conversejs.org/

NOTE: YOUR XMPP SERVER MUST HAVE *CORS* ENABLED FOR BOSH OR WEBSOCKET CONNECTIONS!

Speed/usability on mobile devices is not the best (a native qt based client would be much better), but it supports a lot of modern features of XMPP including end to end encryption with OMEMO. As everything is stored on your device, OMEMO is available by default (but always check the padlock!). ConverseJS also supports OMEMO encryption in group-chats, but only if the group-chat is set to "members only" and "non-anonymous". These are the same criteria as used by the popular Android XMPP client Conversations.

As a HTML5 client it connects via websockets or a BOSH connection, not the usual way other XMPP clients via a direct TCP connection. So you need to check with your XMPP server operator what the URL of these services is and if CORS is enabled. If the server has auto-discovery via XEP-0156 (XML only) the URL should be automatically configured (untested).

Push notifications are not supported :(

If you click "Automatic login" the app permanently stores your user credentials (in clear-text!) in your browser storage and will automatically log in when you open the app. This is recommended as otherwise you need to manually log in again every time UT puts the app to sleep in the background. Removal of this account lock is only possible with the UT tweak-tool (by deleting the app cache and data) once enabled!  

Please see the list of known issues on the linked Github page.

## License

Copyright (C) 2022  luigi311

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License version 3, as published
by the Free Software Foundation.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranties of MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
