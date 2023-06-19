import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import "../../js/Funcs.js" as JS
import "../../js/Capture.js" as Cap

ApplicationWindow {
    id: r
    property alias ip: itemXPlanets
    color: apps?apps.backgroundColor:'red'
    Item{
        id: itemXPlanets
        anchors.fill: parent
        //XPlanets{id: xPlanets}
        function showSS(){
            let comp=Qt.createComponent("XPlanets.qml")
            let obj=comp.createObject(itemXPlanets)
            if(obj){
                vars.sspEnabled=true
            }
        }
        function hideSS(){
            for(var i=0;itemXPlanets.children.length;i++){
                itemXPlanets.children[i].destroy(1)
            }
        }
        Component.onCompleted: {
            if(unik.objectName!=='unikpy'){
                showSS()

            }
        }
    }

    //    Keys.onDownPressed: {
    //        log.l('event: '+event.text)
    //        log.visible=true
    //    }


    Component.onCompleted: {

    }
    Shortcut{
        sequence: 'Esc'
        onActivated: app.close()
    }
    Shortcut{
        sequence: 'Enter'
        onActivated: {
            if(vars.ci){
                vars.ci.toEnter()
            }
        }
    }
    Shortcut{
        sequence: 'Up'
        onActivated: {
            if(vars.ci){
                vars.ci.toUp()
            }
//            if(vars.currentPlanetIndex>0){
//                vars.currentPlanetIndex--
//            }else{
//                vars.currentPlanetIndex=21
//            }
        }
    }
    Shortcut{
        sequence: 'Down'
        onActivated: {
            if(vars.ci){
                vars.ci.toDown()
            }
//            if(vars.currentPlanetIndex<21){
//                vars.currentPlanetIndex++
//            }else{
//                vars.currentPlanetIndex=0
//            }
        }
    }
    Shortcut{
        sequence: 'Left'
        onActivated: {
            if(log.visible){
                log.visible=false
                return
            }
            if(vars.ci && vars.ci.objectName==='list'){
                vars.ci=zdb
                return
            }else if(vars.ci && vars.ci.objectName==='zdb'){
                if(zdb.latFocus===1  && vars.ev){
                    zdb.latFocus=0
                }else{
                    zbtb.currentIndex=zbtb.maximunIndex
                    vars.ci=zbtb
                }

                return
            }else if(vars.ci && vars.ci.objectName==='bottomBar'){
                if(zbtb.currentIndex === 0){
                    if(zsm.getPanel('ZoolRemoteParamsList').ol.visible){
                        vars.ci=zsm.getPanel('ZoolRemoteParamsList').ol
                    }else{
                        vars.ci=zsm.getPanel('ZoolRemoteParamsList')
                    }
                    return
                }
                //vars.ci=zdb
                //return
            }else{
                zbtb.currentIndex=zbtb.maximunIndex
                vars.ci=zbtb
            }
            vars.ci.toLeft()

            //Qt.quit()
        }
    }
    Shortcut{
        sequence: 'Right'
        property int v: 0
        onActivated: {
            if(vars.ci && vars.ci.objectName==='list'){
                zbtb.currentIndex=0
                vars.ci=zbtb
                return
            }else if(vars.ci && vars.ci.objectName==='zdb'){
                if(zdb.latFocus===0 && vars.ev){
                    zdb.latFocus=1
                }else{
                    if(zsm.getPanel('ZoolRemoteParamsList').ol.visible){
                        vars.ci=zsm.getPanel('ZoolRemoteParamsList').ol
                    }else{
                        vars.ci=zsm.getPanel('ZoolRemoteParamsList')
                    }
                }
                return
            }else if(vars.ci && vars.ci.objectName==='bottomBar'){
                if(zbtb.maximunIndex === zbtb.currentIndex){
                    vars.ci=zdb
                    return
                }
                //vars.ci=zdb
                //return
            }else{
                vars.ci=zsm.getPanel('ZoolRemoteParamsList')
            }
            vars.ci.toRight()
            /*if(v<vars.aParams.length-1){
                v++
            }else{
                v=0
            }
            zsfdm.loadParamsFromString(vars.aParams[v])*/
        }
    }

}
