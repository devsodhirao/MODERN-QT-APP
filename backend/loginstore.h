#pragma once

#include <QObject>
#include <QDebug>
#include <QDateTime>
#include "qqmlregistration.h"

class LoginStore : public QObject {
    Q_OBJECT
    QML_ELEMENT

    // Role enums
    Q_PROPERTY(int roleLoggedOut READ roleLoggedOut CONSTANT)
    Q_PROPERTY(int roleUser READ roleUser CONSTANT)
    Q_PROPERTY(int roleAdmin READ roleAdmin CONSTANT)

    // State properties
    Q_PROPERTY(int userRole READ userRole WRITE setUserRole NOTIFY userRoleChanged)
    Q_PROPERTY(bool loginFailed READ loginFailed WRITE setLoginFailed NOTIFY loginFailedChanged)
    Q_PROPERTY(QString currentUsername READ currentUsername WRITE setCurrentUsername NOTIFY currentUsernameChanged)
    Q_PROPERTY(int failedAttempts READ failedAttempts WRITE setFailedAttempts NOTIFY failedAttemptsChanged)
    Q_PROPERTY(bool isLocked READ isLocked WRITE setIsLocked NOTIFY isLockedChanged)
    Q_PROPERTY(QDateTime lastLoginAttempt READ lastLoginAttempt WRITE setLastLoginAttempt NOTIFY lastLoginAttemptChanged)

    // Security settings
    Q_PROPERTY(int maxFailedAttempts READ maxFailedAttempts CONSTANT)
    Q_PROPERTY(int lockoutDurationMs READ lockoutDurationMs CONSTANT)
    Q_PROPERTY(int minPasswordLength READ minPasswordLength CONSTANT)

public:
    explicit LoginStore(QObject *parent = nullptr);

    // Role constants
    static constexpr int roleLoggedOut() { return -1; }
    static constexpr int roleUser() { return 0; }
    static constexpr int roleAdmin() { return 1; }

    // Security constants
    static constexpr int maxFailedAttempts() { return 3; }
    static constexpr int lockoutDurationMs() { return 60000; } // 1 minute
    static constexpr int minPasswordLength() { return 4; }

    // Role getters
    int userRole() const;
    bool loginFailed() const;
    QString currentUsername() const;
    int failedAttempts() const;
    bool isLocked() const;
    QDateTime lastLoginAttempt() const;

    // Role setters
    void setUserRole(int newRole);
    void setLoginFailed(bool failed);
    void setCurrentUsername(const QString &username);
    void setFailedAttempts(int attempts);
    void setIsLocked(bool locked);
    void setLastLoginAttempt(const QDateTime &timestamp);

    // Helper methods
    Q_INVOKABLE bool hasPermission(const QString &permission) const;
    Q_INVOKABLE QString getDisplayName() const;
    Q_INVOKABLE QString getRoleText() const;
    Q_INVOKABLE bool isLoggedIn() const;
    Q_INVOKABLE bool isAdmin() const;
    Q_INVOKABLE bool isRegularUser() const;

signals:
    void userRoleChanged();
    void loginFailedChanged();
    void currentUsernameChanged();
    void failedAttemptsChanged();
    void isLockedChanged();
    void lastLoginAttemptChanged();
    
    void loginSuccess(const QString &username, int role);
    void loginFailed(const QString &reason);
    void logoutSuccess();
    void accountLocked();

public slots:
    void login(const QString &username, const QString &password);
    void logout();

private:
    // State
    int m_userRole = roleLoggedOut();
    bool m_loginFailed = false;
    QString m_currentUsername;
    int m_failedAttempts = 0;
    bool m_isLocked = false;
    QDateTime m_lastLoginAttempt;

    // Helper methods
    bool isAccountLocked() const;
    QString validateCredentials(const QString &username, const QString &password) const;
    QStringList getUserPermissions(const QString &username) const;
};
