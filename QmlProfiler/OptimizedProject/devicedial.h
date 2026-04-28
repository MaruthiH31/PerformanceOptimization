// Copyright (C) 2026 Maruthi Hanumanthegowda
// SPDX-License-Identifier: GPL-3.0-only

#pragma once

#include <QQuickItem>
#include <QtMath>

class DialItem : public QQuickItem
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(int value READ value WRITE setValue NOTIFY valueChanged)
    Q_PROPERTY(qreal angle READ angle NOTIFY angleChanged)

public:
    explicit DialItem(QQuickItem *parent = nullptr);

    int value() const;
    void setValue(int v);

    qreal angle() const;

signals:
    void valueChanged();
    void angleChanged();

protected:
    void mousePressEvent(QMouseEvent *event) override;
    void mouseMoveEvent(QMouseEvent *event) override;

private:
    int m_value = 50;
    qreal m_angle = 0.0;

    static constexpr int MIN_VAL = 0;
    static constexpr int MAX_VAL = 100;

    void updateFromPoint(const QPointF &pos);
    void updateAngle();
};