import css from "../css/app.css"
import "phoenix_html"

import {LiveSocket} from "phoenix_live_view";
import {Socket} from "phoenix";

let liveSocket = new LiveSocket("/live", Socket)
liveSocket.connect()