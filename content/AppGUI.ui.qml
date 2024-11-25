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
import QtQuick.VirtualKeyboard
import "views"
import ModernQtGUI 1.0
import Backend 1.0

Item {
    id: rootContainerId
    width: Constants.appWidth * Constants.scale
    height: Constants.appHeight * Constants.scale
    anchors.centerIn: parent

    property RootStore rootStore

    MainViewImp {
        id: mainViewId
        anchors.fill: parent
        rootStore: rootContainerId.rootStore
        clip: true
    }

    InputPanel {
        id: inputPanelId
        z: 99
        y: Qt.inputMethod.visible ? parent.height - height : parent.height
        visible: Qt.inputMethod.visible
        anchors.left: parent.left
        anchors.right: parent.right

        states: State {
            name: "visible"
            when: inputPanelId.visible
            PropertyChanges {
                target: inputPanelId
                y: parent.height - inputPanelId.height
            }
        }

        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
}
