#ifndef DEMOBUTTONCONTROLLER_H
#define DEMOBUTTONCONTROLLER_H

#include <QObject>
#include <QtQuick>

class DemoButtonController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQuickItem* target READ target WRITE setTarget NOTIFY targetChanged)
    Q_PROPERTY(QQuickItem* background READ background WRITE setBackground NOTIFY backgroundChanged)

public:
    explicit DemoButtonController(QObject *parent = nullptr);

    QQuickItem* target() const { return m_target; }
    void setTarget(QQuickItem* target);

    QQuickItem* background() const { return m_background; }
    void setBackground(QQuickItem* background);

public slots:
    void handleHoverChanged(bool hovered);
    void handlePressed();
    void handleReleased();

signals:
    void targetChanged();
    void backgroundChanged();
    void clicked();

private:
    QQuickItem* m_target = nullptr;
    QQuickItem* m_background = nullptr;
};
