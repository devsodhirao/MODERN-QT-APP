import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import ModernQtGUI 1.0
import Backend 1.0
import content 1.0
import QtQuick.VirtualKeyboard

InputPanel {
    id: inputPanelId

    // Positioning
    x: 0
    width: Window.width
    y: Qt.inputMethod.visible ? Window.height - height : Window.height
    visible: Qt.inputMethod.visible

    states: [
        State {
            name: "visible"
            when: inputPanelId.visible
            PropertyChanges {
                target: inputPanelId
                y: Window.height - inputPanelId.height
            }
        }
    ]

    transitions: [
        Transition {
            id: inputPanelTransition
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    easing.type: Easing.InOutQuad
                    duration: 250
                }
            }
            to: "visible"
            from: ""
        }
    ]
    z: 99
}
