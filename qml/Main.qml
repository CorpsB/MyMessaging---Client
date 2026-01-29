import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: win
    visible: true
    width: 1100
    height: 700
    title: "MyMessaging -- Client"

    palette.window: "#111318"
    palette.base: "#0c0e12"
    palette.text: "#e6e6e6"
    palette.button: "#1b1f2a"
    palette.buttonText: "#e6e6e6"
    palette.highlight: "#3b82f6"
    palette.highlightedText: "white"

    property int currentChannelIndex: 0

    Rectangle {
        anchors.fill: parent
        color: win.palette.window
    }

    RowLayout {
        id: root
        anchors.fill: parent
        spacing: 12
        Frame {
            Layout.preferredWidth: 320
            Layout.fillHeight: true
            padding: 0

            ColumnLayout {
                anchors.fill: parent

                Item {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50

                    Label {
                        anchors.fill: parent
                        text: "Nom du serveur"
                        font.pixelSize: 30
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: "white"
                    }
                }

                Frame {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    padding: 0

                    ButtonGroup {
                        id: channelGroup
                        exclusive: true
                    }

                    ListView {
                        id: channelList
                        anchors.fill: parent
                        clip: true
                        spacing: 6

                        model: ListModel {
                            ListElement { name: "# général" }
                            ListElement { name: "# annonces" }
                            ListElement { name: "# dev" }
                            ListElement { name: "# vocal" }
                        }

                        delegate: ItemDelegate {
                            width: channelList.width
                            text: model.name

                            checkable: true
                            ButtonGroup.group: channelGroup

                            checked: (index === win.currentChannelIndex)
                            onClicked: win.currentChannelIndex = index

                            background: Rectangle {
                                radius: 8
                                color: (parent.checked ? "#243044" : "transparent")
                                border.color: (parent.checked ? "#3b82f6" : "transparent")
                            }
                        }
                    }
                }
            }
        }

        Frame {
            Layout.fillWidth: true
            Layout.fillHeight: true
            padding: 12

            Label {
                text: "Droite"
                color: win.palette.text
            }
        }
    }
}
