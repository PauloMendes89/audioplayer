import bb.cascades 1.3
import bb.cascades.pickers 1.0
import bb.multimedia 1.0
import QtMobility.sensors 1.2

NavigationPane {
    id: nav
    Page {
        Container {
            background: mybackground.imagePaint

            property int downX: 0
            property int downY: 0
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            onTouch: {

                if (event.isDown()) {
                    downX = event.windowX;
                    downY = event.windowY;
                } else if (event.isUp()) {
                    var yDiff = downY - event.windowY;
                    // Take absolute value of yDiff
                    if (yDiff < 0) yDiff = -1 * yDiff;
                    //If the y movement is less than 200: don't move left or right
                    if ((yDiff) < 200) {
                        if ((downX - event.windowX) > 320) {
                            // move right
                            if (segmentedControl.selectedOption == control1) {
                                segmentedControl.selectedOption = control2
                            } else if (segmentedControl.selectedOption == control2) {
                                segmentedControl.selectedOption = control3
                            }
                        } else if ((event.windowX - downX) > 320) {
                            // move left
                            if (segmentedControl.selectedOption == control3) {
                                segmentedControl.selectedOption = control2
                            } else if (segmentedControl.selectedOption == control2) {
                                segmentedControl.selectedOption = control1
                            }
                        }
                    }
                }
            }
            ScrollView {
                id: scrollView
                scrollViewProperties.overScrollEffectMode: OverScrollEffectMode.None
                scrollRole: ScrollRole.Main
                scrollViewProperties.initialScalingMethod: ScalingMethod.Fill

                property int startX
                property int stopX
                property int minimumDistance: ui.du(36)

                scrollViewProperties {
                    scrollMode: ScrollMode.None
                    pinchToZoomEnabled: true

                }
                eventHandlers: [
                    TouchKeyboardHandler {
                        onTouch: {
                            if (event.touchType == TouchType.Down) {
                                scrollView.startX = event.screenX
                                return
                            }
                            if (event.touchType == TouchType.Up) {
                                scrollView.stopX = event.screenX
                                var distance = scrollView.stopX - scrollView.startX
                                if (distance > scrollView.minimumDistance) {
                                    console.log("Swiped left " + distance)
                                    if (segmentedControl.selectedOption == control3) {
                                        segmentedControl.selectedOption = control2
                                    } else if (segmentedControl.selectedOption == control2) {
                                        segmentedControl.selectedOption = control1
                                    }
                                } else {
                                    if (distance < (0 - scrollView.minimumDistance)) {
                                        console.log("Swiped right " + distance)
                                        if (segmentedControl.selectedOption == control1) {
                                            segmentedControl.selectedOption = control2
                                        } else if (segmentedControl.selectedOption == control2) {
                                            segmentedControl.selectedOption = control3
                                        }
                                    } else {
                                        console.log("Distance too short...")
                                    }
                                }
                                return
                            }
                        }
                    }
                ]
                Container {
                    layout: StackLayout {
                    }
                    SegmentedControl {
                        id: segmentedControl
                        opacity: 0.5
                        options: [
                            Option {
                                id: control1
                                text: "Player"
                            },
                            Option {
                                id: control2
                                text: "Social"
                            },
                            Option {
                                id: control3
                                text: "Options"
                            }
                        ]
                        onSelectedOptionChanged: {
                            if (selectedOption == control1) {
                                container1.visible = true
                                container2.visible = false
                                container3.visible = false
                            } else if (selectedOption == control2) {
                                container1.visible = false
                                container2.visible = true
                                container3.visible = false
                            } else if (selectedOption == control3) {
                                container1.visible = false
                                container2.visible = false
                                container3.visible = true
                            }
                        }
                    }
                    //CONTAINER1
                    Container {
                        id: container1
                        // background:  mybackground.imagePaint
                        onCreationCompleted: {
                            FilePickerMode.Picker
                            filePicker.open();
                        }
                        Container {
                            layout: GridLayout {
                                columnCount: 4
                            }

                            ImageButton {
                                id: launchFilePicker
                                defaultImageSource: "asset:///images/defaultSearch.jpg"
                                pressedImageSource: "asset:///images/pressedSearch.jpg"
                                minHeight: 50
                                onClicked: {
                                    filePicker.open();
                                }
                            }

                            ImageButton {
                                id: fav
                                defaultImageSource: "asset:///images/defaultSearch.jpg"
                                pressedImageSource: "asset:///images/pressedSearch.jpg"
                                minHeight: 50
                                onClicked: {

                                }
                            }

                            ImageButton {
                                id: yout
                                defaultImageSource: "asset:///images/defaultSearch.jpg"
                                pressedImageSource: "asset:///images/pressedSearch.jpg"
                                onClicked: {

                                }
                            }
                            ImageButton {
                                id: launchFilePicke
                                defaultImageSource: "asset:///images/defaultSearch.jpg"
                                pressedImageSource: "asset:///images/pressedSearch.jpg"
                                minHeight: 50
                                onClicked: {
                                    filePicker.open();
                                }
                            }
                        }

                        Container {
                            preferredHeight: maxHeight
                            preferredWidth: maxWidth
                            //                            topPadding: 20.0 //Added to give some space
                            layout: StackLayout {
                            }
                            horizontalAlignment: HorizontalAlignment.Fill
                            TextArea {
                                id: lblHeader
                                backgroundVisible: false
                                text: "wqesaa"
                                editable: false
                                autoSize.maxLineCount: 2
                                scrollMode: TextAreaScrollMode.Elastic
                                textFit {
                                    minFontSizeValue: 8
                                    maxFontSizeValue: 8
                                }
                                inputMode: TextAreaInputMode.Text

                                textStyle {
                                    base: SystemDefaults.TextStyles.BigText
                                    color: Color.Gray
                                    fontSize: FontSize.XLarge

                                }
                                animations: [
                                    TranslateTransition {
                                        id: translateAnimation
                                        toX: ui.sdu(-100)
                                        duration: 10000
                                        repeatCount: 99
                                    }
                                ]
                            }

                            ProgressBar {
                                horizontalAlignment: HorizontalAlignment.Center
                                verticalAlignment: VerticalAlignment.Bottom

                                duration: nowPlaying.duration
                                position: nowPlaying.position
                            }
                        }

                        Container {
                            preferredHeight: minHeight
                            preferredWidth: maxWidth
                            verticalAlignment: VerticalAlignment.Bottom
                            layout: GridLayout {
                                columnCount: 3
                                //orientation: LayoutOrientation.LeftToRight
                            }
                            // topPadding: 100.0 //Added to give some space

                            Button {
                                id: previousTrack
                                text: "previous"
                                onClicked: {
                                    //FilePickerMode.SaverMultiple
                                    myPlayer.previousTrack()
                                }
                            }
                            Button {
                                id: myButton
                                //  verticalAlignment: VerticalAlignment.Bottom
                                property int state: 0
                                imageSource: "images/play_btn1.png"
                                onClicked: {
                                    switch (state) {
                                        case 0:
                                            {
                                                state = 1;
                                                myButton.imageSource = "images/pause_btn1.png"
                                                myPlayer.play()
                                                break;
                                            }
                                        case 1:
                                            {
                                                state = 0;
                                                myButton.imageSource = "images/play_btn1.png"
                                                myPlayer.pause()
                                                break;
                                            }
                                    }
                                }
                            }
                            Button {
                                id: nextTrack
                                text: "next"
                                // defaultImageSource: "asset:///images/music.png"
                                //text: "menus"
                                onClicked: {
                                    //FilePickerMode.SaverMultiple
                                    // filePicker.open();
                                    myPlayer.nextTrack()
                                }
                            }
                        }

                    }
                    //CONTAINER2
                    Container {
                        id: container2
                        //background:  mybackground.imagePaint
                        visible: false
                        layout: GridLayout {
                            columnCount: 1
                        }
                        Label {
                            text: "Youtube?*"
                            horizontalAlignment: HorizontalAlignment.Center
                            verticalAlignment: VerticalAlignment.Center
                            textStyle.base: SystemDefaults.TextStyles.BigText
                            onTouch: {
                            }
                        }

                        Label {
                            text: "Share?"
                            horizontalAlignment: HorizontalAlignment.Center
                            verticalAlignment: VerticalAlignment.Center
                            textStyle.base: SystemDefaults.TextStyles.BigText
                            onTouch: {
                            }
                        }

                        Label {
                            text: "Trending"
                            horizontalAlignment: HorizontalAlignment.Center
                            verticalAlignment: VerticalAlignment.Center
                            textStyle.base: SystemDefaults.TextStyles.BigText
                            onTouch: {
                                var trendPage = trendingPage.createObject();
                                nav.push(trendPage)
                            }
                        }
                    }
                    ////CONTAINER3
                    Container {
                        id: container3
                        //  background:  mybackground.imagePaint
                        visible: false
                        layout: GridLayout {
                            columnCount: 1
                        }

                        Label {
                            text: "Cor"
                            textStyle.base: SystemDefaults.TextStyles.BigText
                            textStyle.color: Color.Red
                            textStyle.fontStyle: FontStyle.Italic
                            onTouch: {
                            }
                        }
                        Label {
                            text: "Background"
                            textStyle.base: SystemDefaults.TextStyles.BigText
                            textStyle.color: Color.Red
                            textStyle.fontStyle: FontStyle.Italic
                            onTouch: {
                                //picturePicker.open();
                                backSheet.open();
                            }
                        }
                        Label {
                            text: "autoSleep**"
                            textStyle.base: SystemDefaults.TextStyles.BigText
                            onTouch: {
                            }
                        }
                        Label {
                            text: "Crossfading**"
                            textStyle.base: SystemDefaults.TextStyles.BigText
                            onTouch: {
                            }
                        }
                        Label {
                            text: "Lyrics"
                            textStyle.base: SystemDefaults.TextStyles.BigText
                            onTouch: {
                            }
                        }
                        Label {
                            text: "Equalizador"
                            textStyle.base: SystemDefaults.TextStyles.BigText
                            onTouch: {
                            }
                        }
                        Label {
                            text: "About us"
                            textStyle.base: SystemDefaults.TextStyles.BigText
                            onTouch: {
                            }
                        }
                    }
                }
            }
        }

        attachedObjects: [

            Sheet {
                id: backSheet

                NavigationPane {
                    id: nav2

                    Page {
                        id: stampListPage
                        Container {
                            layout: StackLayout {

                            }

                            Container {
                                layout: GridLayout {
                                    columnCount: 2
                                }
                                Button {
                                    text: "back"
                                    onClicked: {
                                        backSheet.close()
                                    }
                                }
                                Button {
                                    text: "search"
                                    onClicked: {
                                        picturePicker.open();
                                        backSheet.close();
                                    }
                                }
                            }
                            // A paper-style image is used to tile the background.
                            background: backgroundPaint.imagePaint

                            attachedObjects: [
                                ImagePaintDefinition {
                                    id: backgroundPaint
                                    imageSource: "asset:///imagesStamp//Scribble_light_256x256.amd"
                                    repeatPattern: RepeatPattern.XY
                                }
                            ]

                            // Main List
                            ListView {
                                id: stampList
                                objectName: "stampList"

                                layout: GridListLayout {
                                    columnCount: 2
                                    headerMode: ListHeaderMode.Standard
                                    cellAspectRatio: 1.4
                                    spacingAfterHeader: ui.du(4)
                                    verticalCellSpacing: 0
                                }

                                // This data model will be replaced by a JSON model when the application starts,
                                // an XML model can be used to prototype the UI and for smaller static lists.
                                dataModel: XmlDataModel {
                                    source: "stamps.xml"
                                }

                                listItemComponents: [
                                    ListItemComponent {
                                        type: "header"

                                        Header {
                                            title: {
                                                if (ListItemData.title) {
                                                    // If the data is loaded from XML, a title property is used for the title.
                                                    ListItemData.title
                                                } else {
                                                    // If it is loaded from JSON and set in a GroupDataModel, the header info is set in ListItemData.
                                                    ListItemData
                                                }
                                            }
                                        }
                                    },
                                    // The stamp Item
                                    ListItemComponent {
                                        type: "item"
                                        StampItem {
                                        }
                                    }
                                ] // listItemComponents

                                onTriggered: {

                                    // To avoid triggering navigation when pressing the header items, we check so that the
                                    // index path length is larger then one (one entry would be a group under a header item).
                                    if (indexPath.length > 1) {
                                        // When an item is selected we push the recipe Page in the chosenItem file attribute.
                                        var chosenItem = dataModel.data(indexPath);

                                        // Create the content page and push it on top to drill down to it.
                                        var contentpage = contentPageDefinition.createObject();

                                        // Set the content properties to reflect the selected image.
                                        contentpage.contentImageURL = chosenItem.URL

                                        mybackground.setImageSource(contentpage.contentImageURL)
                                        backSheet.close();
                                    }
                                }
                            }
                        }

                    } // Container

                    onPopTransitionEnded: {
                        // Transition is done destroy the Page to free up memory.
                        page.destroy();
                    }
                } 

                attachedObjects: [

                    // This is the definition of the Content page used to create a page in the onTriggered signal-handler above.
                    ComponentDefinition {
                        id: contentPageDefinition
                        source: "ContentPage.qml"
                    }
                ]
                // Navigation Page
            },

            ImagePaintDefinition {
                id: mybackground
                imageSource: "asset:///images/wallpaper.jpg"

            },
            ComponentDefinition {
                id: trendingPage
                source: "Trending.qml"
            },
            LayoutUpdateHandler {
                property int theWidth
                onLayoutFrameChanged: {
                    theWidth = layoutFrame.width;
                }
            },

            FilePicker {
                id: filePicker
                type: FileType.Music
                mode: FilePickerMode.Picker
                onFileSelected: {
                    lblHeader.text = root.getCurrentPath(selectedFiles)
                    // translateAnimation.play();
                    myPlayer.setSourceUrl(root.getCurrentPath(selectedFiles))
                    myPlayer.mediaState.Prepared
                    console.log("selected files: " + selectedFiles)
                }
            },

            FilePicker {
                id: picturePicker
                type: FileType.Picture
                mode: FilePickerMode.Picker
                // objectName: "picturePicker"

                onFileSelected: {
                    console.log("selected files: " + selectedFiles)
                    mybackground.setImageSource(root.getCurrentPath(selectedFiles))
                    //  root.saveValueFor(picturePicker.objectName, root.getCurrentPath(selectedFiles))
                    //  root.
                }
            },

            MediaPlayer {
                id: myPlayer
            },

            NowPlayingConnection {
                id: nowPlaying
                duration: myPlayer.duration
                position: myPlayer.position
                iconUrl: "asset:///images/music.png"
                mediaState: myPlayer.mediaState

                onAcquired: {
                    myPlayer.play()
                    nowPlaying.mediaState = MediaState.Started
                }

                onPause: {
                    myPlayer.pause()
                }

                onPlay: {
                    myPlayer.play()
                }

                onRevoked: {
                    myPlayer.stop()
                }
            }
        ]
    }

}