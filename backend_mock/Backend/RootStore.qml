import QtQuick
//TODO: Load all the models for the actual backend using some sort of loop here or there.
// loading via direction js functions in the QML may be slower.
QtObject {
    id: rootStoreId

    readonly property LoginStore loginStore: LoginStore {
        id: loginStoreId
    }
}
