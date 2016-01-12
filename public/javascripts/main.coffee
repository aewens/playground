require.config
    urlArgs: "nocache=" + (new Date).getTime()
    paths:
        "jquery": "../vendor/jquery/dist/jquery.min"
        "corejs": "../vendor/core_js/dist/core.min"
        "firebase": "../vendor/firebase/firebase"
    shim:
        "firebase":
            exports: "Firebase"

require [
    "jquery",
    "firebase",
    "corejs",
    "modules/canvas",
    "modules/draw",
    "modules/database",
    "modules/dispatcher"
], (jQuery, Firebase, Core, mod_canvas,
    mod_draw, mod_database, mod_dispatcher) ->
    Core.extend("$", jQuery)
    Core.extend("db-api", Firebase)
    Core.register "main", (sandbox) ->
        init: ->
            console.log "Starting main..."
            self = @
            # Scope of this/@ is now jQuery, not the main module
            # Use self instead
            sandbox.use("$")(document).ready ->
                # Start cores here
                Core.start("canvas")
                Core.start("draw")
                Core.start("database")
                Core.start("dispatcher")

                # Get config data from dispatcher module
                sandbox.listen("config-data", self.configure)
        configure: (@config) ->
            console.log "Obtained config data..."
        destroy: ->
            # Stop everything
            console.log "Stopping main..."

    Core.start("main")
