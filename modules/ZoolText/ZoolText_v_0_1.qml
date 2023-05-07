import QtQuick 2.12

Text {
    id: r0
    width: contentWidth+fs
    height: contentHeight+fs
    font.pixelSize: fs
    property int w//: txt.width
    property alias t: r0
    property alias r: xText
    property int fs: app.fs
    property color textBackgroundColor: 'transparent'
    property real textBackgroundOpacity: 1.0
    property int padding:  0
    property int borderWidth: 0
    property color borderColor: 'red'
    property real borderRadius: 0.0
    Rectangle{
        id: xText
        width: r0.contentWidth+r.padding*2+r.borderWidth*2//txt.width
        height: r0.contentHeight+r.padding*2+r.borderWidth*2//r.fs*1.2
        color: r0.textBackgroundColor
        border.width: r0.borderWidth
        border.color: r0.borderColor
        radius: r0.borderRadius
        opacity: r0.textBackgroundOpacity
        anchors.centerIn: r
    }
//    Text {
//        id: txt
//        font.pixelSize: r.fs
//        color: 'white'
//        //width: !r.w?txt.contentWidth:r.w
//        textFormat: Text.RichText
//        wrapMode: !r.w?Text.NoWrap:Text.WordWrap
//        //horizontalAlignment: Text.AlignHCenter
//        verticalAlignment: Text.AlignVCenter
//        anchors.centerIn: xText
//    }
}
