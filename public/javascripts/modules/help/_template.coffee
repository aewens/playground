define [
    "corejs"
], (Core) ->
    Core.register "_mod_", (sandbox) ->
        init: ->
            console.log "Starting _mod_..."
        destroy: ->
            console.log "Stopping _mod_..."
