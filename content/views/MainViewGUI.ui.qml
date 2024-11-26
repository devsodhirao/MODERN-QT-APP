
/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick
import QtQuick.Controls
import ModernQtGUI 1.0
import Backend 1.0
import content 1.0

Rectangle {
    id: rootId
    color: Constants.colorsBackground

    property RootStore rootStore
    property alias contentLoader: contentLoaderId
    property alias contentContainer: contentContainerId

    VirtualKeyboardPanel {
        id: inputPanelId
    }

    KeyboardAwareContainer {
        id: keyboardAwareContainerId
        anchors.fill: parent
        inputPanel: inputPanelId

        Item {
            id: contentContainerId
            anchors.fill: parent
            anchors.margins: Constants.contentPadding

            Loader {
                id: contentLoaderId
                anchors.fill: parent
            }
        }
    }
}
