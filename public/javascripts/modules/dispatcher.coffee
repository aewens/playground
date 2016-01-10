define [
    "corejs"
], (Core) ->
    Core.register "dispatcher", (sandbox) ->
        init: ->
            console.log "Starting dispatcher..."
            self = @

            # Get config data
            sandbox.use("$").get "javascripts/config.json", (config) ->
                self.config = config

                # Let other modules use config
                sandbox.notify
                    type: "config-data"
                    data:
                        config: self.config

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
            console.log "Stopping dispatcher..."
