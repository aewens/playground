define [
    "corejs"
], (Core) ->
    Core.register "canvas", (sandbox) ->
        init: ->
            console.log "Starting canvas..."
            # @el = #canvas
            $root = sandbox.use("$")(@el)
            c = document.createElement("canvas")
            @$c = sandbox.use("$")(c)
            width = window.innerWidth
            height = window.innerHeight
            rw = Math.floor(Math.log(width) / Math.log(2))
            rh = Math.floor(Math.log(height) / Math.log(2))
            w = Math.pow(2, rw)
            h = Math.pow(2, rh)
            lr = (width - w) / 2
            tb = (height - h) / 2
            # console.log w / rw, h / rh
            @$c.css("width", w)
            @$c.css("height", h)
            @$c.css("margin", "#{tb}px #{lr}px")
            $root.append(c)
        destroy: ->
            console.log "Stopping canvas..."
            @$c.remove() if @$c
