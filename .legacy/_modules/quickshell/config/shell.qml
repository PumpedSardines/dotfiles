import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import QtQuick
import Quickshell
import Quickshell.Wayland

PanelWindow {
  id: window

    // Variants {
    //     model: Quickshell.screens
    //
    //     PanelWindow {
    //         id: win
    //         required property ShellScreen modelData
    //         screen: modelData
    //         WlrLayershell.exclusionMode: ExclusionMode.Ignore
    //         WlrLayershell.layer: WlrLayer.Overlay
    //         anchors.top: true
    //         anchors.bottom: true
    //         anchors.left: true
    //         anchors.right: true
    //         color: "#00000000"
    //         visible: true
    //
    //         Rectangle {
    //           anchors.fill: parent
    //           color: "#000000"
    //           opacity: 0.6
    //
    //           MouseArea {
    //             anchors.fill: parent
    //             enabled: true
    //             onClicked: {
    //               win.visible = false
    //             }
    //           }
    //         }
    //     }
    // }

  anchors {
    top: true
    left: true
    right: true
  }

  color: "#00000000"
  implicitHeight: 34

  LazyLoader {
    id: popupLoader

    loading: true

    PopupWindow {
      // position the popup above the button
      parentWindow: window
      relativeX: window.width / 2 - width / 2
      relativeY: window.height - 1

      visible: false
      color: "#00000000"

     Item {
        anchors.fill: parent
        clip: true
        anchors.centerIn: parent
        Rectangle {
          color: "#2d353b"
          anchors.fill: parent
          anchors.topMargin: -border.width
          border.width: 1
          border.color:"red"
          bottomLeftRadius: 8
          bottomRightRadius: 8

          MouseArea {
            anchors.fill: parent
            onExited: {
              popupLoader.item.visible = panelFull.containsMouse == false
            }
          }
        }
      }

      width: 200
      height: 200
    }
  }

  Rectangle {
    color: "#2d353b"
    anchors.bottom: parent.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    implicitHeight: parent.height - 4
    implicitWidth: parent.width - 16
    radius: 8

    MouseArea {
      anchors.fill: parent
      onClicked: {
        win.visible = true
        popupLoader.item.visible = true
      }
    }

    Text {
      anchors.centerIn: parent
      anchors.top: parent.top
      anchors.bottom: parent.bottom
      text: "Hej hej"
      color: "#D3C6AA"
      font.pointSize: 10

    }

    border.color: 'red'
    border.width: 1
  }

  PopupWindow {
    parentWindow: window
    relativeX: 8
    relativeY: 8
    visible: visible
    color: "#00000000"

    Rectangle {
      color: "#000000"
      opacity: 0.7
      anchors.fill: parent
    }

    width: window.width
  }
}
