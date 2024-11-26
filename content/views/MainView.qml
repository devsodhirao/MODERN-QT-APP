import QtQuick
import QtQuick.Effects

MainViewForm {
    id: root

    // Add shadow effect for depth
    layer.enabled: true
    layer.effect: DropShadow {
        transparentBorder: true
        horizontalOffset: 0
        verticalOffset: 1
        radius: 8.0
        samples: 17
        color: "#20000000"
    }

    // Center content within max width
    contentContainerId.mainViewId.anchors.leftMargin: Math.max(0, (contentContainerId.width - Constants.contentMaxWidth) / 2)
    contentContainerId.mainViewId.anchors.rightMargin: contentContainerId.mainViewId.anchors.leftMargin

    // Update scale when window size changes
    onWidthChanged: Constants.getScale(width, height)
    onHeightChanged: Constants.getScale(width, height)
}
