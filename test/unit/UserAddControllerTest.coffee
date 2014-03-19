describe "UserAddController", ->
    $scope = UserAddController = stub = null

    beforeEach ->
        stub = sinon.stub()
        module "Bouncer"
        module
            Bouncer:
                users: ->
                    save: stub
        inject ($rootScope, $controller) ->
            $scope = $rootScope.$new()
            UserAddController = $controller "UserAddController",
                $scope: $scope

    it "Provides a function to add a user", ->
        $scope.addUser
            username: "TestBob"
            password: "TestPass"
        stub.should.have.been.called

