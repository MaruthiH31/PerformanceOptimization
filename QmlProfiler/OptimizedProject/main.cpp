// Copyright (C) 2026 Qt Group.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <qqml.h>
#include "devicedial.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<DialItem>("Custom", 1, 0, "DialItem");

    QQmlApplicationEngine engine;
    engine.loadFromModule("QMLDebugging", "Main");

    return app.exec();
}