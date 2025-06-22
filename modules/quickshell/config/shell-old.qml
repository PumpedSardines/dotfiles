import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import QtQuick

PanelWindow {
  anchors {
    top: true
    left: true
    right: true
  }

  color: "#00000000"
  implicitHeight: 34

  PopupWindow {
    anchor.window: toplevel
    anchor.rect.x: parentWindow.width / 2 - width / 2
    anchor.rect.y: parentWindow.height
    width: 500
    height: 500
    visible: true

    Rectangle {
      color: "#2d353b"
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      implicitHeight: parent.height - 4
      implicitWidth: parent.width - 16
      radius: 8
    }
  }

  Rectangle {
    color: "#2d353b"
    anchors.bottom: parent.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    implicitHeight: parent.height - 4
    implicitWidth: parent.width - 16
    radius: 8

    Text {
      anchors.centerIn: parent
      text: "Hej hej"
      color: "#D3C6AA"
      font.pointSize: 10
    }
  }
}
