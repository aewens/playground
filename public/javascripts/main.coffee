require.config
    urlArgs: "nocache=" + (new Date).getTime()
    paths:
        "jquery": "../vendor/jquery/dist/jquery.min"
        "corejs": "../vendor/corejs/core.min"
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
    "modules/database"
], (jQuery, Firebase, Core, mod_canvas, mod_draw, mod_database) ->
    Core.extend("$", jQuery)
    Core.extend("db", Firebase)
    Core.register "main", (sandbox) ->
        init: ->
            console.log "Starting main..."
            $ = sandbox.use("$")
            self = @
            $(document).ready ->
                # Start cores here
                Core.start("canvas")
                Core.start("draw")
                Core.start("database")

                # Get config data
                $.get "javascripts/config.json", (config) ->
                    self.config = config

                    # Setup database
                    sandbox.notify
                        type: "db-setup"
                        data:
                            name: self.config.db

                    # Test db-act by pushing the time
                    db_time = ->
                        sandbox.notify
                            type: "db-act"
                            data:
                                mode: "push"
                                location: "time"
                                info:
                                    now: Date.now()

                    # Ensure that database is ready
                    self.delay(db_time, 1000)
        delay: (func, time) ->
            setTimeout(func, time)
        destroy: ->
            # Stop everything
            console.log "Stopping main..."

    Core.start("main")
