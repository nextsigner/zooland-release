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
import ZoolDataView 1.1
import ZoolandBodies 1.1
import ZoolandDataBodies 1.0
import ZoolSectionsManager 1.1
import ZoolBottomToolBar 1.0
import comps.ZoolUserCoordsEditor 1.0

//Comps GUI
import comps.ZRect 1.0
import comps.ZoolPanelNotifications 1.0
import ZoolLogView 1.0

//Elementos
import web.ZoolandServerFileDataManager 1.0

ZoolMainWindow{
    id: app
    visible: true
    visibility: "Maximized"
    //width: Qt.platform.os==='android'?1920:Screen.width
    //height: Qt.platform.os==='android'?1080:Screen.height
    width: Screen.width
    height: Screen.height
    title: 'Zooland'

    Unik{
        id: unik
        onUkStdChanged: {
            let std=ukStd
            std=std.replace(/&quot;/g, '"')
            log.lv(std)
        }
        Component.onCompleted: {
            unik.setEngine(engine)
        }
    }
    ZoolAppSettings{id: apps}
    ZoolandVars{id: vars}

    Item{
        id: xApp
        width: app.width-vars.xAppMargin*2
        height: app.height-vars.xAppMargin*2
        anchors.centerIn: parent
        Column{
            width: parent.width
            ZoolDataView{id: zoolDataView}
            Row{
                height: xApp.height-zoolDataView.height
                ZRect{
                    id: xLatIzq
                    width: xApp.width*0.2
                    height: parent.height
                    ZoolSectionsManager{id: zsm}
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
                    clip:true
                    ZoolandDataBodies{id: zdb}
                    ZoolPanelNotifications{id: zpn}
                }
            }
        }
        //ZoolUserManager{id: zoolUserManager}
        ZoolUserCoordsEditor{id: zuce}
        ZoolBottomToolBar{id: zbtb}
        ZoolLogView{id: log}
    }
    ZoolandServerFileDataManager{id: zsfdm}
    Component.onCompleted: {
        unik.clearDir(unik.getPath(2))
        if(Qt.application.arguments.indexOf('-dev')>=0)vars.dev=true
        zpn.addNot(unik.getFile('ucommit.txt'), true, 15000)
        let sw=Screen.width
        let sh=Screen.height
        vars.res=''+sw+'x'+sh+''
        zpn.addNot('Resolución de pantalla: '+sw+'x'+sh, true, 10000)
        if(sw===960 && sh===540){
            //Resolución 960x540 de ChromeCast HD
            zpn.addNot('Ejecutando en ChromeCast', true, 10000)
            sweg.width=vars.fs*24
            sweg.w=vars.fs
            sweg.pz=48

        }else{
            //Esta configuracion va bien 1920x1080
            zpn.addNot('Ejecutando fuera de ChromeCast', true, 10000)
            sweg.width=vars.fs*46
            sweg.w=vars.fs*1.5
            sweg.pz=60
        }
    }
}
