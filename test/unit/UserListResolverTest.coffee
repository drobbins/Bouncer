describe "UserListResolver", () ->

    UserListResolver = {}

    beforeEach () ->
        angular.mock.module "Bouncer"

    it "Exists", () ->
        inject ($injector) ->
            UserListResolver = $injector.get "UserListResolver"
        UserListResolver.should.be.a "function"

    it "Requests list of users from BouncerService", () ->
        promisedValue = ["user1", "user2"]
        BouncerService = {}
        spy = sinon.stub().returns $promise: promisedValue
        inject ($injector) ->
            BouncerService = $injector.get "Bouncer"
            sinon.stub BouncerService, 'users'
                .returns
                    query: spy
            UserListResolver = $injector.get "UserListResolver"
        UserListResolver().should.equal promisedValue
        spy.should.have.been.called
