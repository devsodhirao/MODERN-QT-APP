/*!
   \qmltype DemoLabelImp
   \inqmlmodule content.controls
   \brief Implementation of the DemoLabel component.
   
   Adds interactive behavior and animations to the base DemoLabelGUI component.
 */

import QtQuick
import ModernQtGUI 1.0

DemoLabelGUI {
    id: control

    // Animation handling
    Behavior on opacity {
        NumberAnimation { 
            duration: 150
            easing.type: Easing.InOutQuad
        }
    }

    // Scale animation for enabled state changes
    scale: enabled ? 1.0 : 0.95
    Behavior on scale {
        NumberAnimation { 
            duration: 150
            easing.type: Easing.InOutQuad
        }
    }

    // Hover handling
    HoverHandler {
        id: hoverHandler
        onHoveredChanged: {
            if (control.enabled) {
                control.opacity = hovered ? 0.8 : 1.0
            }
        }
    }
}
