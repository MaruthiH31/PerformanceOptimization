// Copyright (C) 2026 Qt Group.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only
// Modifications Copyright (C) 2026 Maruthi Hanumanthegowda

pragma ComponentBehavior: Bound
import QtQuick
import Custom 1.0   // DialItem

Window {
    minimumWidth: 260
    minimumHeight: 380
    maximumWidth: minimumWidth
    maximumHeight: minimumHeight
    visible: true
    title: qsTr("Guitar Pedal")

    FontLoader {
        id: russoFontLoader
        source: "fonts/RussoOne-Regular.ttf"
    }

    FontLoader {
        id: prismaFontLoader
        source: "fonts/Prisma.ttf"
    }

    Image {
        source: "assets/Guitar-Pedal-Background.png"
        anchors.fill: parent
    }

    // ----------------------------
    // LAYOUT CONTAINER
    // ----------------------------
    Item {
        anchors.fill: parent
        anchors.leftMargin: 15
        anchors.rightMargin: 15
        anchors.topMargin: 17
        anchors.bottomMargin: 17

        // ----------------------------
        // SCREWS
        // ----------------------------
        component ScrewImage: Image {
            source: "assets/Screw.png"
        }

        ScrewImage { anchors.left: parent.left; anchors.top: parent.top }
        ScrewImage { anchors.right: parent.right; anchors.top: parent.top }
        ScrewImage { anchors.left: parent.left; anchors.bottom: parent.bottom }
        ScrewImage { anchors.right: parent.right; anchors.bottom: parent.bottom }

        // ----------------------------
        // TEXT
        // ----------------------------
        component DeviceText: Text {
            color: "#191919"
            font.family: russoFontLoader.font.family
            font.weight: russoFontLoader.font.weight
            font.pixelSize: 9
        }

        component InfoText: Column {
            id: infoLabel
            spacing: 5

            property alias text: label.text
            property alias font: label.font
            property int lineWidth: 200
            property int lineHeight: 2
            property color lineColor: "#191919"

            Rectangle { width: infoLabel.lineWidth; height: infoLabel.lineHeight; color: infoLabel.lineColor }

            DeviceText {
                id: label
                anchors.horizontalCenter: infoLabel.horizontalCenter
            }

            Rectangle { width: infoLabel.lineWidth; height: infoLabel.lineHeight; color: infoLabel.lineColor }
        }

        // ----------------------------
        // LABELS
        // ----------------------------
        InfoText {
            text: qsTr("TIME BLENDER")
            anchors.top: parent.verticalCenter
            anchors.topMargin: 16
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10
            font.family: prismaFontLoader.font.family
            font.pixelSize: 18
        }

        InfoText {
            text: qsTr("IN")
            anchors.top: parent.top
            anchors.topMargin: 60
            anchors.right: parent.right
            lineWidth: 30
        }

        InfoText {
            text: qsTr("OUT")
            anchors.top: parent.top
            anchors.topMargin: 60
            anchors.left: parent.left
            lineWidth: 30
        }
    }

    // ----------------------------
    // SWITCH IMAGE (AOT SAFE)
    // ----------------------------
    component SwitchImage: Image {
        required property string sourceBaseName
        property bool checked

        property url normalSource: "assets/" + sourceBaseName + ".png"
        property url checkedSource: "assets/" + sourceBaseName + "-Checked.png"

        source: checked ? checkedSource : normalSource
    }

    component DeviceSwitch: SwitchImage {
        id: switchImage
        property alias tapMargin: tapHandler.margin

        TapHandler {
            id: tapHandler
            onTapped: switchImage.checked = !switchImage.checked
        }
    }

    // ----------------------------
    // LED
    // ----------------------------
    SwitchImage {
        x: parent.width * 0.33 - width / 2
        y: 14
        sourceBaseName: "LED"
        checked: footPedal.checked

        Text {
            text: qsTr("CHECK")
            anchors.top: parent.bottom
            anchors.topMargin: 4
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 9
        }
    }

    // ----------------------------
    // MODE SWITCH
    // ----------------------------
    DeviceSwitch {
        x: parent.width * 0.66 - width / 2
        y: 14
        sourceBaseName: "Switch"
        tapMargin: 16

        Text {
            text: qsTr("MODE")
            anchors.top: parent.bottom
            anchors.topMargin: 4
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 9
        }
    }

    // ----------------------------
    // FOOT PEDAL
    // ----------------------------
    DeviceSwitch {
        id: footPedal
        sourceBaseName: "Button-Pedal"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 17
        anchors.horizontalCenter: parent.horizontalCenter
    }

    // ----------------------------
    // DIAL COMPONENT (C++ INPUT)
    // ----------------------------
    component DeviceDial: Item {
        id: root

        width: 80
        height: 80

        property alias text: label.text

        DialItem {
            id: dial
            anchors.fill: parent
        }

        Image {
            source: "assets/Knob-Markings.png"
            anchors.fill: parent
        }

        Image {
            source: "assets/Knob-Dial.png"
            anchors.centerIn: parent
            rotation: dial.angle   // pure C++ property
        }

        DeviceText {
            id: label
            anchors.top: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }

        DeviceText {
            text: qsTr("MIN")
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            font.pixelSize: 6
        }

        DeviceText {
            text: qsTr("MAX")
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            font.pixelSize: 6
        }
    }

    // ----------------------------
    // DIAL INSTANCES
    // ----------------------------
    DeviceDial {
        anchors.left: footPedal.left
        y: 147 - height / 2
        text: qsTr("TIME")
    }

    DeviceDial {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 67 - height / 2
        text: qsTr("LEVEL")
    }

    DeviceDial {
        anchors.right: footPedal.right
        y: 147 - height / 2
        text: qsTr("FEEDBACK")
    }
}