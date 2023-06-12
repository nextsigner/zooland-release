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

ZoolMainWindow{
    id: app
    visible: true

    //Código que falló en la Tv de Mario
    visibility: "Maximized"
    width: Screen.width
    height: Screen.height
    minimumWidth: Screen.desktopAvailableWidth//-app.fs*4
    minimumHeight: Screen.desktopAvailableHeight//-app.fs*4

    Unik{id: unik}
    ZoolAppSettings{id: apps}


    Component.onCompleted: {
        unik.clearDir(unik.getPath(2))
    }
}
