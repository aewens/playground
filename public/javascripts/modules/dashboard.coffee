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

            app.controller "DataTestCtrl", ($scope) ->
                $scope.test = {}
                cache = $("#cache").attr("data-entries")
                $scope.test.entries = JSON.parse(cache) if cache
                # Get data from database for table
                fetchData = (data) ->
                    # Tell angular to apply changes
                    $scope.$apply ->
                        # Get snapshot of database
                        if data.snapshot
                            # `api/test` is database location
                            entries = data.snapshot.api.test
                            # Send entries to scope
                            $scope.test.entries = entries if entries
                            jEntries = JSON.stringify(entries)
                            $("#cache").attr("data-entries", jEntries)
                sandbox.listen("db-ready", fetchData) unless cache

            # Bootstrap module to the document
            angular.bootstrap(document, ["dashboard"])
        destroy: ->
            console.log "Stopping dashboard..."
