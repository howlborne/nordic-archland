import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: window

    width: 400
    height: 330
    minimumWidth: 400
    minimumHeight: 280
    maximumWidth: 400
    maximumHeight: 400
    visible: true
    title: "Authentication Required"

    onClosing: {
        hpa.setResult("fail");
    }

    SystemPalette {
        id: system
        colorGroup: SystemPalette.Active
    }

    Rectangle {
        anchors.fill: parent
        color: system.window

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 24
            spacing: 16

            // Header
            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "Authentication Required"
                font.pointSize: 14
                font.weight: Font.Medium
                color: system.windowText
            }

            // User info
            Text {
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: 8
                text: "for " + hpa.getUser()
                font.pointSize: 11
                color: Qt.darker(system.windowText, 1.3)
            }

            Rectangle {
                Layout.topMargin: 8
                Layout.bottomMargin: 8
                Layout.fillWidth: true
                height: 1
                color: Qt.darker(system.window, 1.3)
            }

            // Message
            Text {
                Layout.fillWidth: true
                text: hpa.getMessage()
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 10
                color: system.windowText
            }

            // Password field
            TextField {
                id: passwordField
                Layout.fillWidth: true
                Layout.topMargin: 16
                placeholderText: "Enter password"
                echoMode: TextInput.Password
                focus: true

                Keys.onReturnPressed: {
                    authenticateButton.clicked();
                }

                Keys.onEnterPressed: {
                    authenticateButton.clicked();
                }

                background: Rectangle {
                    color: "transparent"
                    border.color: Qt.darker(system.window, 1.5)
                    border.width: 1
                    radius: 4
                }

                Connections {
                    target: hpa
                    function onFocusField() {
                        passwordField.focus = true;
                    }
                    function onBlockInput(block) {
                        passwordField.readOnly = block;
                        if (!block) {
                            passwordField.focus = true;
                            passwordField.selectAll();
                        }
                    }
                }
            }

            // Error message
            Text {
                id: errorLabel
                Layout.fillWidth: true
                height: errorLabel.text ? implicitHeight : 0
                visible: errorLabel.text
                text: ""
                color: "#e74c3c"
                font.pointSize: 9
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.Wrap

                Connections {
                    target: hpa
                    function onSetErrorString(e) {
                        errorLabel.text = e;
                    }
                }
            }

            // Spacer
            Item {
                Layout.fillHeight: true
            }

            // Buttons
            RowLayout {
                Layout.alignment: Qt.AlignRight
                spacing: 8

                Button {
                    text: "Cancel"
                    flat: true
                    onClicked: hpa.setResult("fail")
                }

                Button {
                    id: authenticateButton
                    text: "Authenticate"
                    highlighted: true
                    onClicked: hpa.setResult("auth:" + passwordField.text)
                }
            }
        }
    }

    // Global keyboard handler for Escape
    Keys.onEscapePressed: (e) => {
        hpa.setResult("fail");
    }
}
