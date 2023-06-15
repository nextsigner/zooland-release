import QtQuick 2.12
import QtGraphicalEffects 1.12

Rectangle {
    id: r
    radius: width*0.5
    color: 'transparent'
    //clip: true
    property bool isBack: false
    property bool selected: !isBack?(housesCircle.currentHouse===n):(housesCircleBack.currentHouse===n)
    property real wg: 0.0
    //property int wb: apps.widthHousesAxis
    property int gr: 0
    property int n: -1
    //property int w: housesCircle.currentHouse!==n?housesCircle.w*0.5:sweg.fs*6.5
    property int w: vars.fs
    property int c: 0
    property bool showBorder: false
    //property bool selected: vars.currentHouseIndex===n
    property  real op: 100.0
    //property int opacitySpeed: 100
    Repeater{
        model: wg-3
        Item{
            width: sweg.width*2
            height: 1
            anchors.centerIn: parent
            rotation: 0-index
            Rectangle{
                width: sweg.width-sweg.pz+vars.fs
                height: 20
                color:'red'
                anchors.top: parent.bottom
                anchors.left: parent.left
                anchors.leftMargin: sweg.pz+vars.fs
            }
        }
    }
    Repeater{
        model: 3
        Item{
            width: sweg.width*2
            height: 1
            anchors.centerIn: parent
            rotation: 0-index-(r.wg-3)//-index
            Rectangle{
                width: sweg.width-sweg.pz+vars.fs
                height: 20
                //color:'yellow'
                color:'red'
                anchors.bottom: parent.top
                anchors.left: parent.left
                anchors.leftMargin: sweg.pz+vars.fs
            }
        }
    }
    Item{
        width: sweg.width*2
        height: 1
        anchors.centerIn: parent
        rotation: 0-r.wg
        Rectangle{
            width: sweg.width-sweg.pz+vars.fs
            height: 20
            //color:'blue'
            color:'red'
            anchors.bottom: parent.top
            anchors.left: parent.left
            anchors.leftMargin: sweg.pz+vars.fs
        }
    }
}

