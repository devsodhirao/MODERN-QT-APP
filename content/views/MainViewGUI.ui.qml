/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/

import QtQuick
import QtQuick.Controls
import "../controls"
import ModernQtGUI 1.0

/**
 * Main view UI component that provides the visual structure.
 * Contains a dynamic loader for content switching and a gradient background.
 * Pure UI file - all logic is handled in MainViewImp.qml
 */
Item {
    id: rootId
    
    // View dimensions
    width: Constants.appWidth * Constants.scale
    height: Constants.appHeight * Constants.scale
    
    property int keyboardOffset: 240
    property alias contentLoader: rootLoaderId  // Expose loader to implementation

    // Modern gradient background
    Rectangle {
        id: backgroundId
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { 
                position: 0.0
                color: Constants.colorsBackground 
            }
            GradientStop { 
                position: 1.0
                color: Qt.darker(Constants.colorsBackground, 1.2) 
            }
        }
    }

    // Dynamic content loader - implementation will set the source component
    Loader {
        id: rootLoaderId
        anchors.centerIn: parent
        anchors.verticalCenterOffset: Qt.inputMethod.visible ? -rootId.keyboardOffset : 0
        opacity: 1

        Behavior on anchors.verticalCenterOffset {
            NumberAnimation { 
                duration: 200
                easing.type: Easing.OutQuad 
            }
        }
    }
}
