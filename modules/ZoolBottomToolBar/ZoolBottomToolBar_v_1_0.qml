import QtQuick 2.0

Item{
    id: r
    objectName: 'bottomBar'
    width: parent.width
    height: w
    anchors.bottom: parent.bottom
    visible: app.ci===r
    property int currentIndex: 0
    property int w: app.fs*2

    Row{
        spacing: app.fs*0.25
        height: parent.height
        anchors.centerIn: parent
        Repeater{
            id: rep
            model: ['B1', 'B2', 'B3']
            Rectangle{
                width: r.currentIndex===index?r.w*2:r.w
                height: width
                radius: width*0.1
                color: apps.backgroundColor
                border.width: 1
                border.color: apps.fontColor
                anchors.bottom: parent.bottom
                Behavior on width{NumberAnimation{duration: 500}}
                Behavior on height{NumberAnimation{duration: 500}}
                Rectangle{
                    anchors.fill: parent
                    color: 'transparent'
                    border.width: 2
                    border.color: 'red'
                    visible: false
                    Timer{
                        running: app.ci===r && r.currentIndex===index
                        repeat: true
                        interval: 500
                        onTriggered: parent.visible=!parent.visible
                    }
                }
                Text{
                    text: modelData
                    font.pixelSize: parent.width*0.6
                    color: apps.fontColor
                    anchors.centerIn: parent
                }
            }
        }
    }
    function toEnter(){
        if(r.currentIndex===0){
            zhe.visible=true
        }
    }
    function toLeft(){

    }
    function toRight(){
        if(r.currentIndex<rep.model.length-1){
            r.currentIndex++
        }else{
            r.currentIndex=0
        }
    }
    function toUp(){

    }
    function toDown(){

    }

}
