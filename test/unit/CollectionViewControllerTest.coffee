describe "CollectionViewController", ->

    $scope = CollectionViewController = null
    collection = name: "CollectionMcCollection"

    beforeEach ->
        angular.mock.module "Bouncer"
        inject ($rootScope, $controller) ->
            $scope = $rootScope.$new()
            CollectionViewController = $controller "CollectionViewController",
                $scope: $scope
                collection: collection

    it "Places resolved collections on the $scope", ->
        $scope.collection.should.equal collection
