/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/

/**
 * Login panel with username/password form and error handling.
 * Emits loginClicked signal when user attempts to log in.
 * Shows error message if login validation fails.
 */

import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 6.5
import ModernQtGUI 1.0
import "../../controls"
import "../"

Item {
    id: rootId
    width: Constants.appContentWidth // Placeholder width for design
    height: Constants.appContentHeight // Placeholder height for design

    property int loginLevel: -1
    property alias formAlias: loginFormContainerId
    property alias loginButton: loginButtonId
    property alias usernameField: usernameTextFieldId
    property alias passwordField: passwordTextFieldId

    property bool showErrorMessage: false
    readonly property string errorMessage: "Please make sure that you entered the correct username and password"

    signal loginClicked(string username, string password)

    Item {
        id: loginFormContainerId
        anchors.fill: parent

        Rectangle {
            id: backgroundRectId
            anchors.fill: parent
            color: Constants.colorsBackground
        }

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 20

            DemoLabel {
                id: usernameLabelId
                text: qsTr("Username")
            }

            TextField {
                id: usernameTextFieldId
                placeholderText: qsTr("Username")
                Layout.preferredWidth: 450
            }

            DemoLabel {
                id: passwordLabelId
                text: qsTr("Password")
            }

            TextField {
                id: passwordTextFieldId
                placeholderText: qsTr("Password")
                echoMode: TextInput.Password
                Layout.preferredWidth: 450
            }

            DemoButtonImp {
                id: loginButtonId
                text: qsTr("Login")
                Layout.preferredWidth: 200
                font.pixelSize: 20

                Connections {
                    target: loginButtonId
                    onClicked: {
                        if (usernameTextFieldId.text === ""
                                || passwordTextFieldId.text === "") {
                            rootId.showErrorMessage
                        } else {
                            rootId.loginClicked(usernameTextFieldId.text,
                                             passwordTextFieldId.text)
                        }
                    }
                }
            }
        }
    }

    states: [
        State {
            name: "start"
            PropertyChanges {
                target: loginFormContainerId
                opacity: 1.0
            }
        }
    ]
}
