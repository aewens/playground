define [
    "corejs"
], (Core) ->
    Core.register "ref2", (sandbox) ->
        init: ->
            console.log "Hello, world!"
            @talk()
        talk: ->
            sandbox.notify
                type: "new-message"
                data:
                    name: "aewens"
                    text: "he does things"
        destroy: ->
            console.log "Farewell, world."
