/*
 * Copyright (C) 2016 Stefano Verzegnassi
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License 3 as published by
 * the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see http://www.gnu.org/licenses/.
 */

// QML for supporting adding attachments

import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Content 1.3

Page {
    id: picker

    // Custom struct to hold an array of attachment to allow multiple attachments at once
    Item {
        id: itemFiles
        property variant files: []
    }

    property var activeTransfer

    property var url
    property var handler
    property var contentType

    signal cancel()
    signal imported(variant fileUrl)

    header: PageHeader {
        title: i18n.tr("Choose")
    }

    ContentPeerPicker {
        anchors { fill: parent; topMargin: picker.header.height }
        visible: parent.visible
        showTitle: false
        contentType: picker.contentType
        handler: picker.handler

        onPeerSelected: {
            peer.selectionType = ContentTransfer.Single
            picker.activeTransfer = peer.request()
            picker.activeTransfer.stateChanged.connect(function() {
                // If a file is selected then update the state to "Charged"
                if (picker.activeTransfer.state === ContentTransfer.InProgress) {
                    console.log("Transfer in progress")
                    if (url) picker.activeTransfer.state = ContentTransfer.Charged
                }
                // When the state is "Charged" then the file is ready to be imported
                if (picker.activeTransfer.state === ContentTransfer.Charged) {
                    console.log("Charged")
                    if (picker.activeTransfer.items.length > 0) {
                        console.log("Got items")
                        // Iterate over all the items and add them to the array called itemFiles
                        for (var i = 0; i < picker.activeTransfer.items.length; i++) {
                            itemFiles.files.push(picker.activeTransfer.items[i].url)
                            console.log(picker.activeTransfer.items[i].url)
                        }
                        // Actual import the files to the picker variable so it can be passed back to the main app
                        picker.imported(itemFiles.files)
                    }
                    // Mark the transfer as complete and close the picker so the user returns back to the main app
                    picker.activeTransfer = "Completed"
                    pageStack.pop()
                }
            })
        }

        onCancelPressed: {
            console.log("Cancelled")
            pageStack.pop()
        }
    }

    ContentTransferHint {
        id: transferHint
        anchors.fill: parent
        activeTransfer: picker.activeTransfer
    }
    Component {
        id: resultComponent
        ContentItem {}
    }
}
