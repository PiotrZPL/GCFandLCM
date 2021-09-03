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
 
import QtQuick 2.4
import Ubuntu.Components 1.3
import io.thp.pyotherside 1.3
import "./"

Item {
    id: lcmPage
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
		        text: i18n.tr("Find LCM")
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
			color: "#ff0009"
			color_text : "black"
			height: parent.height / 6
			width: parent.width / 2
			onClicked: {
				python.call("lcmcalc.calclcm", [ textField.text ], function ( result ) {
				var isValid = result[0];
				if (isValid) {
				lcmMainText.text = "The LCM is " + result[1];
				} else { 
				lcmMainText.text = "The input is invalid";
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
	        id: lcmMainText
	        text: i18n.tr("Enter numbers separated by points")
	        font.pixelSize: units.gu(2.5)
	        font.bold: true
	        anchors.centerIn: parent
	        
		    }
        
        }
	}
	Python {
		id: python

		Component.onCompleted: {
			addImportPath(Qt.resolvedUrl('../src/'));
		importModule_sync("lcmcalc")
		}

		onError: {
			console.log('python error: ' + traceback);
		}
	}
}
