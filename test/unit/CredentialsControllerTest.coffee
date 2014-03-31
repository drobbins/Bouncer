describe "Credentials Controller", ->

    Bounce = CredentialsController = $scope = null
    credentials =
        username: "test"
        password: "test123"
        deployment: "http://bounce.example.com"

    beforeEach module "Bouncer"

    beforeEach ->
        inject (_Bounce_, $controller, $rootScope) ->
            Bounce = _Bounce_
            $scope = $rootScope.$new()
            CredentialsController = $controller "CredentialsController", $scope: $scope

    it "Exists", ->
        CredentialsController.should.exist

    it "Provides default deployment", ->
        expect($scope.credentials.username).to.be.undefined
        expect($scope.credentials.deployment).to.equal "http://localhost:27080"

    it "Exposes set credentials", ->
        $privateScope = { $on: -> }
        Bounce.credentials credentials
        inject ($controller) ->
            $controller "CredentialsController", $scope: $privateScope
            $privateScope.credentials.username.should.equal credentials.username
            $privateScope.credentials.deployment.should.equal credentials.deployment

    it "Provides a function for setting credentials", ->
        $scope.setCredentials credentials
        savedCredentials = Bounce.credentials()
        savedCredentials.username.should.equal credentials.username
        savedCredentials.deployment.should.equal credentials.deployment

    it "Updates $scope.credentials on bouncer.credentialsUpdated events", ->
        expect($scope.credentials.username).to.be.undefined
        expect($scope.credentials.deployment).to.equal "http://localhost:27080"
        Bounce.credentials credentials
        $scope.credentials.username.should.equal credentials.username
        $scope.credentials.deployment.should.equal credentials.deployment
