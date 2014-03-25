angular.module "Bouncer"
    .controller "CollectionAddController", ($scope, Bouncer) ->
        $scope.addCollection = (collection) ->
            Bouncer.collections collection
