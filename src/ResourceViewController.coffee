angular.module "Bouncer"
    .controller "ResourceViewController", ($scope, resource) ->
        $scope.resource = resource
