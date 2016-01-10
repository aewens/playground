define [
    "corejs"
], (Core) ->
    Core.register "draw", (sandbox) ->
        init: ->
            console.log "Starting draw..."
            canvas = sandbox.use("$")("canvas")[0]
            @destroy() unless !!canvas

            @ctx = canvas.getContext("2d")
        destroy: ->
            console.log "Stopping draw..."
