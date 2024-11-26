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

    buttonBackgroundAlias.width: control.width - Constants.smallMargin * 2
    buttonBackgroundAlias.height: control.height - Constants.smallMargin * 2

    Behavior on scale { NumberAnimation { duration: 200 } }

    mouseAreaAlias {
        onEntered: buttonBackgroundAlias.opacity = 0.8
        onExited: buttonBackgroundAlias.opacity = 1.0
        onPressed: {
            buttonBackgroundAlias.opacity = 0.6
            control.scale = 0.98
        }
        onReleased: {
            buttonBackgroundAlias.opacity = mouseAreaAlias.containsMouse ? 0.8 : 1.0
            control.scale = 1.0
        }
    }
}
