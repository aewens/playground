// Generated by CoffeeScript 1.10.0
(function() {
  define(["corejs"], function(Core) {
    return Core.register("angular-test", function(sandbox) {
      return {
        init: function() {
          var angular, app;
          console.log("Starting angular-test...");
          angular = sandbox.use("angular");
          if (!angular) {
            this.destroy();
          }
          app = angular.module("angular-test", []);
          app.controller("TestCtrl", function($scope) {
            $scope.fname = "Austin";
            $scope.lname = "Ewens";
            $scope.name = $scope.fname + " " + $scope.lname;
            return $scope.updateName = function() {
              return $scope.name = $scope.fname + " " + $scope.lname;
            };
          });
          return angular.bootstrap(document, ["angular-test"]);
        },
        destroy: function() {
          return console.log("Stopping angular-test...");
        }
      };
    });
  });

}).call(this);
