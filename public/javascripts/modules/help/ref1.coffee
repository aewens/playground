define [
    "corejs"
], (Core) ->
    Core.register "ref1", (sandbox) ->
        init: ->
            sandbox.listen("new-message", @talk)
        talk: (data) ->
            console.log data
