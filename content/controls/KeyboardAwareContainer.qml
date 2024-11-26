import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ModernQtGUI 1.0
import Backend 1.0
import content 1.0

Item {
    id: root
    
    // Forward the default property to contentItem to allow setting children directly
    default property alias content: contentItem.data
    
    // Expose the content item for explicit positioning if needed
    property alias contentItem: contentItem
    
    // Reference to the input panel to calculate adjustments
    property Item inputPanel
    
    // The actual content container that will be adjusted
    Item {
        id: contentItem
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        
        // Adjust the bottom margin when keyboard is visible
        anchors.bottomMargin: inputPanel && inputPanel.visible ? inputPanel.height : 0
        
        // Smooth animation for height changes
        Behavior on anchors.bottomMargin {
            NumberAnimation {
                duration: 250
                easing.type: Easing.InOutQuad
            }
        }
    }
}
