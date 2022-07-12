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

import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import Qt.labs.settings 1.0
import QtWebEngine 1.8
import Ubuntu.Components 1.3


MainView {
    id : root
    objectName : 'mainView'
    applicationName : 'conversejs.luigi311'
    automaticOrientation : true
    backgroundColor : "transparent"

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

            }
        }
    }
}
