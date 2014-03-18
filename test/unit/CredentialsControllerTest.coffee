describe "Credentials Controller", ->

    Bouncer = CredentialsController = null
    $scope = {}
    credentials =
        username: "test"
        password: "test123"
        endpoint: "http://bounce.example.com"

    beforeEach module "Bouncer"

    beforeEach ->
        inject (_Bouncer_, $controller) ->
            Bouncer = _Bouncer_
            CredentialsController = $controller "CredentialsController", $scope: $scope

    it "Exists", ->
        CredentialsController.should.exist

    it "Exposes empty credentials", ->
        $scope.credentials.should.eql
            username: credentials.nothing
            endpoint: credentials.nothing

    it "Exposes set credentials", ->
        $privateScope = {}
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
