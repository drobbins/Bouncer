angular.module "Bouncer"
    .controller "CollectionListController", ($scope, collections, Bouncer, $state, $stateReloadFix) ->
        $scope.collections = collections
        $scope.removeCollection = (collection) ->
            Bouncer.collection(collection).remove -> $state.reload()
