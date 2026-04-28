// Copyright (C) 2026 Maruthi Hanumanthegowda
// SPDX-License-Identifier: GPL-3.0-only

#include "devicedial.h"
#include <QMouseEvent>

DialItem::DialItem(QQuickItem *parent)
    : QQuickItem(parent)
{
    setAcceptedMouseButtons(Qt::LeftButton);
    setAcceptHoverEvents(true);
    updateAngle();
}

int DialItem::value() const
{
    return m_value;
}

void DialItem::setValue(int v)
{
    v = qBound(MIN_VAL, v, MAX_VAL);
    if (m_value == v)
        return;

    m_value = v;
    updateAngle();

    emit valueChanged();
    emit angleChanged();
}

qreal DialItem::angle() const
{
    return m_angle;
}

void DialItem::updateAngle()
{
    const qreal start = -140.0;
    const qreal end   = 140.0;

    m_angle = start +
              (static_cast<qreal>(m_value) / (MAX_VAL - MIN_VAL)) *
                  (end - start);
}

void DialItem::updateFromPoint(const QPointF &pos)
{
    const qreal cx = width() / 2.0;
    const qreal cy = height() / 2.0;

    const qreal dx = pos.x() - cx;
    const qreal dy = cy - pos.y();

    const qreal rad = std::atan2(dy, dx);
    const qreal deg = -rad * 180.0 / M_PI;

    const qreal start = -140.0;
    const qreal end   = 140.0;

    qreal clamped = qBound(start, deg, end);

    int newVal = static_cast<int>(
        (clamped - start) / (end - start) * (MAX_VAL - MIN_VAL)
        );

    setValue(newVal);
}

void DialItem::mousePressEvent(QMouseEvent *event)
{
    updateFromPoint(event->position());
    event->accept();
}

void DialItem::mouseMoveEvent(QMouseEvent *event)
{
    updateFromPoint(event->position());
    event->accept();
}