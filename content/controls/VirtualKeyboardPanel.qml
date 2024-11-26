import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ModernQtGUI 1.0
import Backend 1.0
import content 1.0
import QtQuick.VirtualKeyboard

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
        id: inputPanelTransition
        from: ""
        to: "visible"
        reversible: true
        ParallelAnimation {
            NumberAnimation {
                properties: "y"
                duration: 250
                easing.type: Easing.InOutQuad
            }
        }
    }
}
