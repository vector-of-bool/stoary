import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import Qt.labs.settings 1.0

import "../Utils"

StackLayout {
    id: remotePage
    Settings {
        category: "remote"
        property alias username: usernameField.text
        property alias password: passwordField.text
    }
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20
        
        Label {
            Layout.alignment: Qt.AlignCenter
            font.pointSize: 14
            text: "To access remote documents, you must sign in"
        }
        
        Row {
            Layout.alignment: Qt.AlignCenter
            TextField {
                id: usernameField
                placeholderText: "Username"
                onTextChanged: signInTimer.restart()
            }
            TextField {
                id: passwordField
                placeholderText: "Password"
                echoMode: TextInput.Password
                onTextChanged: signInTimer.restart()
            }
        }
    }

    HTTPRequest {
        id: signInRequest
        url: "http://localhost:8080"
    }

    Timer {
        id: signInTimer
        interval: 700
        onTriggered: {
            if (!passwordField.text || !usernameField.text) {
                console.log("Not signing in yet: field data missing");
                return;
            }
            signInRequest.send();
        }
    }
}
