define [
    "corejs"
], (Core) ->
    Core.register "angular-reverse", (sandbox) ->
        init: ->
            console.log "Starting angular-reverse..."

            angular = sandbox.use("angular")
            @destroy() unless angular

            app = angular.module("angular-reverse", [])
            app.controller "ReverseCtrl", ($scope) ->
                $scope.phrase = "esreveR"
                $scope.reverse = $scope.phrase.split("").reverse().join("")

                $scope.updateReverse = ->
                    $scope.reverse = $scope.phrase.split("").reverse().join("")

            angular.bootstrap(@el, ["angular-reverse"])
        destroy: ->
            console.log "Stopping angular-reverse..."
