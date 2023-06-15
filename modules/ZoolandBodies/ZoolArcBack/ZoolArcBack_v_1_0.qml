import QtQuick 2.12
import QtGraphicalEffects 1.12

Rectangle {
    id: r
    radius: width*0.5
    color:'transparent'
    clip: true
    property bool isBack: false
    property bool selected: !isBack?(housesCircle.currentHouse===n):(housesCircleBack.currentHouse===n)
    property real wg: 0.0
    property int wb: apps.widthHousesAxis
    property int gr: 0
    property int n: -1
    //property int w: housesCircle.currentHouse!==n?housesCircle.w*0.5:sweg.fs*6.5
    property int w: vars.fs
    property int c: 0
    property bool showBorder: false
    //property bool selected: vars.currentHouseIndex===n
    property  real op: 100.0
    property int opacitySpeed: 100
    Rectangle{
        id: arc
        width: r.width//*0.5
        height: r.height//*0.5
        radius: width*0.5
        color: 'transparent'
        border.color: '#ff5833'
        clip: true
        visible: false
        Rectangle{
            id: tb
            width: r.width+border.width*2
            height: r.height+border.width*2
            color: 'transparent'
            radius: width*0.5
            border.width:r.width*0.5
            anchors.centerIn: parent
        }
//        Rectangle{
//            id: vacioCentral
//            width: r.width-r.w*2
//            height: width
//            color: 'blue'
//            radius: width*0.5
//            anchors.centerIn: parent
//        }
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
        rotation: -180
        color: 'yellow'//apps.houseColorBack
        visible: false
        anchors.centerIn: arc
    }

    OpacityMask {
        anchors.fill: arc
        source: mask
        maskSource: arc
        invert: true
        opacity: r.selected?1.0:0.5
    }
    Rectangle{
        id: ctb
        width: tb.width
        height: tb.height
        color: 'transparent'
        radius: width*0.5
        border.width:r.width*0.5
        border.color: 'pink'
        anchors.centerIn: arc
        visible: false
    }
}
