import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1
import QtQuick.XmlListModel 2.0

ApplicationWindow {
    id:root
    visible: true
    width: 800
    height: 600
    title: qsTr("Qt Window")

    minimumWidth:mainToolBar.implicitWidth

    toolBar:ToolBar{
        id:mainToolBar
        RowLayout{
            width: parent.width
            ToolButton{
                text:qsTr("Open")
                iconSource: "icons/document-open.png"
                onClicked:root.color="red"
                visible: true
                tooltip: text
            }
            ToolButton{
                text:qsTr("Save")
                iconSource: "icons/document-save.png"
                onClicked:root.color="red"
                visible: true
                tooltip: text
            }
            ToolButton{
                text:qsTr("Refresh")
                iconSource: "icons/converseen.png"
                onClicked:root.color="red"
                visible: true
                tooltip: text
            }
            Slider{
                id:slider
                Layout.fillWidth: true
                implicitWidth: 150
            }
            TextField{
                id:searchField
            }
        }
    }
    SplitView{
        anchors.fill: parent

        TableView{
            id:flickrTable
            frameVisible: false
            TableViewColumn{
                title: qsTr("Title")
                role:"title"
            }
            model:flickrModel
        }
        Image{
            id:image
            fillMode: Image.PreserveAspectFit
            source: flickrModel.get(flickrTable.currentRow).source
        }
    }

    statusBar: StatusBar{
        RowLayout{
            width:parent.width
            Label{
                id:label
                text:image.source
                Layout.fillWidth: true
                elide:Text.ElideMiddle
            }
            ProgressBar{
                value: image.progress
            }
        }
    }

    XmlListModel{
        id:flickrModel
        source: "https://api.flickr.com/services/feeds/photos_public.gne?format=rss2&tags="+searchField.text
        query: "/rss/channel/item"
        namespaceDeclarations: "declare namespace media=\"http://search.yahoo.com/mrss/\";"
        XmlRole{name:"title";query: "title/string()"}
        XmlRole{name:"date";query: "pubDate/string()"}
        XmlRole{name:"source";query: "media:content/@url/string()"}
        XmlRole{name:"credit";query: "media:credit/string()"}
    }
}
