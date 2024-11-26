import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ModernQtGUI 1.0
import Backend 1.0
import content 1.0

HomeViewGUI {
    id: rootId

    width: Constants.appWidth * Constants.scale
    height: Constants.appHeight * Constants.scale

    property var rootStore

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
