import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle {
    id: r
    width: apps.fs*30
    height: width
    radius: width*0.5
    //Variables de Houses y Planets
    property int currentPlanetIndex: -1
    property int currentPlanetIndexBack: -1
    property int currentHouseIndex: -1
    property int currentHouseIndexBack: -1
    property var currentJson: ''
    property var currentJsonBack: ''

    //Variables
    property var aTexts: []



    Rectangle{
        //Este esta en el centro
        visible: false
        opacity: 0.5
        width: r.fs*2//planetsCircle.children[0].fs*0.85+4
        height: width
        color: 'red'
        radius: width*0.5
        border.width: 2
        border.color: 'white'
        anchors.centerIn: parent
    }


    function load(j){
        console.log('Ejecutando SweGraphic.load()...')
        let vd=j.params.d
        let vm=j.params.m
        let va=j.params.a
        let vh=j.params.h
        let vmin=j.params.min
        let vgmt=j.params.gmt
        let vlon=j.params.lon
        let vlat=j.params.lat
        let d = new Date(Date.now())
        let ms=d.getTime()
        let hsys=j.params.hsys?j.params.hsys:apps.currentHsys
        if(j.params.hsys)hsys=j.params.hsys
        vars.tipo=j.params.tipo
        vars.cParams=JSON.stringify(j)
    }
    function loadBack(j){
        let params
        params=j.params

        let vd=params.d
        let vm=params.m
        let va=params.a
        let vh=params.h
        let vmin=params.min
        let vgmt=params.gmt
        let vlon=params.lon
        let vlat=params.lat
        let d = new Date(Date.now())
        let ms=d.getTime()
        let hsys=apps.currentHsys
        app.currentFechaBack=vd+'/'+vm+'/'+va
        if(params.hsys)hsys=params.hsys

        app.mod=j.params.tipo
        app.fileDataBack=JSON.stringify(j)
    }
    function loadSweJson(json){
        var scorrJson=json.replace(/\n/g, '')

        //aspsCircle.clear()

        vars.ev=false
        apps.urlBack=''
        //panelAspectsBack.visible=false
        r.currentPlanetIndex=-1
        r.currentPlanetIndexBack=-1
        r.currentHouseIndex=-1
        r.currentHouseIndexBack=-1
        //app.currentPlanetIndex=-1
        //app.currentHouseIndex=-1

        //console.log('json: '+json)
        var j
        //try {

        //log.l(scorrJson)
        //log.visible=true
        //log.width=xApp.width*0.4
        j=JSON.parse(scorrJson)

        //r.aTexts[] reset
        let nATexts=[]
        for(var i=0;i<Object.keys(j.pc).length;i++){
            nATexts.push('')
        }
        r.aTexts=nATexts

        r.currentJson=j
        //signCircle.rot=parseFloat(j.ph.h1.gdec).toFixed(2)
        //ascMcCircle.loadJson(j)
        //housesCircle.loadHouses(j)
        //planetsCircle.loadJson(j)
        //panelAspects.load(j)
        //zoolDataBodies.loadJson(j)
        //aspsCircle.load(j)
        //zoolElementsView.load(j, false)
        //eclipseCircle.arrayWg=housesCircle.arrayWg
        //eclipseCircle.isEclipse=-1
        //r.v=true
//        let sabianos=zsm.getPanel('ZoolSabianos')
//        sabianos.numSign=app.currentJson.ph.h1.is
//        sabianos.numDegree=parseInt(app.currentJson.ph.h1.rsgdeg - 1)
//        sabianos.loadData()
//        if(apps.sabianosAutoShow){
//            //panelSabianos.state='show'
//            zsm.currentIndex=1
//        }
    }
    function loadSweJsonBack(json){
        //console.log('JSON::: '+json)
        app.currentJsonBack=JSON.parse(json)
        //        if(app.dev)
        //            log.lv('ZoolBodies.loadSweJsonBack(json): '+json)
        //            log.lv('ZoolBodies.loadSweJsonBack(json) app.currentJsonBack: '+app.currentJsonBack)
        let scorrJson=json.replace(/\n/g, '')
        //console.log('json: '+json)
        let j=JSON.parse(scorrJson)
        //signCircle.rot=parseInt(j.ph.h1.gdec)
        //planetsCircleBack.rotation=parseFloat(j.ph.h1.gdec).toFixed(2)
        if(r.objectName==='sweg'){
            panelAspectsBack.visible=true
        }
        panelAspectsBack.load(j)
        aspsCircle.add(j)
        if(app.mod!=='rs'){
            //panelElementsBack.load(j)
            zoolElementsView.load(j, true)
            //panelElementsBack.visible=true
            //Qt.quit()
        }else{
            //panelElementsBack.visible=false
        }
        housesCircleBack.loadHouses(j)
        //if(app.mod==='dirprim')housesCircleBack.rotation-=360-housesCircle.rotation
        //if(JSON.parse(app))
        planetsCircleBack.loadJson(j)
        zoolDataBodies.loadJsonBack(j)
        //panelDataBodiesV2.loadJson(j)
        let isSaved=false
        if(app.fileDataBack){
            isSaved=JSON.parse(app.fileDataBack).ms>=0
        }
        app.backIsSaved=isSaved
        if(app.dev)log.lv('sweg.loadSweJsonBack() isSaved: '+isSaved)
        app.ev=true
        //centerZoomAndPos()
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
            app.currentXAs.objOointerPlanet.pointerRot=zp[8]
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
        a.push(parseInt(app.currentXAs.uRot))
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
}
