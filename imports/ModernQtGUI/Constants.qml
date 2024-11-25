pragma Singleton

import QtQuick 6.5
import QtQuick.Studio.Application
import QtQuick.Controls.Material

QtObject {
    id: rootId
    
    // App Dimensions
    readonly property int appWidth: 1920
    readonly property int appHeight: 1080
    readonly property int appContentWidth: 1920 * rootId.scale
    readonly property int appContentHeight: 1080 * rootId.scale
    
    // Scaling
    property real scale: 1
    
    // Modern Cool Theme Colors
    readonly property color colorsAccent1: "#4A90E2"  // Bright blue - primary accent
    readonly property color colorsAccent2: "#50E3C2"  // Turquoise - secondary accent
    readonly property color colorsBackground: "#1E2A3E"        // Deep navy - main background
    readonly property color colorsBackgroundHighlighted: "#2A3B55"  // Lighter navy - highlighted areas
    readonly property color colorsTextPrimary: "#FFFFFF"    // Pure white - primary text
    
    // Font Configuration
    property string relativeFontDirectory: "fonts"
    readonly property font font: Qt.font({
        "family": Qt.application.font.family,
        "pixelSize": Qt.application.font.pixelSize
    })
    
    property StudioApplication application: StudioApplication {
        fontPath: Qt.resolvedUrl("../../content/" + relativeFontDirectory)
    }
    
    // Utility Functions
    function getScale(width, height) {
        var scale = Math.min(width / rootId.appWidth, height / rootId.appHeight)
        rootId.scale = scale
    }
    
    function dp(pixelSize) {
        return pixelSize * rootId.scale
    }
}
