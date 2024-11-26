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
    width: Constants.appContentWidth
    height: Constants.appContentHeight

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
            id: formLayoutId
            anchors.centerIn: parent
            spacing: Constants.defaultMargin
            width: Math.min(parent.width * 0.8, Constants.contentMaxWidth)

            DemoLabel {
                id: usernameLabelId
                text: qsTr("Username")
                color: Constants.colorsTextPrimary
                Layout.fillWidth: true
            }

            TextField {
                id: usernameTextFieldId
                placeholderText: qsTr("Enter your username")
                Layout.fillWidth: true
                height: Constants.inputHeight
                color: Constants.colorsTextPrimary
                placeholderTextColor: Qt.rgba(Constants.colorsTextPrimary.r, 
                                            Constants.colorsTextPrimary.g, 
                                            Constants.colorsTextPrimary.b, 0.5)
                background: Rectangle {
                    color: Constants.colorsBackgroundHighlighted
                    radius: Constants.defaultRadius
                }
            }

            DemoLabel {
                id: passwordLabelId
                text: qsTr("Password")
                color: Constants.colorsTextPrimary
                Layout.fillWidth: true
                Layout.topMargin: Constants.smallMargin
            }

            TextField {
                id: passwordTextFieldId
                placeholderText: qsTr("Enter your password")
                echoMode: TextInput.Password
                Layout.fillWidth: true
                height: Constants.inputHeight
                color: Constants.colorsTextPrimary
                placeholderTextColor: Qt.rgba(Constants.colorsTextPrimary.r, 
                                            Constants.colorsTextPrimary.g, 
                                            Constants.colorsTextPrimary.b, 0.5)
                background: Rectangle {
                    color: Constants.colorsBackgroundHighlighted
                    radius: Constants.defaultRadius
                }
            }

            DemoButtonImp {
                id: loginButtonId
                text: qsTr("Login")
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: Math.min(200, parent.width * 0.5)
                Layout.topMargin: Constants.defaultMargin
                height: Constants.buttonHeight
                font.pixelSize: Constants.fontSizeLarge

                Connections {
                    target: loginButtonId
                    onClicked: {
                        if (usernameTextFieldId.text === ""
                                || passwordTextFieldId.text === "") {
                            rootId.showErrorMessage = true
                        } else {
                            rootId.loginClicked(usernameTextFieldId.text,
                                             passwordTextFieldId.text)
                        }
                    }
                }
            }

            Label {
                id: errorLabelId
                text: rootId.errorMessage
                color: "#FF4444"
                visible: rootId.showErrorMessage
                Layout.fillWidth: true
                Layout.topMargin: Constants.smallMargin
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.Wrap
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
