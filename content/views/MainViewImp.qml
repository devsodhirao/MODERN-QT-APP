import QtQuick
import QtQuick.Controls
import ModernQtGUI 1.0
import Backend 1.0
import "../controls"
import "../panels/loginsetup"

MainViewGUI {
    id: rootId

    Component.onCompleted: {
        if (rootStore && rootStore.loginStore && rootStore.loginStore.loginFailed) {
            rootStore.loginStore.loginFailed.connect(handleLoginFailure)
        }
        contentLoader.sourceComponent = loginPanelId
    }

    Component {
        id: loginPanelId
        LoginPanelImp {
            width: Constants.appContentWidth * Constants.scale
            height: Constants.appContentHeight * Constants.scale
            rootStore: rootId.rootStore
        }
    }

    Dialog {
        id: errorDialog
        anchors.centerIn: parent
        modal: true
        title: qsTr("Error")
        standardButtons: Dialog.Ok
        property alias text: messageText.text

        Text {
            id: messageText
            width: parent.width
            wrapMode: Text.WordWrap
            color: Constants.colorsTextPrimary
        }
    }

    function handleLoginFailure() {
        errorDialog.text = qsTr("Login failed. Please check your credentials.")
        errorDialog.open()
    }
}
