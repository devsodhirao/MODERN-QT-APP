import QtQuick
import QtTest
import Backend

TestCase {
    id: testCase
    name: "LoginStoreMockTests"
    
    LoginStore {
        id: loginStore
    }
    
    function test_login_success() {
        loginStore.login("user", "demo")
        verify(loginStore.isLoggedIn)
        compare(loginStore.currentUsername, "user")
        compare(loginStore.userRole, "user")
        verify(!loginStore.loginFailed)
        
        loginStore.logout()
        loginStore.login("admin", "admin")
        verify(loginStore.isLoggedIn)
        compare(loginStore.currentUsername, "admin")
        compare(loginStore.userRole, "admin")
        verify(!loginStore.loginFailed)
    }
    
    function test_login_failure() {
        loginStore.logout()
        loginStore.login("user", "wrongpass")
        verify(!loginStore.isLoggedIn)
        verify(loginStore.loginFailed)
        compare(loginStore.userRole, "logged_out")
    }
    
    function test_account_lockout() {
        loginStore.logout()
        
        // Attempt multiple failed logins
        for (var i = 0; i < loginStore.maxFailedAttempts; i++) {
            loginStore.login("user", "wrongpass")
        }
        
        verify(loginStore.isLocked)
        
        // Try valid login while locked
        loginStore.login("user", "demo")
        verify(!loginStore.isLoggedIn)
        verify(loginStore.isLocked)
    }
    
    function test_role_management() {
        loginStore.logout()
        
        // Test user permissions
        loginStore.login("user", "demo")
        verify(loginStore.hasPermission("view_basic"))
        verify(loginStore.hasPermission("edit_profile"))
        verify(!loginStore.hasPermission("manage_users"))
        
        // Test admin permissions
        loginStore.logout()
        loginStore.login("admin", "admin")
        verify(loginStore.hasPermission("view_basic"))
        verify(loginStore.hasPermission("manage_users"))
    }
}
