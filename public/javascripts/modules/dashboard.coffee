define [
    "corejs",
    "ng-route",
    "ng-fire"
], (Core, ng_route, ng_fire) ->
    Core.register "dashboard", (sandbox) ->
        init: ->
            console.log "Starting dashboard..."

            sandbox.listen("config-data", @runDashboard)
        runDashboard: (data) ->
            # Firebase href
            href = data.config.db

            # Destroy if angular doesn't exist
            angular = sandbox.use("angular")
            @destroy() unless angular

            # Make the module
            app = angular.module("dashboard", ["ngRoute", "firebase"])

            # Routes manager
            app.config ($routeProvider) ->
                $routeProvider
                .when "/",
                    templateUrl: "dashboard.html"
                .when "/api/v0.1/test/:value",
                    redirectTo: (routeParams, path, search) ->
                        value = routeParams.value
                        # Version is located in 3rd spot
                        version = path.split("/")[2]
                        # Send data to database in push mode to `api/test`
                        sandbox.notify
                            type: "db-act"
                            data:
                                mode: "push"
                                location: "api/test"
                                info:
                                    value: routeParams.value
                                    version: version
                                    search: search
                        console.log value, version, search
                        # Return to sender
                        return "/"
                .when "/data/test",
                    templateUrl: "datatest.html"
                    controller: "DataTestCtrl"
                .otherwise
                    templateUrl: "otherwise.html"

            app.factory "testEntries", ($firebaseArray) ->
                ref = new Firebase(href + "api/test")
                $firebaseArray(ref)

            app.controller "DataTestCtrl", ($scope, testEntries) ->
                $scope.test =
                    entries: testEntries

            # Bootstrap module to the document
            angular.bootstrap(document, ["dashboard"])
        destroy: ->
            console.log "Stopping dashboard..."
