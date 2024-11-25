import QtQuick 2.15

Item {

    QtObject {
        id: rootId

        readonly property SettingsStore settingsStore: SettingsStore {
            id: settingsStore
        }
        readonly property LoginStore loginStore: LoginStore {
            id: loginStore
        }

        property bool popupIsShown: false

        function showPopup() {
            rootId.popupIsShown = true;
        }

        function hidePopup() {
            rootId.popupIsShown = false;
        }
    }

}
