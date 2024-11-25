#pragma once

#include <QObject>
#include <QScopedPointer>
#include <QQmlEngine>
#include "loginstore.h"

class RootStore : public QObject {
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(LoginStore* loginStore READ loginStore CONSTANT)
    Q_PROPERTY(bool popupIsShown READ popupIsShown WRITE setPopupIsShown NOTIFY popupIsShownChanged)

public:
    explicit RootStore(QObject *parent = nullptr);
    ~RootStore() override;

    LoginStore* loginStore() const { return m_loginStore.data(); }

    bool popupIsShown() const { return m_popupIsShown; }
    void setPopupIsShown(bool shown);

signals:
    void popupIsShownChanged();
    void initialized();

public slots:
    void showPopup();
    void hidePopup();

private:
    QScopedPointer<LoginStore> m_loginStore;
    bool m_popupIsShown = false;
};
