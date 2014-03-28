describe "The Bounce service", ->

    beforeEach module "Bouncer"

    it "exists.", inject (Bounce) ->
        Bounce.should.exist

    describe "manages credentials:", ->

        Bounce = bounce = null

        credentials =
            username: "TestBob"
            password: "password"
            deployment: "http://localhost:27080"

        beforeEach inject (_Bounce_, $window) ->
            Bounce = _Bounce_
            bounce = $window.bounce

        it "setting and getting (minus password) credentials.", ->
            Bounce.credentials credentials
            gotCredentials = Bounce.credentials()
            gotCredentials.username.should.equal credentials.username
            gotCredentials.deployment.should.equal credentials.deployment
            gotCredentials.should.not.have.property "password"

        it "broadcasting bouncer.credentialsUpdated when credentials are updated.", inject ($rootScope) ->
            listener = sinon.stub()
            $rootScope.$on "bouncer.credentialsUpdated", listener
            Bounce.credentials credentials
            listener.should.have.been.called

        it "creating a db with the provided credentials.", inject ($window) ->
            expect(Bounce.db).to.be.null
            spy = sinon.spy $window, "bounce"
            Bounce.credentials credentials
            spy.should.have.been.calledWith credentials
