angular.module "Bouncer"
    .controller "ResourceViewController", ($scope, resource) ->
        $scope.resource = resource
        $scope.resourceType = switch $scope.resource._links?.self.href.split("/").length
            when 0 then "deployment"
        console.log $scope.resourceType
