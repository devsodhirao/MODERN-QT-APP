pragma Singleton

import QtQuick 6.5
import QtQuick.Studio.Application
import QtQuick.Controls.Material

QtObject {
    id: rootId
    
    // App Dimensions - More mobile-friendly
    readonly property int appWidth: 420
    readonly property int appHeight: 720
    readonly property int appContentWidth: appWidth * rootId.scale
    readonly property int appContentHeight: appHeight * rootId.scale
    
    // Content Layout
    readonly property real contentMaxWidth: 380
    readonly property real contentPadding: 20
    
    // Scaling
    property real scale: 1
    
    // Modern Cool Theme Colors
    readonly property color colorsAccent1: "#4A90E2"  // Bright blue - primary accent
    readonly property color colorsAccent2: "#50E3C2"  // Turquoise - secondary accent
    readonly property color colorsBackground: "#1E2A3E"        // Deep navy - main background
    readonly property color colorsBackgroundHighlighted: "#2A3B55"  // Lighter navy - highlighted areas
    readonly property color colorsTextPrimary: "#FFFFFF"    // Pure white - primary text
    readonly property color colorsTextSecondary: "#B8C5D9"  // Light gray - secondary text
    readonly property color colorsError: "#FF4444"          // Bright red - error states
    readonly property color colorsSuccess: "#4CAF50"        // Green - success states
    readonly property color colorsWarning: "#FFC107"        // Amber - warning states
    
    // Dimensions
    readonly property real defaultMargin: 16 * scale
    readonly property real smallMargin: 8 * scale
    readonly property real largeMargin: 24 * scale
    readonly property real defaultRadius: 8 * scale
    readonly property real buttonHeight: 48 * scale
    readonly property real inputHeight: 48 * scale
    readonly property real iconSize: 24 * scale

    // Font Sizes
    readonly property real fontSizeSmall: 12 * scale
    readonly property real fontSizeNormal: 14 * scale
    readonly property real fontSizeMedium: 16 * scale
    readonly property real fontSizeLarge: 18 * scale
    readonly property real fontSizeTitle: 24 * scale
    readonly property real fontSizeHeader: 32 * scale
    
    // Font Configuration
    property string relativeFontDirectory: "fonts"
    readonly property font font: Qt.font({
        "family": Qt.application.font.family,
        "pixelSize": fontSizeNormal
    })
    
    property StudioApplication application: StudioApplication {
        fontPath: Qt.resolvedUrl("../../content/" + relativeFontDirectory)
    }
    
    // Utility Functions
    function getScale(width, height) {
        var newScale = Math.min(width / appWidth, height / appHeight)
        rootId.scale = newScale
        return newScale
    }

    // Density-independent pixel function
    function dp(value) {
        return Math.round(value * rootId.scale)
    }
}
