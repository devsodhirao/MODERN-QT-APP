#include <QtTest>
#include <QCoreApplication>
#include "rootstore.h"
#include "loginstore.h"

class TestRootStoreIntegration : public QObject
{
    Q_OBJECT

private slots:
    void initTestCase();
    void cleanupTestCase();
    void testLoginStateManagement();
    void testStoreInteractions();
    void testRoleBasedAccess();

private:
    RootStore* m_rootStore;
};

void TestRootStoreIntegration::initTestCase()
{
    m_rootStore = new RootStore(this);
}

void TestRootStoreIntegration::cleanupTestCase()
{
    delete m_rootStore;
}

void TestRootStoreIntegration::testLoginStateManagement()
{
    // Test login state propagation
    auto loginStore = m_rootStore->loginStore();
    QVERIFY(loginStore != nullptr);
    
    loginStore->login("user", "demo");
    QCOMPARE(loginStore->isLoggedIn(), true);
    QCOMPARE(m_rootStore->isUserLoggedIn(), true);
    QCOMPARE(m_rootStore->currentUsername(), QString("user"));
    
    loginStore->logout();
    QCOMPARE(loginStore->isLoggedIn(), false);
    QCOMPARE(m_rootStore->isUserLoggedIn(), false);
    QCOMPARE(m_rootStore->currentUsername(), QString());
}

void TestRootStoreIntegration::testStoreInteractions()
{
    auto loginStore = m_rootStore->loginStore();
    
    // Test store state synchronization
    loginStore->login("admin", "admin");
    QCOMPARE(m_rootStore->currentUserRole(), LoginStore::roleAdmin());
    QVERIFY(m_rootStore->hasAdminAccess());
    
    // Test store reset
    m_rootStore->resetStores();
    QCOMPARE(loginStore->isLoggedIn(), false);
    QCOMPARE(m_rootStore->isUserLoggedIn(), false);
}

void TestRootStoreIntegration::testRoleBasedAccess()
{
    auto loginStore = m_rootStore->loginStore();
    
    // Test regular user access
    loginStore->login("user", "demo");
    QVERIFY(m_rootStore->canAccessUserFeatures());
    QVERIFY(!m_rootStore->canAccessAdminFeatures());
    
    // Test admin access
    loginStore->logout();
    loginStore->login("admin", "admin");
    QVERIFY(m_rootStore->canAccessUserFeatures());
    QVERIFY(m_rootStore->canAccessAdminFeatures());
}

QTEST_MAIN(TestRootStoreIntegration)
#include "tst_rootstore_integration.moc"
