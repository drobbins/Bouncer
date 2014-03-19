describe "Credentials Controller", ->

    Bouncer = CredentialsController = $scope = null
    credentials =
        username: "test"
        password: "test123"
        endpoint: "http://bounce.example.com"

    beforeEach module "Bouncer"

    beforeEach ->
        inject (_Bouncer_, $controller, $rootScope) ->
            Bouncer = _Bouncer_
            $scope = $rootScope.$new()
            CredentialsController = $controller "CredentialsController", $scope: $scope

    it "Exists", ->
        CredentialsController.should.exist

    it "Exposes empty credentials", ->
        $scope.credentials.should.eql
            username: credentials.nothing
            endpoint: credentials.nothing

    it "Exposes set credentials", ->
        $privateScope = { $on: -> }
        Bouncer.credentials credentials
        inject ($controller) ->
            $controller "CredentialsController", $scope: $privateScope
            $privateScope.credentials.username.should.equal credentials.username
            $privateScope.credentials.endpoint.should.equal credentials.endpoint

    it "Provides a function for setting credentials", ->
        $scope.setCredentials credentials
        savedCredentials = Bouncer.credentials()
        savedCredentials.username.should.equal credentials.username
        savedCredentials.endpoint.should.equal credentials.endpoint

    it "Emits a bouncer.credentialsUpdated event when credentials are set", ->
        listener = sinon.stub()
        inject ($rootScope) ->
            $rootScope.$on "bouncer.credentialsUpdated", listener
            $scope.setCredentials credentials
            listener.should.have.been.called

    it "Updates $scope.credentials on bouncer.credentialsUpdated events", ->
        $scope.credentials.should.eql
            username: credentials.nothing
            endpoint: credentials.nothing
        Bouncer.credentials credentials
        $scope.credentials.username.should.equal credentials.username
        $scope.credentials.endpoint.should.equal credentials.endpoint
