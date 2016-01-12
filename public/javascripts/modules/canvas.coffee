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
            @$c.css("width", width)
            @$c.css("height", height)
            $root.append(c)
        destroy: ->
            console.log "Stopping canvas..."
            @$c.remove() if @$c
