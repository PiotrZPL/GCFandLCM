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

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'gcfandlcm.piotrzpl'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)
    
    //property list<ContentItem> transferItemList
    //property var contentTransfer
    property string app_version: "1.0.1"

    
    property var settings: Settings {
        property string primaryColor: "#0169c9"
        property string theme: "Ambiance"
        onThemeChanged: Theme.name = "Ubuntu.Components.Themes." + settings.theme
    }
    
    Component {
        id: aboutPage
        About {}
    }
    
    Component {
        id: gcfPage
        GCF {}
    }
    
    Component {
        id: lcmPage
        LCM {}
    }
    
    PageStack{
        id: pageStack

        Component.onCompleted: push(gcfPage)

	    
	}
}
