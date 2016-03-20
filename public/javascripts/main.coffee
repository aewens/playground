require.config
    urlArgs: "nocache=" + (new Date).getTime()
    paths:
        "jquery": ["//cdnjs.cloudflare.com/ajax/libs/jquery/2.2.0/jquery.min", "../vendor/jquery/dist/jquery.min"]
        "corejs": "../vendor/core_js/dist/core.min"
        "firebase": ["//cdn.firebase.com/js/client/2.4.1/firebase", "../vendor/firebase/firebase"]
        "bootstrap": ["//maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min", "../vendor/bootstrap/dist/js/bootstrap.min"]
    shim:
        "firebase":
            exports: "Firebase"
        "bootstrap":
            deps: ["jquery"]

require [
    "jquery",
    "firebase",
    "corejs",
    "bootstrap",
    "modules/database",
    "modules/dispatcher"
], (jQuery, Firebase, Core, Bootstrap,
    mod_database, mod_dispatcher) ->
    Core.extend("$", jQuery)
    Core.extend("db-api", Firebase)
    Core.register "main", (sandbox) ->
        init: ->
            console.log "Starting main..."
            self = @
            # Scope of this/@ is now jQuery, not the main module
            # Use self instead
            $ = sandbox.use("$")
            $(document).ready ->
                # Start cores here
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
