describe "Bouncer Routes", ->

    $state = null

    beforeEach module "Bouncer" #equivalent to angular.mock.module "Bouncer"

    beforeEach inject (_$state_) -> $state = _$state_

    # Early attempt at stubbing out controller and resolver...didn't work out.
    xit "UserList Route", (done) ->
        controllerStub = sinon.stub()
        resolverStub = sinon.stub()
        $state = tick = null
        module ($controllerProvider) ->
            $controllerProvider.register "UserListController", controllerStub
        module
            UserListResolver: resolverStub
        inject (_$state_, $q) ->
            $state = _$state_
            tick = $q.flush
        $state.go "UserList"
            .then ->
                controllerStub.should.have.been.called
                resolverStub.should.have.been.called
                expect(true).to.equal false
                done()
        tick()

    xit "UserList Route", ->
        userListRoute = $state.get "UserList"
        userListRoute.controller.should.equal "UserListController"
        userListRoute.resolve.users.should.equal "UserListResolver"

