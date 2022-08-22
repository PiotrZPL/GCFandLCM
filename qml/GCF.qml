/*
 * Copyright (C) 2021  Piotr Lange
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * GCF&LCM is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import Ubuntu.Components 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.3
import "./"

Page {
    id: gcfPage
    property var date: new Date()

    header: PageHeader {
        id: gcfPageHeader

        title: i18n.tr("GCF & LCM")

        extension: Sections {
            id: gcfPageHeaderSections

            anchors {
                left: parent.left
                bottom: parent.bottom
            }
            // TRANSTORS: Credits as in the code and design contributors to the app
            model: [i18n.tr("GCF"), i18n.tr("LCM")]

            StyleHints {
                selectedSectionColor: root.settings.primaryColor
            }
        }
        trailingActionBar.actions: [
			Action {
				text: i18n.tr("Theme")
				iconName: (root.settings.theme == "Ambiance") ? "torch-on" : "torch-off"
				onTriggered: root.settings.theme = (root.settings.theme == "Ambiance") ? "SuruDark" : "Ambiance"
			},
			Action {
				text: i18n.tr("About")
				iconName: "help"
				onTriggered: pageStack.push(aboutPage)
			}
		]
    }


    VisualItemModel {
        id: sections

        Item {
            width: tabView.width
            height: tabView.height

			Rectangle {
				id: gcfRectangle

				anchors.fill: parent
				
				color: backgroundColor

				TextField {
			        id: textField
			        text: ""
					inputMethodHints: Qt.ImhDigitsOnly
			        anchors {
			            topMargin: units.gu(1);
			            top: parent.top
			            left: parent.left
			            leftMargin: units.gu(1);
			            right: parent.right
			            rightMargin: units.gu(1);
			        }
			
		            height: units.gu(8)
		            font.pixelSize: units.gu(4)
		        }
		        
		        Rectangle {
				    property alias text: label.text
				    signal clicked 
				    id: mainRec
				    radius: units.gu(1) 
				    border.width: units.gu(0.25) 
					border.color: backgroundColor
				
				    property alias color_text: label.color
				    Label {
				        id: label
				        font.pixelSize: units.gu(4)
				        font.bold: true
				        anchors.centerIn: parent
				        color: "#111"
				        text: i18n.tr("Find GCF")
				    }
				
				    MouseArea {
				        id: mouseArea
				        anchors.fill: parent
				        onClicked: parent.clicked()
				    }
				    //anchors {
			            //topMargin: units.gu(15);
			            //top: textField.top
			            //left: parent.left
			            //leftMargin: units.gu(1);
			            //right: parent.right
			            //rightMargin: units.gu(1);
			        //}
			        anchors.centerIn: parent
					color: "#2d00ff"
					color_text : "black"
					height: parent.height / 6
					width: parent.width / 1.5
					onClicked: {
						python.call("gcfcalc.calcgcf", [ textField.text ], function ( result ) {
						var isValid = result[0];
						if (isValid) {
						gcfMainText.text = "The GCF is " + result[1];
						} else { 
						gcfMainText.text = "The input is invalid";
						}
					})
					}
				}
				Rectangle {
				    anchors {
				            topMargin: units.gu(1);
				            top: textField.bottom
				            left: parent.left
				            leftMargin: units.gu(1);
				            right: parent.right
				            rightMargin: units.gu(1);
				            bottom: mainRec.top
				        }
				    color: backgroundColor
				    
					Label {
			        id: gcfMainText
			        text: i18n.tr("Enter numbers separated by points")
			        font.pixelSize: units.gu(2.5)
			        font.bold: true
			        anchors.centerIn: parent
			        
				    }
		        
		        }
			}
        }

        LCM {
            width: tabView.width
            height: tabView.height
        }
    }

    ListView {
        id: tabView
        model: sections
        interactive: false

        anchors {
            top: gcfPageHeader.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        orientation: Qt.Horizontal
        snapMode: ListView.SnapOneItem
        currentIndex: gcfPageHeaderSections.selectedIndex
        highlightMoveDuration: UbuntuAnimation.FastDuration
    }     
	Python {
		id: python

		Component.onCompleted: {
			addImportPath(Qt.resolvedUrl('../src/'));
		importModule_sync("gcfcalc")
		}

		onError: {
			console.log('python error: ' + traceback);
		}
	}
}
