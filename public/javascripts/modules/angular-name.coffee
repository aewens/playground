define [
    "corejs"
], (Core) ->
    Core.register "angular-name", (sandbox) ->
        init: ->
            console.log "Starting angular-name..."

            angular = sandbox.use("angular")
            @destroy() unless angular

            app = angular.module("angular-name", [])
            app.controller "NameCtrl", ($scope) ->
                $scope.fname = "Austin"
                $scope.lname = "Ewens"
                $scope.name  = $scope.fname + " " + $scope.lname

                $scope.updateName = ->
                    $scope.name = $scope.fname + " " + $scope.lname

            angular.bootstrap(@el, ["angular-name"])
        destroy: ->
            console.log "Stopping angular-name..."
