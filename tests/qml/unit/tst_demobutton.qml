import QtQuick
import QtTest
import QtQuick.Controls
import content 1.0

TestCase {
    id: testCase
    name: "DemoButtonTests"
    width: 400
    height: 400
    visible: true
    when: windowShown

    Component {
        id: buttonComponent
        DemoButtonImp {}
    }

    function test_initial_state() {
        let button = createTemporaryObject(buttonComponent, testCase)
        verify(button)
        compare(button.enabled, true)
        compare(button.text, "My Button")
        verify(button.buttonBackgroundAlias)
        verify(button.mouseAreaAlias)
    }

    function test_click_handling() {
        let button = createTemporaryObject(buttonComponent, testCase)
        verify(button)
        
        let clicked = false
        button.clicked.connect(() => { clicked = true })
        
        mouseClick(button)
        verify(clicked)
    }

    function test_disabled_state() {
        let button = createTemporaryObject(buttonComponent, testCase)
        verify(button)
        
        button.enabled = false
        verify(!button.enabled)
        
        let clicked = false
        button.clicked.connect(() => { clicked = true })
        
        mouseClick(button)
        verify(!clicked, "Disabled button should not emit clicked signal")
    }

    function test_hover_effects() {
        let button = createTemporaryObject(buttonComponent, testCase)
        verify(button)
        
        mouseMove(button)
        verify(button.mouseAreaAlias.containsMouse)
        
        mouseMove(button, -10, -10) // Move outside
        verify(!button.mouseAreaAlias.containsMouse)
    }

    function test_press_effects() {
        let button = createTemporaryObject(buttonComponent, testCase)
        verify(button)
        
        mousePress(button)
        verify(button.mouseAreaAlias.pressed)
        
        mouseRelease(button)
        verify(!button.mouseAreaAlias.pressed)
    }
}
