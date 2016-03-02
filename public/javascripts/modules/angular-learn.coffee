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

            app.controller "FlipCtrl", ($scope, Data) ->
                $scope.data = Data
                $scope.flipNames = ->
                    $scope.data.name.split(" ").reverse().join(", ")

            app.filter "reverse", -> (text) ->
                 text.split("").reverse().join("")

            app.factory "Frameworks", ->
                web: [
                    {
                        name: "require"
                        lang: "js"
                    }
                    {
                        name: "core"
                        lang: "js"
                    }
                    {
                        name: "firebase"
                        lang: "js"
                    }
                    {
                        name: "bootstrap"
                        lang: "css"
                    }
                    {
                        name: "angular"
                        lang: "js"
                    }
                    {
                        name: "jquery"
                        lang: "js"
                    }
                    {
                        name: "rails"
                        lang: "ruby"
                    }
                    {
                        name: "jekyll"
                        lang: "ruby"
                    }
                    {
                        name: "django"
                        lang: "py"
                    }
                    {
                        name: "node"
                        lang: "js"
                    }
                    {
                        name: "flask"
                        lang: "py"
                    }
                    {
                        name: "express"
                        lang: "js"
                    }
                    {
                        name: "sinatra"
                        lang: "ruby"
                    }
                ]

            app.controller "FrameworkCtrl", ($scope, Frameworks) ->
                $scope.frameworks = Frameworks
                

            angular.bootstrap(document, ["angular-learn"])
        destroy: ->
            console.log "Stopping angular-learn..."
