/**
 * Custom button with rounded corners and gradient background.
 * Exposes background and mouse area for styling and interaction.
 */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ModernQtGUI 1.0
import Backend 1.0

Button {
    id: rootId

    // Public properties
    property alias buttonBackgroundAlias: buttonBackgroundId
    property alias mouseAreaAlias: mouseAreaId
    
    // Animation properties
    property real scaleValue: 1.0
    property real opacityValue: 1.0
    
    // Button configuration
    flat: true
    text: "My Button"

    // Sizing
    implicitWidth: Math.max(
                       buttonBackgroundId ? buttonBackgroundId.implicitWidth : 0,
                       contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(
                        buttonBackgroundId ? buttonBackgroundId.implicitHeight : 0,
                        contentItem.implicitHeight + topPadding + bottomPadding)
    leftPadding: 4
    rightPadding: 4

    // Visual style
    background: Rectangle {
        id: buttonBackgroundId
        implicitWidth: 100
        implicitHeight: 40
        opacity: opacityValue
        radius: 5

        // Colors
        color: Constants.colorsBackground
        border.color: Constants.colorsBackgroundHighlighted
        border.width: 1

        // Top gradient glow effect
        Rectangle {
            id: topGlow
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }
            height: parent.height * 0.5
            radius: parent.radius
            opacity: 0.4

            gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: Qt.lighter(Constants.colorsBackgroundHighlighted,
                                      1.3)
                }
                GradientStop {
                    position: 1.0
                    color: "transparent"
                }
            }
        }

        // Bottom gradient shadow effect
        Rectangle {
            id: bottomShadow
            anchors {
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }
            height: parent.height * 0.5
            radius: parent.radius
            opacity: 0.4

            gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: "transparent"
                }
                GradientStop {
                    position: 1.0
                    color: Qt.darker(Constants.colorsBackgroundHighlighted, 1.2)
                }
            }
        }
    }

    // Text styling
    contentItem: Text {
        text: rootId.text
        font: rootId.font
        opacity: enabled ? 1.0 : 0.3
        color: Constants.colorsTextPrimary
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.centerIn: parent
    }

    // States
    states: [
        State {
            name: "normal"
            when: !rootId.down
            PropertyChanges {
                target: buttonBackgroundId
                scale: 1
                color: Constants.colorsBackground
            }
        },
        State {
            name: "down"
            when: rootId.down
            PropertyChanges {
                target: buttonBackgroundId
                scale: 0.98
                color: Constants.colorsAccent2
                border.color: Constants.colorsAccent2
            }
        }
    ]

    // Transitions
    transitions: Transition {
        from: "*"
        to: "*"
        NumberAnimation {
            properties: "scale"
            duration: 100
            easing.type: Easing.OutQuad
        }
    }

    scale: scaleValue

    MouseArea {
        id: mouseAreaId
        anchors.fill: parent
        hoverEnabled: true
    }
}
