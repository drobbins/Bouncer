describe "UserListController", ->

    $scope = UserListController = null
    users = ["user1", "user2"]

    beforeEach ->
        angular.mock.module "Bouncer"
        inject ($rootScope, $controller) ->
            #scope = $injector.get "$rootScope"
            $scope = $rootScope.$new()
            UserListController = $controller "UserListController",
                $scope: $scope
                users: users

    it "Places resolved users on the $scope", ->
        $scope.users.should.equal users
