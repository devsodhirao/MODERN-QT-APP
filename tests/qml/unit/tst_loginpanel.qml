import QtQuick
import QtTest
import QtQuick.Controls
import content 1.0
import Backend 1.0

TestCase {
    id: testCase
    name: "LoginPanelTests"
    width: 600
    height: 800
    visible: true
    when: windowShown

    Component {
        id: loginPanelComponent
        LoginPanelImp {}
    }

    function test_initial_state() {
        let panel = createTemporaryObject(loginPanelComponent, testCase)
        verify(panel)
        verify(panel.formAlias)
        verify(panel.loginButton)
        verify(panel.usernameField)
        verify(panel.passwordField)
        
        compare(panel.loginLevel, -1)
        compare(panel.usernameField.text, "")
        compare(panel.passwordField.text, "")
        verify(!panel.loginButton.enabled)
    }

    function test_form_validation() {
        let panel = createTemporaryObject(loginPanelComponent, testCase)
        verify(panel)
        
        // Initially disabled
        verify(!panel.loginButton.enabled)
        
        // Only username
        panel.usernameField.text = "testuser"
        verify(!panel.loginButton.enabled)
        
        // Only password
        panel.usernameField.text = ""
        panel.passwordField.text = "password123"
        verify(!panel.loginButton.enabled)
        
        // Both fields filled
        panel.usernameField.text = "testuser"
        verify(panel.loginButton.enabled)
    }

    function test_login_attempt() {
        let panel = createTemporaryObject(loginPanelComponent, testCase)
        verify(panel)
        
        let loginAttempted = false
        panel.loginClicked.connect(() => { loginAttempted = true })
        
        // Fill form
        panel.usernameField.text = "testuser"
        panel.passwordField.text = "password123"
        
        // Click login
        mouseClick(panel.loginButton)
        verify(loginAttempted)
    }

    function test_keyboard_navigation() {
        let panel = createTemporaryObject(loginPanelComponent, testCase)
        verify(panel)
        
        // Focus username field
        panel.usernameField.forceActiveFocus()
        verify(panel.usernameField.activeFocus)
        
        // Tab to password
        keyClick(Qt.Key_Tab)
        verify(panel.passwordField.activeFocus)
        
        // Tab to login button
        keyClick(Qt.Key_Tab)
        verify(panel.loginButton.activeFocus)
    }

    function test_error_handling() {
        let panel = createTemporaryObject(loginPanelComponent, testCase)
        verify(panel)
        
        // Simulate failed login
        panel.usernameField.text = "testuser"
        panel.passwordField.text = "wrongpass"
        mouseClick(panel.loginButton)
        
        // Error message should be visible
        wait(100)
        verify(panel.formAlias.errorMessageVisible)
    }
}
