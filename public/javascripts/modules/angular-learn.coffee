define [
    "corejs"
], (Core) ->
    Core.register "angular-learn", (sandbox) ->
        init: ->
            console.log "Starting angular-learn..."

            angular = sandbox.use("angular")
            @destroy() unless angular

            app = angular.module("angular-learn", [])
            app.factory "Data", ->
                fname: "Austin"
                lname: "Ewens"
                name: "Austin Ewens"

            app.controller "NameCtrl", ($scope, Data) ->
                $scope.data = Data

                $scope.updateName = ->
                    name = $scope.data.fname + " " + $scope.data.lname
                    $scope.data.name = name

            app.controller "ReverseCtrl", ($scope, Data) ->
                $scope.data = Data

            angular.bootstrap(document, ["angular-learn"])
        destroy: ->
            console.log "Stopping angular-learn..."
