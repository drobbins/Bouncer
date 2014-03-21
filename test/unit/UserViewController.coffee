describe "UserViewController", ->

    $scope = UserViewController = null
    user = username: "UserMcUser"

    beforeEach ->
        angular.mock.module "Bouncer"
        inject ($rootScope, $controller) ->
            $scope = $rootScope.$new()
            UserViewController = $controller "UserViewController",
                $scope: $scope
                user: user

    it "Places resolved users on the $scope", ->
        $scope.user.should.equal user
