#include "rootstore.h"

RootStore::RootStore(QObject *parent)
    : QObject(parent),
      m_loginStore(new LoginStore(this)) {}

RootStore::~RootStore() = default;

void RootStore::setPopupIsShown(bool shown) {
    if (m_popupIsShown != shown) {
        m_popupIsShown = shown;
        emit popupIsShownChanged();
    }
}

void RootStore::showPopup() {
    setPopupIsShown(true);
}

void RootStore::hidePopup() {
    setPopupIsShown(false);
}
