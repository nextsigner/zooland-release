import QtQuick 2.0
import QtQuick.Controls 2.0

import ZoolandBodies.ZoolPlanetsCircle 1.1
import ZoolandBodies.ZoolPlanetsCircleBack 1.4
import ZoolandBodies.ZoolHousesCircle 1.2
import ZoolHousesCircleBack 1.2

import ZoolElementsView 1.0

//import ZoolBodies.ZoolAspectsView 1.0
//import ZoolBodies.ZoolAspectsViewBack 1.0

import ZoolandBodies.ZoolandSignCircle 1.1


Rectangle {
    id: r
    width: vars.fs*24
    height: width
    radius: width*0.5
    color: 'transparent'
    border.width: 1
    border.color: apps.fontColor
    anchors.centerIn: parent

    //Alias
    property alias objHousesCircle: housesCircle

    //Variables de Houses y Planets
    property int pz: 60
    property int currentPlanetIndex: -1
    property int currentPlanetIndexBack: -1
    property int currentHouseIndex: -1
    property int currentHouseIndexBack: -1
    property var currentJson: ''
    property var currentJsonBack: ''
    property int waps: ((signCircle.width-pz*2)*0.5)


    //Variables
    property var listCotasShowing: []
    property var aTexts: []
    property int w: vars.fs
    property bool v: false
    property bool enableAnZoomAndPos: false
    property real dirPrimRot: 0.0

    Rectangle {
        id: rect
        border.width: 0
        //width: r.width//Math.max(xSweg.width, flick.width)*2
        width: Math.max(xSweg.width, r.width)*2
        height: Math.max(xSweg.height, r.height)*2
        border.color: '#ff8833'
        color: 'transparent'
        antialiasing: true
        //anchors.centerIn: parent
        //x:(parent.width-width)/2
        transform: Scale {
            id: scaler
            origin.x: pinchArea.m_x2
            origin.y: pinchArea.m_y2
            xScale: pinchArea.m_zoom2
            yScale: pinchArea.m_zoom2
            Behavior on origin.x{NumberAnimation{duration: r.enableAnZoomAndPos?2500:1}}
            Behavior on origin.y{NumberAnimation{duration: r.enableAnZoomAndPos?2500:1}}
            Behavior on xScale{NumberAnimation{duration: r.enableAnZoomAndPos?2500:1}}
            Behavior on yScale{NumberAnimation{duration: r.enableAnZoomAndPos?2500:1}}
        }
        Behavior on x{NumberAnimation{duration: r.enableAnZoomAndPos?2500:1}}
        Behavior on y{NumberAnimation{duration: r.enableAnZoomAndPos?2500:1}}
        PinchArea {
            id: pinchArea
            anchors.fill: parent

            property real m_x1: 0
            property real m_y1: 0
            property real m_y2: 0
            property real m_x2: 0
            property real m_zoom1: 0.5
            property real m_zoom2: 0.5
            property real m_max: 6
            property real m_min: 0.5

            onPinchStarted: {
                console.log("Pinch Started")
                m_x1 = scaler.origin.x
                m_y1 = scaler.origin.y
                m_x2 = pinch.startCenter.x
                m_y2 = pinch.startCenter.y
                rect.x = rect.x + (pinchArea.m_x1-pinchArea.m_x2)*(1-pinchArea.m_zoom1)
                rect.y = rect.y + (pinchArea.m_y1-pinchArea.m_y2)*(1-pinchArea.m_zoom1)
            }
            onPinchUpdated: {
                console.log("Pinch Updated")
                m_zoom1 = scaler.xScale
                var dz = pinch.scale-pinch.previousScale
                var newZoom = m_zoom1+dz
                if (newZoom <= m_max && newZoom >= m_min) {
                    m_zoom2 = newZoom
                }
            }
            Timer{
                id: tEnableAnZoomAndPos
                running: false
                repeat: false
                interval: 1500
                onTriggered: r.enableAnZoomAndPos=true
            }
            MouseArea {
                //z:parent.z-1
                id: dragArea
                hoverEnabled: true
                anchors.fill: parent
                drag.target: rect
                drag.filterChildren: true
                onWheel: {
                    r.enableAnZoomAndPos=false
                    pinchArea.m_x1 = scaler.origin.x
                    pinchArea.m_y1 = scaler.origin.y
                    pinchArea.m_zoom1 = scaler.xScale
                    pinchArea.m_x2 = mouseX
                    pinchArea.m_y2 = mouseY

                    var newZoom
                    if (wheel.angleDelta.y > 0) {
                        newZoom = pinchArea.m_zoom1+0.1
                        if (newZoom <= pinchArea.m_max) {
                            pinchArea.m_zoom2 = newZoom
                        } else {
                            pinchArea.m_zoom2 = pinchArea.m_max
                        }
                    } else {
                        newZoom = pinchArea.m_zoom1-0.1
                        if (newZoom >= pinchArea.m_min) {
                            pinchArea.m_zoom2 = newZoom
                        } else {
                            pinchArea.m_zoom2 = pinchArea.m_min
                        }
                    }
                    rect.x = rect.x + (pinchArea.m_x1-pinchArea.m_x2)*(1-pinchArea.m_zoom1)
                    rect.y = rect.y + (pinchArea.m_y1-pinchArea.m_y2)*(1-pinchArea.m_zoom1)
                    //console.debug(rect.width+" -- "+rect.height+"--"+rect.scale)
                }
                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.AllButtons;
                    onClicked: {
                        apps.zFocus='xMed'
                        if (mouse.button === Qt.RightButton) {

                            menuRuedaZodiacal.uX=mouseX
                            menuRuedaZodiacal.uY=mouseY
                            menuRuedaZodiacal.isBack=false
                            menuRuedaZodiacal.popup()
                        }
                    }
                    onDoubleClicked: {
                        centerZoomAndPos()
                    }
                }
            }
        }
        Item{
            id: xSweg
            width: r.width//*0.25
            height: width
            anchors.centerIn: parent
            ZoolHousesCircleBack{//rotation: parseInt(signCircle.rot);//z:signCircle.z+1;
                id: housesCircleBack
                //width: bordeSignCircleExt.width//signCircle.width
                height: width
                anchors.centerIn: signCircle
                //w: r.fs
                //widthAspCircle: aspsCircle.width*2
                //visible: vars.ev
                //z: 9999
            }
            ZoolHousesCircle{
                id: housesCircle
                width: !vars.ev?r.width*2:500
                height: width
                anchors.centerIn: signCircle
                //z: 9999+1
            }
            //                AxisCircle{id: axisCircle}
            //                NumberLines{}
            ZoolandSignCircle{
                id: signCircle
                width: !vars.ev?r.width*2-(vars.fs*8):500//-apps.fs*4//-
                //width: r.width*2-(vars.fs*8)
                //width: !vars.ev?r.width*2-(vars.fs*8):r.width*2-housesCircleBack.extraWidth//-apps.fs*4//-r.w
                //width: planetsCircle.expand?r.width-r.fs*6+r.fs*2:r.width-r.fs*6
                anchors.centerIn: parent
                showBorder: true
                v:r.v
                w: r.w
                onRotChanged: housesCircle.rotation=rot
                //onShowDecChanged: Qt.quit()
            }
            AspCircleV2{
                id: aspsCircle
                //width: signCircle.width-r.w-planetsCircle.widthAllPlanets*2-planetsCircle.planetSize
                width: (bordeHousesCircleInt.width)*2
                rotation: signCircle.rot - 90// + 1
            }
            //AscMcCircle{id: ascMcCircle;width: signCircle.width}
            ZoolPlanetsCircle{
                id: planetsCircle
                width: signCircle.width-r.w*4
                height: width
                anchors.centerIn: parent
                //showBorder: true
            }
            //                PlanetsCircleBack{
            //                    id:planetsCircleBack
            //                    height: width
            //                    anchors.centerIn: parent
            //                    visible: vars.ev
            //                }
            //                ZoolPlanetsCircleBack{
            //                    id:planetsCircleBack
            //                    height: width
            //                    anchors.centerIn: parent
            //                    visible: vars.ev
            //                }
            //                EclipseCircle{
            //                    id: eclipseCircle
            //                    width: housesCircle.width
            //                    height: width
            //                }
            //                Rectangle{
            //                    width: 3
            //                    height: r.height*2
            //                    color: apps.fontColor
            //                    anchors.centerIn: parent
            //                    visible: vars.showCenterLine
            //                }
            //                Rectangle{
            //                    width: r.height*2
            //                    height: 3
            //                    color: apps.fontColor
            //                    anchors.centerIn: parent
            //                    visible: vars.showCenterLine
            //                }
            //ZoolAutoPanZoom{id:zoolAutoPanZoom}
        }
    }
    ZoolElementsView{id: zoolElementsView;parent: r.parent}



    //Rect Borde SignCircle Ext
    Rectangle{
        id: bordeSignCircleExt
        width: signCircle.width*0.5
        height: width
        radius: width*0.5
        color: 'transparent'
        border.width: 1
        border.color: apps.fontColor
        anchors.centerIn: parent
        //visible: false
    }
    //Rect Borde SignCircle Int
    Rectangle{
        id: bordeSignCircleInt
        width: (signCircle.width*0.5)-sweg.w*2
        height: width
        radius: width*0.5
        color: 'transparent'
        border.width: 1
        border.color: apps.fontColor
        anchors.centerIn: parent
        //visible: false
    }
    //Rect Borde HousesCircle Int
    Rectangle{
        id: bordeHousesCircleInt
        width: bordeSignCircleInt.width-r.waps
        height: width
        radius: width*0.5
        color: 'transparent'
        border.width: 1
        border.color: apps.fontColor
        anchors.centerIn: parent
        //visible: false
    }
    //Rect Borde HousesCircleBack Int
    Rectangle{
        id: bordeHousesCircleBackInt
        width: housesCircleBack.width*0.5//-r.waps
        height: width
        radius: width*0.5
        color: 'transparent'
        border.width: 10
        border.color: apps.fontColor
        anchors.centerIn: parent
        //visible: false
    }
    //Rect Central
    Rectangle{
        width: vars.fs
        height: width
        color: 'yellow'
        anchors.centerIn: parent
        visible: false
    }

    function loadSweJson(json, jsonPromesaParams){
        vars.tipo=jsonPromesaParams.params.tipo
        vars.cParams=JSON.stringify(jsonPromesaParams)
        vars.currentFecha=jsonPromesaParams.params.d+'/'+jsonPromesaParams.params.m+'/'+jsonPromesaParams.params.a
        var scorrJson=json.replace(/\n/g, '')

        aspsCircle.clear()

        vars.ev=false
        apps.urlBack=''
        //panelAspectsBack.visible=false
        r.currentPlanetIndex=-1
        r.currentPlanetIndexBack=-1
        r.currentHouseIndex=-1
        r.currentHouseIndexBack=-1

        let j=JSON.parse(scorrJson)

        //r.aTexts[] reset
        let nATexts=[]
        for(var i=0;i<Object.keys(j.pc).length;i++){
            nATexts.push('')
        }
        r.aTexts=nATexts

        r.currentJson=j

        signCircle.rot=parseFloat(j.ph.h1.gdec).toFixed(2)
        housesCircle.loadHouses(j)
        planetsCircle.loadJson(j)



        if(vars.dev){
            //housesCircle.opacity=0.75
            //housesCircleBack.loadHouses(j)
            //housesCircleBack.rotation+=50
            //housesCircleBack.extraWidth=300
        }


        //ascMcCircle.loadJson(j)

        //panelAspects.load(j)
        //zoolDataBodies.loadJson(j)
        //aspsCircle.load(j)
        zoolElementsView.load(j, false)
        //eclipseCircle.arrayWg=housesCircle.arrayWg
        //eclipseCircle.isEclipse=-1
        //r.v=true
        //        let sabianos=zsm.getPanel('ZoolSabianos')
        //        sabianos.numSign=vars.currentJson.ph.h1.is
        //        sabianos.numDegree=parseInt(vars.currentJson.ph.h1.rsgdeg - 1)
        //        sabianos.loadData()
        //        if(apps.sabianosAutoShow){
        //            //panelSabianos.state='show'
        //            zsm.currentIndex=1
        //        }
    }
    function loadSweJsonBack(json, jsonPromesaParams){
        //aspsCircle.clear()
        vars.tipoBack=jsonPromesaParams.params.tipo
        vars.cParamsBack=JSON.stringify(jsonPromesaParams)
        vars.currentFechaBack=jsonPromesaParams.params.d+'/'+jsonPromesaParams.params.m+'/'+jsonPromesaParams.params.a
        //let jsonC1=vars.cParams
        let scorrJson=json.replace(/\n/g, '')
        let j=JSON.parse(scorrJson)
        housesCircleBack.loadHouses(j)
        //housesCircleBack.extraWidth=300
    }

    function nextState(){
        let currentIndexState=r.aStates.indexOf(r.state)
        if(currentIndexState<r.aStates.length-1){
            currentIndexState++
        }else{
            currentIndexState=0
        }
        r.state=r.aStates[currentIndexState]
        //swegz.sweg.state=r.state
    }
    function centerZoomAndPos(){
        pinchArea.m_x1 = 0
        pinchArea.m_y1 = 0
        pinchArea.m_x2 = 0
        pinchArea.m_y2 = 0
        pinchArea.m_zoom1 = 0.5
        pinchArea.m_zoom2 = 0.5
        rect.x = 0
        rect.y = 0
    }
    function zoomTo(z){
        centerZoomAndPos()
        pinchArea.m_zoom1 = z
        pinchArea.m_zoom2 = z
    }
    function setZoomAndPos(zp){
        r.uZp=zp
        pinchArea.m_x1 = zp[0]
        pinchArea.m_y1 = zp[1]
        pinchArea.m_x2 = zp[2]
        pinchArea.m_y2 = zp[3]
        pinchArea.m_zoom1 = zp[4]
        pinchArea.m_zoom2 = zp[5]
        rect.x = zp[6]
        rect.y = zp[7]
        if(zp[8]){
            vars.currentXAs.objOointerPlanet.pointerRot=zp[8]
        }
    }
    function getZoomAndPos(){
        let a = []
        a.push(parseFloat(pinchArea.m_x1).toFixed(2))
        a.push(parseFloat(pinchArea.m_y1).toFixed(2))
        a.push(parseFloat(pinchArea.m_x2).toFixed(2))
        a.push(parseFloat(pinchArea.m_y2).toFixed(2))
        a.push(parseFloat(pinchArea.m_zoom1).toFixed(2))
        a.push(parseFloat(pinchArea.m_zoom2).toFixed(2))
        a.push(parseInt(rect.x))
        a.push(parseInt(rect.y))
        a.push(parseInt(vars.currentXAs.uRot))
        return a
    }
    function getIndexSign(gdec){
        let index=0
        let g=0.0
        for(var i=0;i<12+5;i++){
            g = g + 30.00
            if (g > parseFloat(gdec)){
                break
            }
            index = index + 1
        }
        return index
    }
    function convertDDToDMS(D, lng) {
        return {
            dir: D < 0 ? (lng ? "W" : "S") : lng ? "E" : "N",
            deg: 0 | (D < 0 ? (D = -D) : D),
            min: 0 | (((D += 1e-9) % 1) * 60),
            sec: (0 | (((D * 60) % 1) * 6000)) / 100,
        };
    }
    function getDDToDMS(D) {
        return {
            deg: 0 | (D < 0 ? (D = -D) : D),
            min: 0 | (((D += 1e-9) % 1) * 60),
            sec: (0 | (((D * 60) % 1) * 6000)) / 100,
        };
    }
    function clearAspsCircles(){
        aspsCircle.clear()
    }
    function setWaps(){
        let mpw=signCircle.width
        let a=[]
        for(var i=0;i<vars.planetasRes.length;i++){
            if(planetsCircle.children[i].width<mpw)mpw=planetsCircle.children[i].width
        }
        let w=(bordeSignCircleInt.width*2-mpw)
        sweg.waps=w
        //zpn.addNot('W: '+w, false, 5000)
    }
}
