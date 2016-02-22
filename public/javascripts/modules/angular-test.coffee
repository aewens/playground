define [
    "corejs"
], (Core) ->
    Core.register "angular-test", (sandbox) ->
        init: ->
            console.log "Starting angular-test..."

            angular = sandbox.use("angular")
            @destroy() unless angular

            app = angular.module("angular-test", [])
            app.controller "TestCtrl", ($scope) ->
                $scope.fname = "Austin"
                $scope.lname = "Ewens"
                $scope.name  = $scope.fname + " " + $scope.lname

                $scope.updateName = ->
                    $scope.name = $scope.fname + " " + $scope.lname

            angular.bootstrap(@el, ["angular-test"])
        destroy: ->
            console.log "Stopping angular-test..."
