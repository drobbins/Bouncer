angular.module "Bouncer"
    .controller "CollectionAddController", ($scope, Bouncer, $state) ->
        $scope.addCollection = (collection) ->
            Bouncer.collections().save collection, -> $state.go "CollectionList"
