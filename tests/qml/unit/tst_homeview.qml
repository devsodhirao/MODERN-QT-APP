import QtQuick
import QtTest
import QtQuick.Controls
import content 1.0
import Backend 1.0

TestCase {
    id: testCase
    name: "HomeViewTests"
    width: 800
    height: 600
    visible: true
    when: windowShown

    Component {
        id: homeViewComponent
        HomeViewImp {
            rootStore: mockRootStore
        }
    }

    // Mock RootStore for testing
    property QtObject mockRootStore: QtObject {
        property bool isLoggedIn: false
        property string currentUser: ""
        
        function login(username, password) {
            isLoggedIn = true
            currentUser = username
            return true
        }
        
        function logout() {
            isLoggedIn = false
            currentUser = ""
        }
    }

    function test_initial_state() {
        let view = createTemporaryObject(homeViewComponent, testCase)
        verify(view)
        verify(view.rootStore)
        verify(!view.rootStore.isLoggedIn)
        compare(view.rootStore.currentUser, "")
    }

    function test_login_flow() {
        let view = createTemporaryObject(homeViewComponent, testCase)
        verify(view)
        
        // Initially not logged in
        verify(!view.rootStore.isLoggedIn)
        
        // Simulate successful login
        view.rootStore.login("testuser", "password123")
        verify(view.rootStore.isLoggedIn)
        compare(view.rootStore.currentUser, "testuser")
    }

    function test_logout_flow() {
        let view = createTemporaryObject(homeViewComponent, testCase)
        verify(view)
        
        // Start logged in
        view.rootStore.login("testuser", "password123")
        verify(view.rootStore.isLoggedIn)
        
        // Logout
        view.rootStore.logout()
        verify(!view.rootStore.isLoggedIn)
        compare(view.rootStore.currentUser, "")
    }

    function test_responsive_layout() {
        let view = createTemporaryObject(homeViewComponent, testCase)
        verify(view)
        
        // Test different sizes
        view.width = 1024
        view.height = 768
        wait(50)
        verify(view.width >= view.implicitWidth)
        
        view.width = 400
        view.height = 600
        wait(50)
        verify(view.width >= view.implicitWidth)
    }

    function test_keyboard_handling() {
        let view = createTemporaryObject(homeViewComponent, testCase)
        verify(view)
        
        // Test keyboard navigation
        keyClick(Qt.Key_Tab)
        wait(50)
        verify(view.activeFocusItem !== null)
        
        // Test keyboard shortcuts
        keyClick(Qt.Key_L, Qt.ControlModifier)
        wait(50)
        verify(!view.rootStore.isLoggedIn)
    }
}
