import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import Qt.labs.settings 1.0

import "../Pages"

ApplicationWindow {
    id: projectsWindow
    title: "Open a Project"

    header: TabBar {
        id: tabs
        TabButton {
            text: "Remote"
        }
        TabButton {
            text: "Local"
        }
    }

    StackLayout {
        anchors {
            fill: parent
            margins: 10
        }
        currentIndex: tabs.currentIndex
        RemoteProjectsPage {
            id: remotePage
        }

        RowLayout {
            GroupBox {
                title: "Recent"
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
            GroupBox {
                title: "Create"
                Layout.fillHeight: true
                Layout.fillWidth: true
            }


            Component.onCompleted: {

            }
        }
    }
}
