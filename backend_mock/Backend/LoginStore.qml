import QtQuick

QtObject {
    id: loginStoreMockId

    // Role constants
    readonly property int roleLoggedOut: -1
    readonly property int roleUser: 0
    readonly property int roleAdmin: 1

    // State properties
    property int userRole: roleLoggedOut
    property bool loginFailed: false
    property string currentUsername: ""

    // Signals
    signal loginSuccess(string username, int role)
    signal loginFailed(string reason)
    signal logoutSuccess()

    function login(username, password) {
        if (username === "user" && password === "user") {
            loginStoreMockId.userRole = roleUser
            loginStoreMockId.loginFailed = false
            loginStoreMockId.currentUsername = username
            loginSuccess(username, roleUser)
            console.log("[Mock] User login successful")
            rootStoreMockId.addSystemMessage("User logged in successfully", "success")
        } else if (username === "admin" && password === "admin") {
            loginStoreMockId.userRole = roleAdmin
            loginStoreMockId.loginFailed = false
            loginStoreMockId.currentUsername = username
            loginSuccess(username, roleAdmin)
            console.log("[Mock] Admin login successful")
            rootStoreMockId.addSystemMessage("Administrator logged in successfully", "success")
        } else {
            loginStoreMockId.userRole = roleLoggedOut
            loginStoreMockId.loginFailed = true
            loginStoreMockId.currentUsername = ""
            loginFailed("Invalid username or password")
            console.log("[Mock] Login failed")
            rootStoreMockId.addSystemMessage("Login failed: Invalid credentials", "error")
        }
    }

    function logout() {
        console.log("[Mock] Logging out user:", currentUsername)
        rootStoreMockId.addSystemMessage(`User ${currentUsername} logged out`, "info")
        loginStoreMockId.userRole = roleLoggedOut
        loginStoreMockId.currentUsername = ""
        loginStoreMockId.loginFailed = false
        logoutSuccess()
    }

    function getRoleText() {
        switch(userRole) {
            case roleAdmin: return "Administrator"
            case roleUser: return "Regular User"
            default: return "Logged Out"
        }
    }

    function isLoggedIn() {
        return userRole !== roleLoggedOut
    }

    function isAdmin() {
        return userRole === roleAdmin
    }

    function isRegularUser() {
        return userRole === roleUser
    }

    // Debug helper
    onUserRoleChanged: {
        console.log("[Mock] Login status changed:", {
            role: userRole,
            roleText: getRoleText(),
            username: currentUsername
        })
    }
}
