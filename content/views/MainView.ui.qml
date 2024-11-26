/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/

/**
 * @file AppGUI.ui.qml
 *
 * This file defines the main GUI component of the application.
 * It imports necessary modules and contains the root item of the GUI.
 * The root item includes the MainViewImp which displays our modern login interface.
 * Virtual keyboard support is maintained for C++ compatibility.
 */
import QtQuick
import QtQuick.Controls
import ModernQtGUI 1.0
import Backend 1.0
import "../controls"

Rectangle {
    id: rootId
    width: Constants.appContentWidth
    height: Constants.appContentHeight
    color: Constants.colorsBackground

    property RootStore rootStore

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

            MainViewImp {
                id: mainViewId
                anchors.fill: parent
                rootStore: rootId.rootStore
                clip: true
            }
        }
    }
}
