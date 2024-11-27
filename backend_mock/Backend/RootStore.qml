import QtQuick
//TODO: Load all the models for the actual backend using some sort of loop here or there.
// loading via direction js functions in the QML may be slower.
QtObject {
    id: rootStoreMockId

    readonly property LoginStore loginStore: LoginStore {
        id: loginStoreId
    }

    readonly property var messages: QtObject {
        id: messagesId
        
        property var messageQueue: []
        signal newMessage(string message, string type)
        
        function addMessage(message, type = "info") {
            console.log("[Mock Message]:", message, "Type:", type)
            messageQueue.push({ text: message, type: type, timestamp: new Date() })
            newMessage(message, type)
            // Keep only last 100 messages
            if (messageQueue.length > 100) {
                messageQueue.shift()
            }
        }
        
        function clearMessages() {
            messageQueue = []
        }
    }

    // Helper function to easily add messages from anywhere
    function addSystemMessage(message, type = "info") {
        messages.addMessage("[Mock] " + message, type)
    }
}
