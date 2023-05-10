import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.0
import Qt.labs.folderlistmodel 2.12

//import unik.UnikQProcess 1.0
import unik.Unik 1.0


import "./js/Funcs_Zooland_v1.js" as JS
import "./comps" as Comps

//Default Modules
import comps.ZoolAppSettings 1.0
//import ZoolNewsAndUpdates 3.4
import ZoolMainWindow 1.0
//import ZoolTopMenuBar 1.0
import ZoolText 0.1
import ZoolDataBar 3.1
import ZoolDataView 1.1
import ZoolLogView 1.0
import ZoolControlsTime 1.0

//import ZoolFileDataManager 1.0
import web.ZoolandServerFileDataManager 1.0
import ZoolandBodies 1.0

import ZoolControlsTime 1.0

import ZoolSectionsManager 1.1

import ZoolDataBodies 3.1
import ZoolElementsBack 1.0
import ZoolElementsView 1.0

import comps.ZoolPanelNotifications 1.0
import web.ZoolWebStatusManager 1.0
import comps.MinymaClient 1.0

//import ZoolVoicePlayer 1.0
import ZoolDataEditor 1.0
import ZoolVideoPlayer 1.0
import ZoolInfoDataView 1.0
import ZoolBottomBar 1.0




ZoolMainWindow{
    id: app
    visible: true
    visibility: "Maximized"
    width: Screen.width
    height: Screen.height
    minimumWidth: Screen.desktopAvailableWidth-app.fs*4
    minimumHeight: Screen.desktopAvailableHeight-app.fs*4
    color: apps.enableBackgroundColor?apps.backgroundColor:'black'
    //title: argtitle && argtitle.length>1?argtitle:'Zool '+version
    title: 'Zooland '+version
    property bool dev: Qt.application.arguments.indexOf('-dev')>=0
    property string version: '0.0.-1'
    property string sweBodiesPythonFile: 'astrologica_swe_v2.py'
    property var j: JS

    property string mainLocation: ''
    //property string pythonLocation: Qt.platform.os==='linux'?'python3':pythonLocationSeted?'"'+pythonLocationSeted+'"':'"'+unik.getPath(4)+'/Python/python.exe'+'"'

    property string pythonLocation: Qt.platform.os==='linux'?'python3':'"'+currentPath+'/Python/python.exe'+'"'

    property int fs: apps.fs//Qt.platform.os==='linux'?width*0.02:width*0.02
    property string stringRes: 'Screen'+Screen.width+'x'+Screen.height
    property string url
    property string mod: 'vn'

    property bool backIsSaved: false

    property var objInFullWin
    property bool capturing: false

    property bool showCenterLine: false
    property bool enableAn: false
    property int msDesDuration: 500

    property var minymaClient
    property var objZoolFileExtDataManager
    property var aExtsIds: []

    property string fileData: ''
    property string fileDataBack: ''
    property string currentData: ''
    property string currentDataBack: ''
    property var currentJson
    property var currentJsonBack
    property bool setFromFile: false

    //Para analizar signos y ascendentes por región
    property int currentIndexSignData: 0
    property var currentJsonSignData: ''

    property int currentPlanetIndex: -1
    property int currentPlanetIndexBack: -1

    property int currentHouseIndex: -1
    property int currentHouseIndexBack: -1

    property int currentSignIndex: 0

    property date currentDate
    property string currentNom: ''
    property string currentFecha: ''
    property string currentLugar: ''
    property int currentAbsolutoGradoSolar: -1
    property int currentGradoSolar: -1
    property int currentRotationxAsSol: -1
    property int currentMinutoSolar: -1
    property int currentSegundoSolar: -1
    property real currentGmt: 0
    property real currentLon//: 0.0
    property real currentLat//: 0.0
    property real currentAlt: 0

    property date currentDateBack
    property string currentNomBack: ''
    property string currentFechaBack: ''
    property string currentLugarBack: ''
    property int currentAbsolutoGradoSolarBack: -1
    property int currentGradoSolarBack: -1
    property int currentMinutoSolarBack: -1
    property int currentSegundoSolarBack: -1
    property real currentGmtBack: 0
    property real currentLonBack: 0.0
    property real currentLatBack: 0.0


    property bool lock: false
    property string uSon: ''
    property string uSonFCMB: ''
    property string uSonBack: ''

    property string uCuerpoAsp: ''

    property var signos: ['Aries', 'Tauro', 'Géminis', 'Cáncer', 'Leo', 'Virgo', 'Libra', 'Escorpio', 'Sagitario', 'Capricornio', 'Acuario', 'Piscis']
    //property var planetas: ['Sol', 'Luna', 'Mercurio', 'Venus', 'Marte', 'Júpiter', 'Saturno', 'Urano', 'Neptuno', 'Plutón', 'N.Norte', 'N.Sur', 'Quirón', 'Selena', 'Lilith']
    property var planetas: ['Sol', 'Luna', 'Mercurio', 'Venus', 'Marte', 'Júpiter', 'Saturno', 'Urano', 'Neptuno', 'Plutón', 'N.Norte', 'N.Sur', 'Quirón', 'Selena', 'Lilith', 'Pholus', 'Ceres', 'Pallas', 'Juno', 'Vesta']
    //property var planetasArchivos: ['sol', 'luna', 'mercurio', 'venus', 'marte', 'jupiter', 'saturno', 'urano', 'neptuno', 'pluton', 'nodo_norte', 'nodo_sur', 'quiron', 'selena', 'lilith', 'asc', 'mc']
    property var planetasArchivos: ['sol', 'luna', 'mercurio', 'venus', 'marte', 'jupiter', 'saturno', 'urano', 'neptuno', 'pluton', 'nodo_norte', 'nodo_sur', 'quiron', 'selena', 'lilith', 'pholus', 'ceres', 'pallas', 'juno', 'vesta', 'asc', 'mc']
    property var planetasReferencia: ['el sol', 'la luna', 'el planeta mercurio', 'el planeta venus', 'el planeta marte', 'el planeta jupiter', 'el planeta saturno', 'el planeta urano', 'el planeta neptuno', 'pluton', 'el nodo norte', 'el nodo sur', 'el asteroide quiron', 'la luna blanca selena', 'la luna negra lilith', 'el ascendente', 'el medio cielo']
    property var planetasRes: ['sun', 'moon', 'mercury', 'venus', 'mars', 'jupiter', 'saturn', 'uranus', 'neptune', 'pluto', 'n', 's', 'hiron', 'selena', 'lilith', 'pholus', 'ceres', 'pallas', 'juno', 'vesta']
    property var objSignsNames: ['ari', 'tau', 'gem', 'cnc', 'leo', 'vir', 'lib', 'sco', 'sgr', 'cap', 'aqr', 'psc']
    property var signColors: ['red', '#FBE103', '#09F4E2', '#0D9FD6','red', '#FBE103', '#09F4E2', '#0D9FD6','red', '#FBE103', '#09F4E2', '#0D9FD6']
    property var meses: ['enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', 'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre']

    //Asp Astrolog Search
    property var planetasAS: ['Sol', 'Luna', 'Mercurio', 'Venus', 'Marte', 'Júpiter', 'Saturno', 'Urano', 'Neptuno', 'Plutón', 'N.Norte']
    //property var planetasResAS: ['sun', 'moon', 'mercury', 'venus', 'mars', 'jupiter', 'saturn', 'uranus', 'neptune', 'pluto', 'North Node']

    property var arbolGenealogico: ['Raíz', 'Portal', 'Ala', 'Integrador']

    //property var ahys: ['P', 'K', 'O', 'R', 'C', 'A', 'V', 'X', 'H', 'T', 'B', 'G', 'M']
    property var ahys: ['P', 'K', 'O', 'R', 'C', 'A', 'V', 'X', 'H', 'T', 'B', 'M']
    //property var ahysNames: ['Placidus', 'Koch', 'Porphyrius', 'Regiomontanus', 'Campanus', 'Iguales', 'Vehlow', 'Sistema de Rotación Axial', 'Azimuthal', 'Topocéntrico', 'Alcabitus', 'Gauquelin', 'Morinus']
    property var ahysNames: ['Placidus', 'Koch', 'Porphyrius', 'Regiomontanus', 'Campanus', 'Iguales', 'Vehlow', 'Sistema de Rotación Axial', 'Azimuthal', 'Topocéntrico', 'Alcabitus', 'Morinus']
    /*
                ‘P’     Placidus
                ‘K’     Koch
                ‘O’     Porphyrius
                ‘R’     Regiomontanus
                ‘C’     Campanus
                ‘A’ or ‘E’     Equal (cusp 1 is Ascendant)
                ‘V’     Vehlow equal (Asc. in middle of house 1)
                ‘X’     axial rotation system
                ‘H’     azimuthal or horizontal system
                ‘T’     Polich/Page (“topocentric” system)
                ‘B’     Alcabitus
                ‘G’     Gauquelin sectors
                ‘M’     Morinus
*/

    property int uAscDegreeTotal: -1
    property int uAscDegree: -1
    property int uMcDegree: -1
    //property string stringRes: "Res"+Screen.width+"x"+Screen.height

    property var cmd
    property bool ev: false //Exterior Visible

    //XAs
    property var currentXAs
    property bool showPointerXAs: true
    property var currentXAsBack
    property bool showPointerXAsBack: true

    property bool sspEnabled: false

    onCurrentPlanetIndexChanged: {
        zoolDataBodies.currentIndex=currentPlanetIndex
        if(currentPlanetIndex>=0){
            app.currentPlanetIndexBack=-1
            app.currentHouseIndexBack=-1
        }
        if(sspEnabled){
            if(currentPlanetIndex>=-1&&currentPlanetIndex<10){
                app.ip.opacity=1.0
                app.ip.children[0].ssp.setPlanet(currentPlanetIndex)
            }else{
                app.ip.opacity=0.0
            }
        }
        //zoolDataBodies.currentIndex=currentPlanetIndex
        if(currentPlanetIndex>14){
            /*if(currentPlanetIndex===20){
                sweg.objHousesCircle.currentHouse=1
                swegz.sweg.objHousesCircle.currentHouse=1
            }
            if(currentPlanetIndex===16){
                sweg.objHousesCircle.currentHouse=10
                swegz.sweg.objHousesCircle.currentHouse=10
            }*/
        }
    }
    onCurrentPlanetIndexBackChanged: {
        zoolDataBodies.currentIndexBack=currentPlanetIndexBack
        if(currentPlanetIndexBack>=0){
            app.currentPlanetIndex=-1
            app.currentHouseIndex=-1
        }
    }
    onCurrentGmtChanged: {
        if(app.currentData===''||app.setFromFile)return
        //xDataBar.currentGmtText=''+currentGmt
        tReload.restart()
    }
    onCurrentGmtBackChanged: {
        //if(app.currentData===''||app.setFromFile)return
        //xDataBar.currentGmtText=''+currentGmtBack
        //tReloadBack.restart()
    }
    onCurrentDateChanged: {
        controlsTime.setTime(currentDate)
        //if(app.currentData===''||app.setFromFile)return
        //xDataBar.state='show'
        let a=currentDate.getFullYear()
        let m=currentDate.getMonth()
        let d=currentDate.getDate()
        let h=currentDate.getHours()
        let min=currentDate.getMinutes()
        //xDataBar.currentDateText=d+'/'+parseInt(m + 1)+'/'+a+' '+h+':'+min
        //xDataBar.currentGmtText=''+currentGmt
        //tReload.restart()
    }
    onCurrentDateBackChanged: {
        controlsTimeBack.setTime(currentDateBack)
        if(app.mod==='trans'){
            JS.loadTransFromTime(app.currentDateBack)
        }
        //xDataBar.state='show'
        let a=currentDateBack.getFullYear()
        let m=currentDateBack.getMonth()
        let d=currentDateBack.getDate()
        let h=currentDateBack.getHours()
        let min=currentDateBack.getMinutes()
        //tReloadBack.restart()
    }

    FontLoader {name: "fa-brands-400";source: "./fonts/fa-brands-400.ttf";}
    FontLoader {name: "FontAwesome";source: "./fonts/fontawesome-webfont.ttf";}
    FontLoader {name: "ArialMdm";source: "./fonts/ArialMdm.ttf";}
    FontLoader {name: "TypeWriter";source: "./fonts/typewriter.ttf";}
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
    ZoolandServerFileDataManager{id: zsfdm}
    Item{
        id: xApp
        anchors.fill: parent
        Rectangle{
            id: xSwe1
            //width: xApp.width-xLatIzq.width-xLatDer.width
            width: sweg.width
            height: xApp.height
            color: apps.backgroundColor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 0-xLatDer.width*0.5
            anchors.bottom: parent.bottom
            clip: false
            ZoolandBodies{id: sweg;objectName: 'sweg'}
        }        
    }
    Item{
        id: capa101
        anchors.fill: xApp
        ZoolDataView{id: zoolDataView;}
        Row{
            anchors.top: zoolDataView.bottom
            anchors.bottom: parent.bottom//xBottomBar.top
            Item{
                id: xMed
                //width: xApp.width-xLatIzq.width-xLatDer.width
                width: xApp.width-xLatDer.width
                height: parent.height
                ZoolElementsView{id: zoolElementsView}
                //ExtId
                Text{
                    text: '<b>uExtId: '+zoolDataView.uExtIdLoaded+'</b>'
                    font.pixelSize: app.fs*0.5
                    color: apps.fontColor
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: app.dev
                }
                Item{
                    id: xControlsTime
                    width: controlsTime.width
                    height: controlsTime.height
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    property bool showCT: false
                    MouseArea{
                        anchors.fill: parent
                        onClicked: xControlsTime.showCT=!xControlsTime.showCT
                    }
                    Item{
                        id:xIconClock
                        width: app.fs
                        height: width
                        //anchors.horizontalCenter: parent.horizontalCenter
                        anchors.right: parent.left
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: app.fs*0.1
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                xControlsTime.showCT=!xControlsTime.showCT
                                xControlsTimeBack.showCT=false
                            }
                        }
                        Text{
                            id:ccinit
                            text:'\uf017'
                            font.family: 'FontAwesome'
                            font.pixelSize: app.fs*0.75
                            color: apps.houseColor
                            anchors.centerIn: parent
                        }
                    }
                    //Comps.ControlsTime{
                    ZoolControlsTime{
                        id: controlsTime
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: h
                        property int h: parent.showCT?0:0-height
                        setAppTime: true
                        onGmtChanged: app.currentGmt=gmt
                        Behavior on h{NumberAnimation{duration: 250; easing.type: Easing.InOutQuad}}
                    }

                }
                Item{
                    id: xControlsTimeBack
                    width: controlsTimeBack.width
                    height: controlsTimeBack.height
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: app.ev
                    property bool showCT: false
                    MouseArea{
                        anchors.fill: parent
                        onClicked: xControlsTimeBack.showCT=!xControlsTimeBack.showCT
                    }
                    Item{
                        id:xIconClockBack
                        width: app.fs
                        height: width
                        //anchors.horizontalCenter: parent.horizontalCenter
                        //anchors.horizontalCenterOffset: width+app.fs*0.5
                        anchors.left: parent.right
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: app.fs*0.1
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                xControlsTimeBack.showCT=!xControlsTimeBack.showCT
                                xControlsTime.showCT=false
                            }
                        }
                        Text{
                            id:ccinitBack
                            text:'\uf017'
                            font.family: 'FontAwesome'
                            font.pixelSize: app.fs*0.75
                            color: apps.houseColorBack//apps.fontColor
                            anchors.centerIn: parent
                        }
                    }
                    ZoolControlsTime{
                        id: controlsTimeBack
                        isBack: true
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: h
                        property int h: parent.showCT?0:0-height
                        setAppTime: true
                        onGmtChanged: app.currentGmtBack=gmt
                        Behavior on h{NumberAnimation{duration: 250; easing.type: Easing.InOutQuad}}
                    }
                }
                Rectangle{
                    width: parent.width
                    height: 3
                    color: 'red'
                    anchors.bottom: parent.bottom
                    visible: apps.zFocus==='xMed'
                }
            }
            Item{
                id: xLatDer
                width: xApp.width*0.4
                height: parent.height
                ZoolDataBodies{id: zoolDataBodies}
                Rectangle{
                    width: parent.width
                    height: 3
                    color: 'red'
                    anchors.bottom: parent.bottom
                    visible: apps.zFocus==='xLatDer'
                }
                ZoolPanelNotifications{id: zpn}
            }
        }
        //Comps.XDataStatusBar{id: xDataStatusBar}
//        ZoolBodiesGuiTools{
//            id: xTools
//            anchors.bottom: parent.bottom
//            anchors.right: parent.right
//            anchors.rightMargin: xLatDer.width//*0.2
//        }
        //ZoolBottomBar{id: xBottomBar}
        //ZoolInfoDataView{id: xInfoData}
        //ZoolDataEditor{id: xEditor}
        //Num.PanelLog{id: panelLog}
        //ZoolVideoPlayer{id: panelVideLectura;}
        //Comps.VideoListEditor{id: videoListEditor}
    }


    ZoolLogView{id: log}
    ZoolWebStatusManager{id: zwsm}

    Component.onCompleted: {
        JS.setFs()

        //Check is dev with the arg -dev
        if(Qt.application.arguments.indexOf('-dev')>=0){
            app.dev=true
        }

        if(Qt.platform.os==='linux'){
            let compMinyma=Qt.createComponent('./modules/comps/MinymaClient/MinymaClient.qml')
            let objMinyma=compMinyma.createObject(app, {loginUserName: 'zool'+(app.dev?'-dev':''), host: apps.minymaClientHost, port: apps.minymaClientPort})
            objMinyma.newMessageForMe.connect(function(from, data) {
                if(data==='isWindowTool'){
                    if(app.flags===Qt.Tool){
                        minymaClient.sendData(minymaClient.loginUserName, from, 'isWindowTool=true')
                    }else{
                        minymaClient.sendData(minymaClient.loginUserName, from, 'isWindowTool=false')
                    }
                }
                if(data==='windowToWindow'){
                    app.flags=Qt.Window
                }
                if(data==='windowToTool'){
                    app.flags=Qt.Tool
                }

                //To zoolMediaLive
                if(data==='zoolMediaLive.loadBodiesNow()'){
                    zoolMediaLive.loadBodiesNow()
                }
                if(data==='zoolMediaLive.play()'){
                    zoolMediaLive.play()
                }
                if(data==='zoolMediaLive.pause()'){
                    zoolMediaLive.pause()
                }
                if(data==='zoolMediaLive.stop()'){
                    zoolMediaLive.stop()
                }
                if(data==='zoolMediaLive.previous()'){
                    zoolMediaLive.previous()
                }
                if(data==='zoolMediaLive.next()'){
                    zoolMediaLive.next()
                }
            });
            objMinyma.onNewMessage.connect(function(from, to, data) {
                //Aqui se puede poner un bloque de código
                //para procesar todos los datos que procesa MinymaServer.
            });
            app.minymaClient=objMinyma
        }

//        let v=unik.getFile('./version')
//        app.version=v.replace(/\n/g, '')
//        if(app.version!==apps.lastVersion || app.dev){
//            apps.lastVersion=app.version
//            let c='import QtQuick 2.0\n'
//            c+='import ZoolNewsAndUpdates 3.4\n'
//            c+='ZoolNewsAndUpdates{}\n'
//            let obj=Qt.createQmlObject(c, xLatIzq, 'znaucode')
//            obj.z=log.z+1
//        }


        //Argumentos
        let args=Qt.application.arguments
        var i=0
        for(i=0;i<args.length;i++){
            let a=args[i]
            if(a.indexOf('-title=')>=0){
                let mt=a.split('-title=')
                app.title=mt[1]
            }
        }                app.mainLocation=unik.getPath(5)
        if(Qt.platform.os==='windows'){
            app.mainLocation="\""+app.mainLocation+"\""
        }

        apps.host='https://zool.loca.lt'
        //JS.loadModules()
        app.requestActivate()
        //log.focus=true
    }
}
