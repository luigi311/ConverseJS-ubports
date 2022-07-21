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


MainView {
    id : mainView
    objectName : 'mainView'
    applicationName : 'conversejs.luigi311'
    automaticOrientation : true
    backgroundColor : "transparent"
    width: units.gu(75)
    height: units.gu(65)
    clip: false
    
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

    Settings {
        id: appSettings
        property string systemTheme: 'SuruDark'
        property string pushToken: ''
        property string pushAppId: 'conversejs.luigi311_conversejs'
        property bool windowActive: true
    }

    Component.onCompleted: function () {
        theme.name = ""
        appSettings.systemTheme = theme.name.substring(theme.name.lastIndexOf(".")+1)
    }
    onActiveChanged: () => {appSettings.windowActive = mainView.active}

    function setCurrentTheme(themeName) {
        if (themeName === "System") {
            theme.name = "";
        }
        else if (themeName === "SuruDark") {
            theme.name = "Ubuntu.Components.Themes.SuruDark"
        }
        else if (themeName === "Ambiance") {
            theme.name = "Ubuntu.Components.Themes.Ambiance"
        }
        else {
            theme.name = "";
        }
    }

    PageStack {
        id : mainPageStack
        anchors.fill : parent
        Component.onCompleted : mainPageStack.push(mainPage)
        Page {
            id : mainPage
            anchors.fill : parent
            WebEngineView {
                id : webView
                anchors.fill : parent
                focus : true
                url : "http://localhost:19500/"
                settings.pluginsEnabled : true
                settings.javascriptEnabled : true
                settings.showScrollBars : false

                profile : WebEngineProfile {
                    id : webContext
                    storageName : "Storage"
                    httpUserAgent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Safari/537.36"
                    // remove file:/// from the beginning of the StandardPaths.standardLocations(StandardPaths::AppDataLocation)[0]
                    persistentStoragePath : StandardPaths.standardLocations(StandardPaths.AppDataLocation)[0].substring(7) + "/QtWebEngine"
                }
                
                onFileDialogRequested: function(request) {
                    request.accepted = true;
                    var importPage = mainPageStack.push(Qt.resolvedUrl("ImportPage.qml"),{"contentType": ContentType.All, "handler": ContentHandler.Source})
                    importPage.imported.connect(function(fileUrl) {
                        console.log("files: " + fileUrl)
                        request.dialogAccept(fileUrl);
                    })
                }

                onNewViewRequested: {
                    request.action = WebEngineNavigationRequest.IgnoreRequest
                    if(request.userInitiated) {
                        Qt.openUrlExternally(request. requestedUrl)
                    }
                }

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
