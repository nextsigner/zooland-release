import QtQuick 2.0
import ZoolText 1.0
import "../"

import ZoolandBodies.ZoolArc 1.0

Item {
    id: r
    height: width
    anchors.centerIn: parent
    property real wg: 0.0
    property int wb: apps.widthHousesAxis
    property int gr: 0
    property int n: -1
    //property int w: housesCircle.currentHouse!==n?housesCircle.w*0.5:sweg.fs*6.5
    property int w: vars.fs
    property int c: 0    

    ZoolArc{
        id: zsa
        //width: signCircle.width-(sweg.w*4)
        width:500
        height: width
        w: 300//width*0.5//-aspsCircle.width
        n: r.n//index===0?1:(index===1?9:5)
        c:r.n
        gr: r.gr//xSignArcs.rotation
        wg: r.wg
        //rotation: index*(360/3)-30
        anchors.centerIn: parent

    }
}
