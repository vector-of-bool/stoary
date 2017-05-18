import QtQml 2.2

QtObject {
    id: req

    property string url
    property string method: "GET"
    property var body
    property bool auto: true
    property bool skipFirstAuto: false
    property string responseType: "json"
    readonly property int lastStatus: __priv.lastStatus
    readonly property var response: __priv.response
    readonly property string state: __priv.state
    readonly property bool running: __priv.running

    Component.onCompleted: {
        if (skipFirstAuto) return;
        if (!auto) return;
        if (url && method)
            send();
    }

    property QtObject __priv: QtObject {
        property int lastStatus: 0
        property int currentRequestID: 0
        property bool running: false;
        property string state
        property var response
        property var xhr
        function send() {
            if (xhr) {
                xhr.abort();
            }

            var req = xhr = new XMLHttpRequest();
            var rid = ++currentRequestID;
            var _that = this;
            req.onreadystatechange = function() {
                if (rid !== currentRequestID) {
                    console.warn("Interrupted HTTP request");
                    return;
                }
                switch(req.readyState) {
                case XMLHttpRequest.DONE: {
                    state = "done";
                    break;
                }
                case XMLHttpRequest.UNSENT: {
                    state = "unsent";
                    break;
                }
                case XMLHttpRequest.OPENED: {
                    state = "opened";
                    break;
                }
                case XMLHttpRequest.HEADERS_RECEIVED: {
                    state = "headers";
                    break;
                }
                case XMLHttpRequest.LOADING: {
                    state = "loading";
                    break;
                }
                case XMLHttpRequest.DONE: {
                    state = "done";
                    running = false;
                    response = req.response;
                    break;
                }
                }
                console.log("Request state is", state, lastStatus);
            };
            req.open(method, url);
            req.send();
            running = true;
        }
    }

    function send() {
        if (!method || !url) {
            throw new Error("Expected method and URL to be set!");
        }
        __priv.send();
    }

    function __autoSend() {
        if (!auto || !method || !url) return;
        send();
    }

    onMethodChanged: __autoSend();
    onBodyChanged: __autoSend();
    onUrlChanged: __autoSend();
}
