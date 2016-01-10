define [
    "corejs"
], (Core) ->
    Core.register "database", (sandbox) ->
        init: ->
            console.log "Starting database..."
            sandbox.listen("db-setup", @setup)
            sandbox.listen("db-act", @act)
        # name : String/URL
        setup: (data) ->
            console.log "Setting up database..."
            db = sandbox.use("db")
            @db = new db(data.name)
            self = @
            @db.on "value", (snapshot) ->
                self.snapshot = snapshot
        # mode : String, location : String, info : Object
        act: (data) ->
            unless !!@db
                console.log "Setup database first"
                return null
            console.log "Database is acting..."
            location = @db.child(data.location)
            switch data.mode
                when "set" then location.set(data.info)
                when "update" then location.update(data.info)
                when "push" then location.push(data.info)
                when "remove" then location.remove()
                else location.push(data.info)
        destroy: ->
            console.log "Stoping database..."
