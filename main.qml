import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.0
import QtMultimedia 5.12

import unik.Unik 1.0

import "./js/Funcs_v2.js" as JS
import "./comps" as Comps

import unik.Unik 1.0
import ZoolMainWindow 1.0
import comps.ZoolAppSettings 1.0
import ZoolandVars 1.0

//Objetos GUI
import ZoolDataView 1.0

//Comps GUI
import comps.ZRect 1.0

ZoolMainWindow{
    id: app
    visible: true

    visibility: "Maximized"
    width: 1920//Screen.width
    height: 1080//Screen.height
    minimumWidth: Screen.desktopAvailableWidth//-app.fs*4
    minimumHeight: Screen.desktopAvailableHeight//-app.fs*4



    Unik{id: unik}
    ZoolAppSettings{id: apps}
    ZoolandVars{id: v}

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
                    wb:20
                }
                ZRect{
                    id: xMed
                    width: xApp.width*0.6
                    height: parent.height
                    wb:20
                }
                ZRect{
                    id: xLatDer
                    width: xApp.width*0.2
                    height: parent.height
                    wb:20
                }
            }
        }
    }

    Component.onCompleted: {
        unik.clearDir(unik.getPath(2))
    }
}
