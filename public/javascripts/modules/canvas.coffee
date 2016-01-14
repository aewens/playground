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
            h = width / 16 * 9
            w = height * 16 / 9
            
            # if height > h
            #     @$c.css("width", width)
            #     @$c.css("height", h)
            # else if width > w
            #     @$c.css("width", w)
            #     @$c.css("height", height)
            @$c.css("width", width)
            @$c.css("height", height)
            $root.append(c)
        destroy: ->
            console.log "Stopping canvas..."
            @$c.remove() if @$c
