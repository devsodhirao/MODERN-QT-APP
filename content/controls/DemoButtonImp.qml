/**
 * Button implementation with hover, press, and disabled states.
 * Handles animations and visual feedback for user interactions.
 */

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ModernQtGUI 1.0
import Backend 1.0
import content 1.0

DemoButtonGUI {
    id: control

    // Handle hover effect
    HoverHandler {
        id: hoverHandler
        onHoveredChanged: control.opacityValue = hovered ? 0.8 : 1.0
    }

    mouseAreaAlias {
        onPressed: {
            control.opacityValue = 0.6
            control.scaleValue = 0.98
        }
        onReleased: {
            control.opacityValue = hoverHandler.hovered ? 0.8 : 1.0
            control.scaleValue = 1.0
        }
        onClicked: control.clicked()
    }

    transitions: [
        Transition {
            from: "*"; to: "*"
            NumberAnimation {
                properties: "scaleValue,opacityValue"
                duration: 200
                easing.type: Easing.OutQuad
            }
        }
    ]
}
