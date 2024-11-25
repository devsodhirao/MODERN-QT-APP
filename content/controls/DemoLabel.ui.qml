/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/

import QtQuick
import QtQuick.Controls
import ModernQtGUI 1.0

/**
 * Custom label component with consistent styling.
 * Pure UI component - all logic should be in DemoLabel.qml
 */
Text {
    id: rootId
    color: Constants.colorsTextPrimary
    font.pixelSize: Constants.fontSizeM * Constants.scale
    font.family: Constants.fontFamily
    horizontalAlignment: Text.AlignLeft
    verticalAlignment: Text.AlignVCenter
    elide: Text.ElideRight
    
    property int padding: Constants.paddingM
    property bool bold: false
    
    font.bold: bold
}
