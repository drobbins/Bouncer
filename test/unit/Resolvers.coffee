describe "Resolvers", ->

    BouncerResolvers = invoke = null

    beforeEach module "Bouncer"

    beforeEach inject (_BouncerResolvers_, $injector) ->
        BouncerResolvers = _BouncerResolvers_
        invoke = $injector.invoke

    describe "UserListResolver", () ->

        it "Requests list of users from BouncerService", () ->
            promisedValue = ["user1", "user2"]
            spy = sinon.stub().returns $promise: promisedValue
            inject (Bouncer) ->
                sinon.stub Bouncer, 'users'
                    .returns
                        query: spy
            resolved = invoke BouncerResolvers.userListResolver
            resolved.should.equal promisedValue
            spy.should.have.been.called
