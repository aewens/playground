require.config
    # urlArgs: "nocache=" + (new Date).getTime()
    paths:
        "jquery": ["//cdnjs.cloudflare.com/ajax/libs/jquery/2.2.0/jquery.min", "../vendor/jquery/dist/jquery.min"]
        "corejs": "../vendor/core_js/dist/core.min"
        "firebase": ["//cdn.firebase.com/js/client/2.4.1/firebase", "../vendor/firebase/firebase"]
        "angular":  ["//ajax.googleapis.com/ajax/libs/angularjs/1.5.0/angular.min" ,"../vendor/angular/angular.min"]
        "ng-route": ["//ajax.googleapis.com/ajax/libs/angularjs/1.5.0/angular-route.min", "../vendor/angular-route/angular-route.min"]
        "hammerjs": "../vendor/Materialize/js/hammer.min" # Materialize dep
        "material": ["//cdnjs.cloudflare.com/ajax/libs/materialize/0.97.5/js/materialize.min" ,"../vendor/Materialize/bin/materialize"]
    shim:
        "firebase":
            exports: "Firebase"
        "angular":
            exports: "angular"
        "ng-route":
            deps: ["angular"]
        "material":
            deps: ["jquery", "hammerjs"]

require [
    "jquery",
    "firebase",
    "corejs",
    "angular",
    "material",
    "modules/database",
    "modules/dispatcher",
    "modules/angular-test"
], (jQuery, Firebase, Core, Angular, Material,
    mod_database, mod_dispatcher, mod_angular_test) ->
    Core.extend("$", jQuery)
    Core.extend("db-api", Firebase)
    Core.extend("angular", Angular)
    Core.extend("material", Material)
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
                Core.start("angular-test")
                $(".delay").show()

                # Get config data from dispatcher module
                sandbox.listen("config-data", self.configure)
        configure: (@config) ->
            console.log "Obtained config data..."
        destroy: ->
            # Stop everything
            console.log "Stopping main..."

    Core.start("main")
