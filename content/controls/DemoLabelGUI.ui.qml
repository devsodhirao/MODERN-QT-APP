/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML.
*/

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ModernQtGUI 1.0
import Backend 1.0

Label {
    id: rootId

    // Public API
    property bool bold: false
    property bool italic: false
    property bool underline: false
    property int fontSize: Constants.fontSizeMedium
    property bool multiline: false
    property string labelText: ""
    
    // Bind text to labelText
    text: labelText

    // Default styling
    color: enabled ? Constants.colorsTextPrimary : Constants.colorsTextSecondary
    font {
        pixelSize: fontSize
        weight: bold ? Font.Bold : Font.Medium
        italic: rootId.italic
        underline: rootId.underline
    }
    
    // Text handling
    horizontalAlignment: Text.AlignLeft
    verticalAlignment: Text.AlignVCenter
    elide: multiline ? Text.ElideNone : Text.ElideRight
    wrapMode: multiline ? Text.WordWrap : Text.NoWrap
    
    // Visual feedback
    opacity: enabled ? 1.0 : 0.5
}
