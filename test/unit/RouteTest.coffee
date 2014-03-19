describe "Bouncer Routes", ->

    BouncerResolvers = $state = null

    beforeEach module "Bouncer" #equivalent to angular.mock.module "Bouncer"

    beforeEach inject (_$state_, _BouncerResolvers_) ->
        $state = _$state_
        BouncerResolvers = _BouncerResolvers_

    # Early attempt at stubbing out controller and resolver...didn't work out.
    xit "UserList Route", (done) ->
        controllerStub = sinon.stub()
        resolverStub = sinon.stub()
        $state = tick = null
        module ($controllerProvider) ->
            $controllerProvider.register "UserListController", controllerStub
        module ($provide) ->
            $provide.constant "BouncerResolvers",
                userListResolver: resolverStub
        inject (_$state_, $q, BouncerResolvers) ->
            $state = _$state_
            tick = $q.flush
            BouncerResolvers.userListResolver.should.equal resolverStub
        $state.go "UserList"
            .then ->
                controllerStub.should.have.been.called
                resolverStub.should.have.been.called
                expect(true).to.equal false
                done()
        tick()

    it "UserList Route", ->
        userListRoute = $state.get "UserList"
        userListRoute.controller.should.equal "UserListController"
        userListRoute.resolve.users.should.equal BouncerResolvers.userListResolver

    it "UserAdd Route", ->
        userAddRoute = $state.get "UserAdd"
        userAddRoute.controller.should.equal "UserAddController"

