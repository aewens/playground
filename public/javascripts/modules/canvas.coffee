define [
    "corejs"
], (Core) ->
    Core.register "canvas", (sandbox) ->
        init: ->
            console.log "Starting canvas..."
            @$c = sandbox.use("$")("canvas")
            width = window.innerWidth
            height = window.innerHeight
            @$c.css("width", width)
            @$c.css("height", height)
        destroy: ->
            console.log "Stoping canvas..."
            @$c.remove() if @$c
