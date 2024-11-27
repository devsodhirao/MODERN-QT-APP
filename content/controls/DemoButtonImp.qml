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

    Behavior on scale { NumberAnimation { duration: 200 } }

    // Handle hover effect
    HoverHandler {
        onHoveredChanged: {
            buttonBackgroundAlias.opacity = hovered ? 0.8 : 1.0
        }
    }

    mouseAreaAlias {
        onPressed: {
            buttonBackgroundAlias.opacity = 0.6
            control.scale = 0.98
        }
        onReleased: {
            buttonBackgroundAlias.opacity = 1.0
            control.scale = 1.0
        }
        onClicked: control.clicked()  // Forward the click to the Button
    }
}
