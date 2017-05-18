import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import "Stoary/Pages"
import "Stoary/Utils"

ApplicationWindow {
    id: window

    title: "Stoary"

    header: TabBar {
        id: tabs
        TabButton {
            text: "Main"
        }
    }

    StackLayout {
        currentIndex: tabs.currentIndex

        ProjectPage {}
    }

    footer: Column {
        Rectangle {
            height: 1
            width: parent.width
            color: "gray"
        }
        Row {
            id: row
            Label { text: "Meow" }
        }
    }
}
