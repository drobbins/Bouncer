describe "CollectionAddController", ->
    $scope = CollectionAddController = stub = null

    beforeEach ->
        stub = sinon.stub()
        module "Bouncer"
        module
            Bouncer:
                collections: sinon.stub().returns save: stub
        inject ($rootScope, $controller) ->
            $scope = $rootScope.$new()
            CollectionAddController = $controller "CollectionAddController",
                $scope: $scope

    it "Provides a function to add a collection", ->
        collection = name: "mycollection"
        $scope.addCollection collection
        stub.should.have.been.calledWith collection
