describe "Resolvers", ->

    BouncerResolvers = Bouncer = invoke = null

    beforeEach module "Bouncer"

    beforeEach inject (_BouncerResolvers_, _Bouncer_, $injector) ->
        BouncerResolvers = _BouncerResolvers_
        Bouncer = _Bouncer_
        invoke = $injector.invoke

    testResolver = (resolver, resource, method, promisedValue) ->
        spy = sinon.stub().returns $promise: promisedValue
        returnObject = {}
        returnObject[method] = spy
        sinon.stub Bouncer, resource
            .returns returnObject
        resolvedValue = invoke BouncerResolvers[resolver]
        resolvedValue.should.equal promisedValue
        spy.should.have.been.called

    it "userListResolver requests list of users from Bouncer service", ->
        testResolver "userListResolver", "users", "query", ["user1", "user2"]

    it "userResolver requests an individual user from Bouncer service", ->
        testResolver "userResolver", "users", "get", { username: "TestBob" }

    it "collectionListResolver requests a list of collections from Bouncer service", ->
        testResolver "collectionListResolver", "collections", "query", { name: "MyCollection" }

    it "collectionResolver requests a collection from Bouncer service", ->
        testResolver "collectionResolver", "collection", "stats", { name: "MyCollection" }
