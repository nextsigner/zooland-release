import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.0
import QtMultimedia 5.12

import unik.Unik 1.0


import "./comps" as Comps

import unik.Unik 1.0
import ZoolMainWindow 1.0
import comps.ZoolAppSettings 1.0
import ZoolandVars 1.0

//Objetos GUI
import ZoolDataView 1.0
import ZoolandBodies 1.1

//Comps GUI
import comps.ZRect 1.0
import comps.ZoolPanelNotifications 1.0

//Elementos
import web.ZoolandServerFileDataManager 1.0

ZoolMainWindow{
    id: app
    visible: true
    visibility: "Maximized"
    width: Qt.platform.os==='android'?1920:Screen.width
    height: Qt.platform.os==='android'?1080:Screen.height
    title: 'Zooland'

    Unik{id: unik}
    ZoolAppSettings{id: apps}
    ZoolandVars{id: vars}

    Item{
        id: xApp
        anchors.fill: parent
        Column{
            ZoolDataView{id: zoolDataView}
            Row{
                height: xApp.height-zoolDataView.height
                ZRect{
                    id: xLatIzq
                    width: xApp.width*0.2
                    height: parent.height
                    Text{
                        id: txtUCommit
                        width: parent.width-10
                        color: apps.fontColor
                        font.pixelSize: 20
                        wrapMode: Text.WordWrap
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        Component.onCompleted: {
                            zpn.addNot(unik.getFile('ucommit.txt'), true, 15000)
                        }
                    }
                }
                ZRect{
                    id: xMed
                    width: xApp.width*0.6
                    height: parent.height
                    ZoolandBodies{id: sweg}
                }
                ZRect{
                    id: xLatDer
                    width: xApp.width*0.2
                    height: parent.height
                    ZoolPanelNotifications{id: zpn}
                }
            }
        }
    }
    ZoolandServerFileDataManager{id: zsfdm}
    Component.onCompleted: {
        unik.clearDir(unik.getPath(2))
        if(Qt.application.arguments.indexOf('-dev')>=0)vars.dev=true
    }
}
