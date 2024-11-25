#include "loginstore.h"
#include <QHash>
#include <QtMath>

LoginStore::LoginStore(QObject *parent) : QObject(parent) {
    m_lastLoginAttempt = QDateTime::currentDateTime();
    qDebug() << "LoginStore initialized";
}

// Getters
int LoginStore::userRole() const { return m_userRole; }
bool LoginStore::loginFailed() const { return m_loginFailed; }
QString LoginStore::currentUsername() const { return m_currentUsername; }
int LoginStore::failedAttempts() const { return m_failedAttempts; }
bool LoginStore::isLocked() const { return m_isLocked; }
QDateTime LoginStore::lastLoginAttempt() const { return m_lastLoginAttempt; }

// Setters with change notification
void LoginStore::setUserRole(int newRole) {
    if (m_userRole == newRole) return;
    m_userRole = newRole;
    emit userRoleChanged();
    qDebug() << "User role changed to:" << getRoleText();
}

void LoginStore::setLoginFailed(bool failed) {
    if (m_loginFailed == failed) return;
    m_loginFailed = failed;
    emit loginFailedChanged();
}

void LoginStore::setCurrentUsername(const QString &username) {
    if (m_currentUsername == username) return;
    m_currentUsername = username;
    emit currentUsernameChanged();
}

void LoginStore::setFailedAttempts(int attempts) {
    if (m_failedAttempts == attempts) return;
    m_failedAttempts = attempts;
    emit failedAttemptsChanged();
    qDebug() << "Failed attempts updated:" << attempts;
}

void LoginStore::setIsLocked(bool locked) {
    if (m_isLocked == locked) return;
    m_isLocked = locked;
    emit isLockedChanged();
    if (locked) {
        qDebug() << "Account locked for" << lockoutDurationMs()/1000 << "seconds";
    }
}

void LoginStore::setLastLoginAttempt(const QDateTime &timestamp) {
    if (m_lastLoginAttempt == timestamp) return;
    m_lastLoginAttempt = timestamp;
    emit lastLoginAttemptChanged();
}

// Helper methods
bool LoginStore::isAccountLocked() const {
    if (!m_isLocked) return false;
    
    const qint64 timeSinceLock = m_lastLoginAttempt.msecsTo(QDateTime::currentDateTime());
    if (timeSinceLock >= lockoutDurationMs()) {
        // Use const_cast only for this mutable operation
        auto* mutableThis = const_cast<LoginStore*>(this);
        mutableThis->setIsLocked(false);
        mutableThis->setFailedAttempts(0);
        qDebug() << "Account lockout expired";
        return false;
    }
    return true;
}

QString LoginStore::validateCredentials(const QString &username, const QString &password) const {
    if (username.isEmpty() || password.isEmpty()) {
        return QStringLiteral("Username and password are required");
    }
    if (password.length() < minPasswordLength()) {
        return QStringLiteral("Password must be at least %1 characters").arg(minPasswordLength());
    }
    return QString();
}

QStringList LoginStore::getUserPermissions(const QString &username) const {
    static const QHash<QString, QStringList> permissions{
        {"user", {"view_basic", "edit_profile"}},
        {"admin", {"view_basic", "edit_profile", "manage_users", "view_admin", "edit_settings"}}
    };
    return permissions.value(username);
}

bool LoginStore::hasPermission(const QString &permission) const {
    if (!isLoggedIn()) {
        qDebug() << "Permission check failed: User not logged in";
        return false;
    }
    const bool hasPermission = getUserPermissions(m_currentUsername).contains(permission);
    qDebug() << "Permission check:" << permission << "Result:" << hasPermission;
    return hasPermission;
}

QString LoginStore::getDisplayName() const {
    static const QHash<QString, QString> displayNames{
        {"user", QStringLiteral("Demo User")},
        {"admin", QStringLiteral("Administrator")}
    };
    return displayNames.value(m_currentUsername, m_currentUsername);
}

QString LoginStore::getRoleText() const {
    switch(m_userRole) {
        case roleAdmin(): return QStringLiteral("Administrator");
        case roleUser(): return QStringLiteral("Regular User");
        default: return QStringLiteral("Logged Out");
    }
}

bool LoginStore::isLoggedIn() const {
    return m_userRole != roleLoggedOut();
}

bool LoginStore::isAdmin() const {
    return m_userRole == roleAdmin();
}

bool LoginStore::isRegularUser() const {
    return m_userRole == roleUser();
}

// Core functionality
void LoginStore::login(const QString &username, const QString &password) {
    qDebug() << "Login attempt for user:" << username;

    // Check for account lockout
    if (isAccountLocked()) {
        const qint64 remainingLockMs = lockoutDurationMs() - 
            m_lastLoginAttempt.msecsTo(QDateTime::currentDateTime());
        const int remainingMins = qCeil(remainingLockMs / 60000.0);
        const QString errorMsg = QStringLiteral("Account is locked. Try again in %1 minutes").arg(remainingMins);
        qDebug() << "Login blocked:" << errorMsg;
        emit loginFailed(errorMsg);
        return;
    }

    // Validate input
    const QString validationError = validateCredentials(username, password);
    if (!validationError.isEmpty()) {
        qDebug() << "Validation failed:" << validationError;
        emit loginFailed(validationError);
        return;
    }

    // Update login attempt tracking
    setLastLoginAttempt(QDateTime::currentDateTime());

    // Check credentials (in production, use secure password hashing)
    static const QHash<QString, QPair<QString, int>> validCredentials{
        {"user", {QStringLiteral("demo"), roleUser()}},
        {"admin", {QStringLiteral("admin"), roleAdmin()}}
    };

    const auto userInfo = validCredentials.value(username);
    if (!userInfo.first.isEmpty() && userInfo.first == password) {
        // Success - reset security counters
        setUserRole(userInfo.second);
        setLoginFailed(false);
        setCurrentUsername(username);
        setFailedAttempts(0);
        setIsLocked(false);
        
        qDebug() << "Login successful:" << username << "Role:" << getRoleText();
        emit loginSuccess(username, userInfo.second);
        return;
    }

    // Failed login attempt
    setLoginFailed(true);
    setUserRole(roleLoggedOut());
    setCurrentUsername(QString());
    setFailedAttempts(m_failedAttempts + 1);

    // Check for lockout
    if (m_failedAttempts >= maxFailedAttempts()) {
        setIsLocked(true);
        emit accountLocked();
        const QString errorMsg = QStringLiteral("Account locked due to too many failed attempts");
        qDebug() << "Account locked:" << errorMsg;
        emit loginFailed(errorMsg);
    } else {
        const QString errorMsg = QStringLiteral("Invalid username or password");
        qDebug() << "Login failed:" << errorMsg;
        emit loginFailed(errorMsg);
    }
}

void LoginStore::logout() {
    if (!isLoggedIn()) {
        qDebug() << "Logout ignored: No user logged in";
        return;
    }

    qDebug() << "Logging out user:" << m_currentUsername;
    setUserRole(roleLoggedOut());
    setCurrentUsername(QString());
    setLoginFailed(false);
    emit logoutSuccess();
}
