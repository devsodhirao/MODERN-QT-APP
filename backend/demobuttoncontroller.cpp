#include "demobuttoncontroller.h"
#include <QPropertyAnimation>

DemoButtonController::DemoButtonController(QObject *parent)
    : QObject(parent)
{
}

void DemoButtonController::setTarget(QQuickItem* target)
{
    if (m_target == target)
        return;
    m_target = target;
    emit targetChanged();
}

void DemoButtonController::setBackground(QQuickItem* background)
{
    if (m_background == background)
        return;
    m_background = background;
    emit backgroundChanged();
}

void DemoButtonController::handleHoverChanged(bool hovered)
{
    if (m_background)
        m_background->setProperty("opacity", hovered ? 0.8 : 1.0);
}

void DemoButtonController::handlePressed()
{
    if (m_background)
        m_background->setProperty("opacity", 0.6);
    
    if (m_target) {
        QPropertyAnimation* animation = new QPropertyAnimation(m_target, "scale", this);
        animation->setDuration(200);
        animation->setEndValue(0.98);
        animation->start(QAbstractAnimation::DeleteWhenStopped);
    }
}

void DemoButtonController::handleReleased()
{
    if (m_background)
        m_background->setProperty("opacity", 1.0);
    
    if (m_target) {
        QPropertyAnimation* animation = new QPropertyAnimation(m_target, "scale", this);
        animation->setDuration(200);
        animation->setEndValue(1.0);
        animation->start(QAbstractAnimation::DeleteWhenStopped);
    }
    
    emit clicked();
}
