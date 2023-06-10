import QtQuick 2.0

Rectangle{
    id: r
    color: apps.backgroundColor
    anchors.fill: parent
    border.width: 1
    border.color: apps.fontColor
    property alias n: txtNom.text
    onVisibleChanged: {
        if(visible){
            app.ci=r
        }else{
            app.ci=r.parent
        }
    }
    Column{
        id: col
        Rectangle{
            id: xItemNom
            width: lv.width-app.fs*0.5
            height: txtNom.contentHeight
            color: apps.backgroundColor
            border.width: 1
            border.color: apps.fontColor
            radius: app.fs*0.15
            anchors.horizontalCenter: parent.horizontalCenter
            Text{
                id: txtNom
                width: parent.width-app.fs
                font.pixelSize: app.fs
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                anchors.centerIn: parent
                color: apps.fontColor
            }
        }
        ListView{
            id: lv
            spacing: app.fs*0.1
            width: r.width
            height: r.height-xItemNom.height
            delegate: compItem
            model: lm
            ListModel{
                id: lm
                function addItem(p){
                    return{
                        params:p
                    }
                }
            }

        }
    }
    Component{
        id: compItem
        Rectangle{
            id: xItem
            width: lv.width-app.fs*0.5
            height: txt1.contentHeight
            color: selected?apps.fontColor:apps.backgroundColor
            border.width: 1
            border.color: !selected?apps.fontColor:apps.backgroundColor
            radius: app.fs*0.15
            anchors.horizontalCenter: parent.horizontalCenter
            property bool selected: lv.currentIndex===index
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    lv.currentIndex=index
                    r.toEnter()
                }
            }
            Text{
                id: txt1
                //text: JSON.parse(JSON.stringify(params)).params.n
                width: parent.width-app.fs
                font.pixelSize: app.fs
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                anchors.centerIn: parent
                color: !selected?apps.fontColor:apps.backgroundColor
            }
            Component.onCompleted: {
                let s=''
                s+=params.params.n
                if(index>0){
                    s+='\nFecha: '+params.params.d+'/'+params.params.m+'/'+params.params.a+''
                }
                txt1.text=s
            }
        }
    }
    function load(j){
        lm.clear()
        let p=JSON.parse('{"params":{"n":"Ahora"}}')
        lm.append(lm.addItem(p))
        let sp=JSON.stringify(j, null, 2)
        //log.lv('sp: '+sp)
        if(!j.exts || j.exts.length === 0 ){
            //log.lv('Sin EXTS')
            //let sp=JSON.stringify(j, null, 2)
            //log.lv('sp: '+sp)
            //zsfdm.loadParamsFromString(sp)
        }else{
            //log.lv('Con EXTS')
            for(var i=0;i<j.exts.length;i++){
                //let sp=JSON.stringify(j, null, 2)
                let np={}
                np.params=j.exts[i]
                lm.append(lm.addItem(np))
            }
        }
        r.visible=true
    }
    //Funciones de Mando

    function toEnter(){
        //log.lv('Datos Externos: '+JSON.stringify(lm.get(lv.currentIndex).params, null, 2))
        zsfdm.getZoolandDataBack(lm.get(lv.currentIndex).params)
    }
    function toLeft(){
        r.visible=false
    }
    function toRight(){

    }
    function toDown(){
        if(lv.currentIndex<lm.count-1){
            lv.currentIndex++
        }else{
            lv.currentIndex=0
        }
    }
    function toUp(){
        if(lv.currentIndex>0){
            lv.currentIndex--
        }else{
            lv.currentIndex=lm.count-1
        }
    }


}