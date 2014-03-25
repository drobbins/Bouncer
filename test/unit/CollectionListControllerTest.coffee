describe "CollectionListController", ->

    $scope = CollectionListController = null
    collections = ["collection1", "collection2"]

    beforeEach ->
        angular.mock.module "Bouncer"
        inject ($rootScope, $controller) ->
            $scope = $rootScope.$new()
            CollectionListController = $controller "CollectionListController",
                $scope: $scope
                collections: collections

    it "Places resolved collections on the $scope", ->
        $scope.collections.should.equal collections
