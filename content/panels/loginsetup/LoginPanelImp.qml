/*!
   \qmltype LoginPanelImp
   \inqmlmodule ModernQtGUI
   \brief Implementation of the login panel.

   It imports the ModernQtGUI module and the custom controls module.
 */
import QtQuick
import ModernQtGUI 1.0
import Backend 1.0
import "../../controls"

LoginPanelGUI {
    id: rootId
    width: Constants.appContentWidth
    height: Constants.appContentHeight

    property RootStore rootStore
    loginLevel: rootStore && rootStore.loginStore ? rootStore.loginStore.userRole : -1

    onLoginClicked: (username, password) => {
        console.log("Login attempt with:", username)
        if (rootStore && rootStore.loginStore) {
            rootStore.loginStore.login(username, password)
        }
    }

    Connections {
        target: rootStore ? rootStore.loginStore : null
        function onLoginSuccess(username, role) {
            showErrorMessage = false
            loginLevel = role
        }
        function onLoginFailed(reason) {
            showErrorMessage = true
        }
    }
}
