import bb.cascades 1.3

Page {
    Container {
        ScrollView {
            id: scrollView 
            scrollViewProperties {
                scrollMode: ScrollMode.Vertical
                pinchToZoomEnabled: true
            }
            layoutProperties: StackLayoutProperties {
                spaceQuota: 1.0
            }

            Container {
                background: Color.LightGray

                WebView {
                    id: webViewScrollable
                    url: "https://www.youtube.com/playlist?list=PLFgquLnL59akA2PflFpeQG9L01VFg90wS"

                    onMinContentScaleChanged: {
                        scrollView.scrollViewProperties.minContentScale = minContentScale;
                    }

                    onMaxContentScaleChanged: {
                        scrollView.scrollViewProperties.maxContentScale = maxContentScale;
                    }
                }
            }
        }
    }
}
