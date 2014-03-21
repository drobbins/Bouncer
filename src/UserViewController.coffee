angular.module "Bouncer"
    .controller "UserViewController", ($scope, user) ->
        $scope.user = user
