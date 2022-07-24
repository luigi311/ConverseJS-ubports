/*
 * Copyright (C) 2022  luigi311
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * conversejs is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import Qt.labs.settings 1.1
import Qt.labs.platform 1.1
import QtWebEngine 1.11
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import Ubuntu.Content 1.3


ApplicationWindow {
    id: root
    objectName: 'mainView'

    width: units.gu(45)
    height: units.gu(75)
    visible: true


    PageStack {
        id : mainPageStack
        anchors.fill : parent
        // Shrink the window whenever the keyboard is shown so that the chat area is not covered by the keyboard
        anchors {
            fill : parent
            bottomMargin : UbuntuApplication.inputMethod.visible
                ? UbuntuApplication
                    .inputMethod
                    .keyboardRectangle
                    .height / Screen.devicePixelRatio
                : 0
            Behavior on bottomMargin {
                NumberAnimation {
                    duration : 175
                    easing.type : Easing.OutQuad
                }
            }
        }

        Component.onCompleted : mainPageStack.push(mainPage)

        // Page to hold the app itself
        Page {
            id : mainPage
            anchors.fill : parent

            WebEngineView {
                id : webView
                anchors.fill : parent

                focus : true
                url : "http://localhost:9090/index.html"

                settings.pluginsEnabled : true
                settings.javascriptEnabled : true
                settings.showScrollBars : false

                // Set chromium settings for storing data locally and the useragent
                profile : WebEngineProfile {
                    id : webContext
                    storageName : "Storage"
                    httpUserAgent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Safari/537.36"
                    // Dynamically set the storage location using QT's QStandardPaths for application data, should be cross platform
                    // remove file:/// from the beginning of the StandardPaths.standardLocations(StandardPaths::AppDataLocation)[0]
                    persistentStoragePath : StandardPaths.standardLocations(StandardPaths.AppDataLocation)[0].substring(7) + "/QtWebEngine"
                }

                // Open the ImportPage.qml whenever the user clicks on a file releated function such as adding attachments
                onFileDialogRequested: function(request) {
                    request.accepted = true;
                    var importPage = mainPageStack.push(Qt.resolvedUrl("ImportPage.qml"),{"contentType": ContentType.All, "handler": ContentHandler.Source})
                    importPage.imported.connect(function(fileUrl) {
                        console.log("files: " + fileUrl)
                        request.dialogAccept(fileUrl);
                    })
                }

                // Open links externally when the user clicks on them such as a youtube link will open the youtube app or the browser
                onNewViewRequested: {
                    request.action = WebEngineNavigationRequest.IgnoreRequest
                    if(request.userInitiated) {
                        Qt.openUrlExternally(request. requestedUrl)
                    }
                }

                // Toggle full screen when the user clicks on the full screen button on anything such as an embeded video
                onFullScreenRequested : function (request) {
                    request.accept()
                    if (request.toggleOn)
                        window.showFullScreen()
                    else
                        window.showNormal()
                }

            }
        }

    }
}
