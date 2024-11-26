import QtQuick

QtObject {
    id: rootId

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
            rootId.userRole = roleUser
            rootId.loginFailed = false
            rootId.currentUsername = username
            loginSuccess(username, roleUser)
            console.log("User login successful")
        } else if (username === "admin" && password === "admin") {
            rootId.userRole = roleAdmin
            rootId.loginFailed = false
            rootId.currentUsername = username
            loginSuccess(username, roleAdmin)
            console.log("Admin login successful")
        } else {
            rootId.userRole = roleLoggedOut
            rootId.loginFailed = true
            rootId.currentUsername = ""
            loginFailed("Invalid username or password")
            console.log("Login failed")
        }
    }

    function logout() {
        console.log("Logging out user:", currentUsername)
        rootId.userRole = roleLoggedOut
        rootId.currentUsername = ""
        rootId.loginFailed = false
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
        console.log("Login status changed:", {
            role: userRole,
            roleText: getRoleText(),
            username: currentUsername
        })
    }
}
