/**
 * Button implementation with hover, press, and disabled states.
 * Handles animations and visual feedback for user interactions.
 */

import QtQuick
import ModernQtGUI

DemoButtonGUI {
    id: control

    buttonBackgroundAlias.width: control.width - Constants.dp(10)
    buttonBackgroundAlias.height: control.height - Constants.dp(10)

    Behavior on scale { NumberAnimation { duration: 200 } }

    mouseAreaAlias {
        onEntered: {
            if (!control.down) {
                buttonBackgroundAlias.opacity = 0.8
            }
        }
        onExited: {
            if (!control.down) {
                buttonBackgroundAlias.opacity = enabled ? 1.0 : 0.3
            }
        }
        onPressed: {
            buttonBackgroundAlias.opacity = 0.6
            control.scale = 0.9
        }
        onReleased: {
            buttonBackgroundAlias.opacity = mouseAreaAlias.containsMouse ? 0.8 : (enabled ? 1.0 : 0.3)
            control.scale = 1.0
        }
        onClicked: control.clicked()
    }
}
