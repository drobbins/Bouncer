describe "The Bounce service", ->

    # Bounce is the Angular Service that is part of Bouncer
    # bounce is the native JS client from https://github.com/agrueneberg/Bounce/tree/master/client/browser

    beforeEach module "Bouncer"

    Bounce = null
    beforeEach inject (_Bounce_) ->
        Bounce = _Bounce_

    it "exists.", inject (Bounce) ->
        Bounce.should.exist

    describe "manages credentials:", ->

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
            expect(Bounce.db()).to.be.null
            spy = sinon.spy $window, "bounce"
            Bounce.credentials credentials
            spy.should.have.been.calledWith credentials
            expect(Bounce.db()).not.to.be.null

    describe "provides a resource API:", ->

        db = null

        beforeEach ->
            db = Bounce.credentials(credentials).db()

        it "getResource wraps bounce.getResource in a promise.", -> #TODO Fewer assertions maybe?
            spy = sinon.spy db, "getResource"
            promise = Bounce.getResource "/"
            promise.then.should.be.a "function"
            spy.should.have.been.calledWith "/"
            spy.firstCall.args[0].should.equal "/"
            spy.firstCall.args[1].should.be.a "function"

        it "updateResource wraps bounce.updateResource in a promise", ->
            spy = sinon.spy db, "updateResource"
            promise = Bounce.updateResource "/", name: "NewName"
            promise.then.should.be.a "function"

    describe "provides a utility makePromise which", ->

        it "wraps a function call with one arg.", ->
            stub = sinon.stub()
            arg = "/"
            promise = Bounce.utils.makePromise stub, arg
            promise.then.should.be.a "function"
            stub.should.have.been.calledWith arg

        it "wraps a function call with two args.", ->
            stub = sinon.stub()
            arg1 = "/"
            arg2 = some: "Data"
            promise = Bounce.utils.makePromise stub, arg1, arg2
            promise.then.should.be.a "function"
            stub.should.have.been.calledWith arg1, arg2

        it "rejects on error.", inject ($rootScope) ->
            stub = sinon.stub().yields "There was an error"
            errorCallback = sinon.stub()
            promise = Bounce.utils.makePromise stub
            promise.then null, errorCallback
            $rootScope.$digest() # Promises in Angular are tied to the digest cycle
            errorCallback.should.have.been.called

        it "resolves on success", inject ($rootScope) ->
            stub = sinon.stub().yields null, "Here are your results!"
            successCallback = sinon.stub()
            promise = Bounce.utils.makePromise stub
            promise.then successCallback
            $rootScope.$digest() # Promises in Angular are tied to the digest cycle
            successCallback.should.have.been.called

    # Test Data
    credentials =
        username: "TestBob"
        password: "password"
        deployment: "http://localhost:27080"

