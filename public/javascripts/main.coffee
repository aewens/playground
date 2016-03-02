require.config
    urlArgs: "nocache=" + (new Date).getTime()
    paths:
        "jquery": ["//cdnjs.cloudflare.com/ajax/libs/jquery/2.2.0/jquery.min", "../vendor/jquery/dist/jquery.min"]
        "corejs": "../vendor/core_js/dist/core.min"
        "firebase": ["//cdn.firebase.com/js/client/2.4.1/firebase", "../vendor/firebase/firebase"]
        "angular":  ["//ajax.googleapis.com/ajax/libs/angularjs/1.5.0/angular.min" ,"../vendor/angular/angular.min"]
        "ng-route": ["//ajax.googleapis.com/ajax/libs/angularjs/1.5.0/angular-route.min", "../vendor/angular-route/angular-route.min"]
        "bootstrap": ["//maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min", "../vendor/bootstrap/dist/js/bootstrap.min"]
    shim:
        "firebase":
            exports: "Firebase"
        "angular":
            exports: "angular"
        "ng-route":
            deps: ["angular"]
        "bootstrap":
            deps: ["jquery"]

require [
    "jquery",
    "firebase",
    "corejs",
    "bootstrap",
    "angular",
    "modules/database",
    "modules/dispatcher",
    "modules/angular-learn"
], (jQuery, Firebase, Core, Bootstrap, Angular,
    mod_database, mod_dispatcher, mod_angular_learn) ->
    Core.extend("$", jQuery)
    Core.extend("db-api", Firebase)
    Core.extend("angular", Angular)
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
                Core.start("angular-learn")

                # So angular has time to load
                $("#ng-wait").hide ->
                    $(".ng-load").show()

                # Get config data from dispatcher module
                sandbox.listen("config-data", self.configure)
        configure: (@config) ->
            console.log "Obtained config data..."
        destroy: ->
            # Stop everything
            console.log "Stopping main..."

    Core.start("main")
