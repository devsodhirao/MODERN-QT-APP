/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/


/**
 * @file HomeViewGUI.ui.qml
 *
 * This file defines the UI for the home view of the application.
 * It includes components for managing users, displaying content, and handling login/logout functionality.
 * The main component is an Item that contains a Rectangle and a StackView.
 * The Rectangle is used as the background color of the view.
 * The StackView is used for managing the stack of UI pages with transition animations.
 * The default content is a placeholder component.
 *
 * @property {Component} profilePanelIdAlias - The alias for the profile panel component.
 * @property {number} loginLevel - The login level of the user.
 * @property {boolean} showLoginError - Indicates whether to show a login error.
 * @property {ListModel} usersModel - The model for managing users within the application.
 * @property {number} userCount - The count of users in the usersModel.
 * @property {string} currentContent - The currently displayed content in the view.
 *
 * @signal login(username, password) - Signal emitted when the user logs in.
 * @signal logout - Signal emitted when the user logs out.
 * @signal removeUser(index) - Signal emitted when a user is removed.
 * @signal requestToShowPopup - Signal emitted to request display of a popup UI element.
 *
 * @note The view transitions to different content based on the user's login level and actions.
 */
import QtQuick 6.5
import QtQuick.Controls 6.5
import "../panels/loginsetup"
import ModernQtGUI 1.0
import Backend 1.0

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
