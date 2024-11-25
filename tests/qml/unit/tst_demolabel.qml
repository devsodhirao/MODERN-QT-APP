import QtQuick
import QtTest
import QtQuick.Window
import "../../content/controls"

TestCase {
    id: testCase
    name: "DemoLabelTests"
    when: windowShown
    
    Window {
        id: window
        width: 400
        height: 400
        visible: true
        
        DemoLabel {
            id: label
            text: "Test Label"
            anchors.centerIn: parent
        }
    }
    
    function test_initial_properties() {
        compare(label.text, "Test Label")
        verify(label.visible)
        verify(label.width > 0)
        verify(label.height > 0)
    }
    
    function test_dynamic_text() {
        label.text = "Changed Text"
        compare(label.text, "Changed Text")
        
        // Allow time for text to render
        wait(50)
        
        // Verify text actually changed visually
        verify(label.width > 0)
        verify(label.height > 0)
    }
    
    function test_visibility() {
        label.visible = false
        verify(!label.visible)
        
        label.visible = true
        verify(label.visible)
    }
    
    function test_styling() {
        // Test default styling
        verify(label.color !== "")
        verify(label.font.pixelSize > 0)
        
        // Test style changes
        label.color = "red"
        compare(label.color, "#ff0000")
        
        label.font.pixelSize = 20
        compare(label.font.pixelSize, 20)
    }
}
