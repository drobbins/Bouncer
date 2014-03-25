angular.module "Bouncer"
    .controller "CollectionViewController", ($scope, collection) ->
        $scope.collection = collection
