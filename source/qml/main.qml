import QtQuick 2.0
import QtQuick.Controls 2.1

import "Stoary/Windows"

QtObject {
    id: root

    property list<Component> windows

    property Component startupWindowComponent: ProjectsWindow {
        visible: true
        width: 800
        height: 600
    }

    property Component mainWindowComponent: Component {
        MainWindow {
            visible: true
            width: 600
            height: 400
        }
    }

    Component.onCompleted: {
        console.log("Creating initial window");
        startupWindowComponent.createObject(this);
    }
}
