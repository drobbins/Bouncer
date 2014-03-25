angular.module "Bouncer"
    .controller "CollectionListController", ($scope, collections) ->
        $scope.collections = collections
