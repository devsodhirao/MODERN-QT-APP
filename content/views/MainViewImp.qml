import QtQuick
import QtQuick.Controls
import ModernQtGUI 1.0
import Backend 1.0
import "../controls"
import "../panels/loginsetup"

/**
 * Main View Implementation
 * 
 * Handles the main application view logic and state management.
 * Manages login state and user interface transitions.
 * 
 * Features:
 * - Login state management via RootStore
 * - View transitions and animations
 * - Error handling and user feedback
 * 
 * Note: The RootStore is instantiated at the App level and passed down
 * to ensure consistent state management across the application.
 */
MainViewGUI {
    id: rootId

    property var rootStore

    Component.onCompleted: {
        if (rootStore && rootStore.loginStore && rootStore.loginStore.loginFailed) {
            rootStore.loginStore.loginFailed.connect(handleLoginFailure)
        }
        contentLoader.sourceComponent = loginPanelId
    }
    
    // Login panel component
    Component {
        id: loginPanelId
        LoginPanelImp {
            width: Constants.appContentWidth * Constants.scale
            height: Constants.appContentHeight * Constants.scale
            rootStore: rootId.rootStore
        }
    }
    
    function handleLoginFailure() {
        errorDialogId.text = qsTr("Login failed. Please check your credentials.")
        errorDialogId.open()
    }

    // Error handling dialog
    Dialog {
        id: errorDialogId
        anchors.centerIn: parent
        modal: true
        title: qsTr("Error")
        standardButtons: Dialog.Ok
        property alias text: messageTextId.text

        Text {
            id: messageTextId
            width: parent.width
            wrapMode: Text.WordWrap
            color: Constants.colorsTextPrimary
        }
    }
}
