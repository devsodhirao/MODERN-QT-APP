#include <QtTest>
#include <QCoreApplication>
#include "loginstore.h"

class TestLoginStore : public QObject
{
    Q_OBJECT

private slots:
    void initTestCase();
    void cleanupTestCase();
    void testLoginSuccess();
    void testLoginFailure();
    void testAccountLockout();
    void testRoleManagement();

private:
    LoginStore* m_loginStore;
};

void TestLoginStore::initTestCase()
{
    m_loginStore = new LoginStore(this);
}

void TestLoginStore::cleanupTestCase()
{
    delete m_loginStore;
}

void TestLoginStore::testLoginSuccess()
{
    // Test regular user login
    m_loginStore->login("user", "demo");
    QCOMPARE(m_loginStore->userRole(), LoginStore::roleUser());
    QCOMPARE(m_loginStore->currentUsername(), QString("user"));
    QCOMPARE(m_loginStore->isLoggedIn(), true);
    QCOMPARE(m_loginStore->loginFailed(), false);

    // Test admin login
    m_loginStore->logout();
    m_loginStore->login("admin", "admin");
    QCOMPARE(m_loginStore->userRole(), LoginStore::roleAdmin());
    QCOMPARE(m_loginStore->currentUsername(), QString("admin"));
    QCOMPARE(m_loginStore->isLoggedIn(), true);
    QCOMPARE(m_loginStore->loginFailed(), false);
}

void TestLoginStore::testLoginFailure()
{
    m_loginStore->logout();
    m_loginStore->login("user", "wrongpass");
    QCOMPARE(m_loginStore->userRole(), LoginStore::roleLoggedOut());
    QCOMPARE(m_loginStore->loginFailed(), true);
    QCOMPARE(m_loginStore->isLoggedIn(), false);
}

void TestLoginStore::testAccountLockout()
{
    m_loginStore->logout();
    
    // Attempt multiple failed logins
    for(int i = 0; i < LoginStore::maxFailedAttempts(); ++i) {
        m_loginStore->login("user", "wrongpass");
    }
    
    QCOMPARE(m_loginStore->isLocked(), true);
    
    // Try valid login while locked
    m_loginStore->login("user", "demo");
    QCOMPARE(m_loginStore->isLoggedIn(), false);
    QCOMPARE(m_loginStore->isLocked(), true);
}

void TestLoginStore::testRoleManagement()
{
    m_loginStore->logout();
    
    // Test user permissions
    m_loginStore->login("user", "demo");
    QCOMPARE(m_loginStore->hasPermission("view_basic"), true);
    QCOMPARE(m_loginStore->hasPermission("edit_profile"), true);
    QCOMPARE(m_loginStore->hasPermission("manage_users"), false);
    
    // Test admin permissions
    m_loginStore->logout();
    m_loginStore->login("admin", "admin");
    QCOMPARE(m_loginStore->hasPermission("view_basic"), true);
    QCOMPARE(m_loginStore->hasPermission("manage_users"), true);
}

QTEST_MAIN(TestLoginStore)
#include "tst_loginstore.moc"
