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
                        searches = "?"
                        searches += "#{k}=#{v}&" for k,v of search
                        searches = searches.slice(0,-1)

                        value = routeParams.value

                        window.location = "api/v0.1/test/#{value}#{searches}"
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

            angular.bootstrap($("#index"), ["dashboard"])
        destroy: ->
            console.log "Stopping dashboard..."
