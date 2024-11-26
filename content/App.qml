/**
 * Main Application Window
 * 
 * Core application component that manages:
 * - Window sizing and responsiveness
 * - Root store initialization and dependency injection
 * - Application lifecycle and state management
 */

import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.VirtualKeyboard
import QtQuick.Layouts
import ModernQtGUI 1.0
import Backend 1.0
import content 1.0

// Local imports
import "views"
import "controls"

Window {
    id: rootId
    visible: true
    
    // Responsive window dimensions
    width: Math.min(Constants.appWidth, Screen.desktopAvailableWidth * 0.9)
    height: Math.min(Constants.appHeight, Screen.desktopAvailableHeight * 0.9)
    minimumWidth: Constants.appWidth * 0.6
    minimumHeight: Constants.appHeight * 0.6
    
    title: qsTr("Modern Qt Demo")

    // Dynamic scaling based on window size
    property real scaleFactor: Math.min(width / Constants.appWidth, height / Constants.appHeight)
    
    onScaleFactorChanged: {
        Constants.scale = scaleFactor
    }

    // Error boundary for catching unhandled errors
    Item {
        id: errorBoundaryId
        
        function handleError(error) {
            console.error("Application Error:", error)
            errorDialogId.errorMessage = error.toString()
            errorDialogId.visible = true
        }

        Dialog {
            id: errorDialogId
            anchors.centerIn: parent
            modal: true
            title: qsTr("Application Error")
            property string errorMessage: ""
            
            Text {
                id: errorMessageId
                text: errorDialogId.errorMessage
                wrapMode: Text.WordWrap
                width: parent.width * 0.8
            }
            
            standardButtons: Dialog.Ok
        }
    }

    // Main application content
    MainViewImp {
        id: appContentId
        anchors.fill: parent
        rootStore: RootStore {}
    }

    // Global error handler
    Connections {
        target: Qt.application
        function onAboutToQuit() {
            // Cleanup code here
        }
    }

    Component.onCompleted: {
        // Set up global error handler
        if (typeof window !== "undefined") {
            window.onerror = function(msg, url, lineNumber) {
                errorBoundaryId.handleError({
                    message: msg,
                    url: url,
                    line: lineNumber
                })
                return true
            }
        }
    }
}
