describe "CollectionListController", ->

    $scope = CollectionListController = null
    collections = ["collection1", "collection2"]

    beforeEach ->
        module "Bouncer"
        inject ($rootScope, $controller) ->
            $scope = $rootScope.$new()
            CollectionListController = $controller "CollectionListController",
                $scope: $scope
                collections: collections

    it "places resolved collections on the $scope", ->
        $scope.collections.should.equal collections

    it "provides a function for deleting collections", ->
        stub = sinon.stub()
        inject (Bouncer) ->
            sinon.stub Bouncer, "collection"
                .returns
                    remove: stub
        $scope.removeCollection "mycollection"
        stub.should.have.been.called
