/*!
   \qmltype DemoLabel
   \inqmlmodule ModernQtGUI
   \brief A custom styled label component.

   It extends the base Label control with ModernQtGUI styling constants.
 */

import QtQuick
import QtQuick.Controls
import ModernQtGUI

Label {
    id: control
    color: Constants.colorsTextPrimary
    font.pixelSize: Constants.dp(16)
    font.weight: Font.Medium
}
