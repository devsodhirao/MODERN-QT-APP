/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML.
*/

/**
 * @file HomeViewGUI.ui.qml
 *
 * This file defines the UI for the home view of the application.
 * It includes components for managing users, displaying content, and handling login/logout functionality.
 */

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ModernQtGUI 1.0
import Backend 1.0

// Local imports
import "../controls"
import "../panels/loginsetup"

Item {
    id: rootId

    width: Constants.appContentWidth
    height: Constants.appContentHeight

    // this needs to be instantiated by the AppGUI->MainViewImp
    property RootStore rootStore

    Rectangle {
        anchors.fill: parent
        color: Constants.colorsBackground
        opacity: 1.0

        StackView {
            id: stackView
            anchors.fill: parent
            initialItem: Item { Text { text: "Welcome!" } } // Placeholder for initial content
        }
    }
}
