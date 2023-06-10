import QtQuick 2.12
import QtGraphicalEffects 1.12

Rectangle {
    id: r
    radius: width*0.5
    color:'transparent'
    clip: true
    property real wg: 0.0
    property int wb: apps.widthHousesAxis
    property int gr: 0
    property int n: -1
    //property int w: housesCircle.currentHouse!==n?housesCircle.w*0.5:sweg.fs*6.5
    property int w: app.fs
    property int c: 0
    property var colors: [apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor, apps.houseColor]
    property var colors2: ['red', '#FBE103', '#09F4E2', '#0D9FD6','red', '#FBE103', '#09F4E2', '#0D9FD6','red', '#FBE103', '#09F4E2', '#0D9FD6']
    property bool showBorder: false
    property bool selected: app.currentHouseIndex===n
    property  real op: 100.0
    property int opacitySpeed: 100
    property int extraWidth: 0
    //visible: n===1 || n === 2
    Rectangle{
        id: bug
        width: r.width//*0.5
        height: r.height//*0.5
        //color: 'yellow'
        radius: width*0.5
        color: 'transparent'
        //border.width: 10
        border.color: '#ff5833'
        clip: true
        visible: false
        Rectangle{
            id: tb
            //width: parent.width+border.width
            //height: parent.height+border.width
            width: r.width+border.width*2
            height: r.height+border.width*2
            color: 'transparent'
            radius: width*0.5
            border.width:r.width*0.5
            anchors.centerIn: parent
        }
        Rectangle{
            id: vacioCentral
            width: r.width*0.5//-r.w*2
            height: width
            color: 'blue'
            radius: width*0.5
            anchors.centerIn: parent
        }
        Item{
            id: e1
            width: parent.width
            height: 1
            rotation: -90//r.wr//180+r.wr//-15
            anchors.centerIn: parent
            Rectangle{
                width: parent.parent.width
                height: parent.parent.height
                color: 'pink'
                anchors.left: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Item{
            id: e2
            width: parent.width
            height: 1
            rotation: -90-r.wg//r.wr
            anchors.centerIn: parent
            Rectangle{
                width: parent.parent.width
                height: parent.parent.height
                color: 'pink'
                anchors.right: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

    }


    Rectangle{
        id: mask
        width: r.width
        height: r.height
        //color: app.signColors[r.c]
        rotation: -180
        color: r.colors2[r.n]
        visible: false
        anchors.centerIn: bug
    }

    OpacityMask {
        anchors.fill: bug
        source: mask
        maskSource: bug
        invert: true
        rotation:0//-90-15//-15//-45//-30+10
        Rectangle{
            width: 300
            height: 80//r.width
            x:100
            anchors.verticalCenter: parent.verticalCenter
            //anchors.centerIn: parent
            color: 'blue'
            rotation: 0
            Text{
                text: 'H'+r.n+' Wg: '+r.wg
                font.pixelSize: 50
                color: 'yellow'
                anchors.centerIn: parent
            }
        }
    }
    Rectangle{
        id: ctb
        width: tb.width
        height: tb.height
        color: 'transparent'
        radius: width*0.5
        border.width:r.width*0.5
        border.color: 'pink'
        anchors.centerIn: bug
        visible: false
    }
    Rectangle{
        id: eje0
        width: r.width*2
        height: 4
        color: 'red'
        anchors.centerIn: parent
    }


}
