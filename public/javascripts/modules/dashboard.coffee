define [
    "corejs",
    "ng-route"
], (Core, ng_route) ->
    Core.register "dashboard", (sandbox) ->
        init: ->
            console.log "Starting dashboard..."

            # Destroy if angular doesn't exist
            angular = sandbox.use("angular")
            @destroy() unless angular

            # Make the module
            app = angular.module("dashboard", ["ngRoute"])

            app.config ($routeProvider) ->
                $routeProvider
                .when "/",
                    templateUrl: "dashboard.html"
                    controller: "DashboardCtrl"
                .otherwise
                    templateUrl: "otherwise.html"

            app.controller "DashboardCtrl", ($scope) ->


            # Bootstrap module to the document
            angular.bootstrap(document, ["dashboard"])
        destroy: ->
            console.log "Stopping dashboard..."
