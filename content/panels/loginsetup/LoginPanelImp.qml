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

    onLoginClicked: (username, password) => {
        console.log("Login attempt with:", username)
        if (rootStore) {
            // Here we would typically validate with rootStore
            // For demo, just show success via the error message
            showErrorMessage = false
            rootStore.setLoginLevel(1)  // Assuming 1 is a valid login level
        }
    }
}
