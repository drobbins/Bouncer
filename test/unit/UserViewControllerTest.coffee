describe "UserViewController", ->

    $scope = UserViewController = null
    user = username: "UserMcUser"

    beforeEach ->
        module "Bouncer"
        inject ($rootScope, $controller) ->
            $scope = $rootScope.$new()
            UserViewController = $controller "UserViewController",
                $scope: $scope
                user: user

    it "places resolved users on the $scope", ->
        $scope.user.should.equal user
