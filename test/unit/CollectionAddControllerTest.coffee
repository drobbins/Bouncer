describe "CollectionAddController", ->
    $scope = CollectionAddController = stub = null

    beforeEach ->
        stub = sinon.stub()
        module "Bouncer"
        module
            Bouncer:
                collections: stub
        inject ($rootScope, $controller) ->
            $scope = $rootScope.$new()
            CollectionAddController = $controller "CollectionAddController",
                $scope: $scope

    it "Provides a function to add a collection", ->
        $scope.addCollection
            name: "mycollection"
        stub.should.have.been.called
