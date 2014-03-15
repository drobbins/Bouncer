describe "UserListController", () ->

    scope = {}
    UserListController = {}
    users = ["user1", "user2"]

    beforeEach () ->
        angular.mock.module "Bouncer"
        inject ($injector, $controller) ->
            scope = $injector.get "$rootScope"
            UserListController = $controller "UserListController",
                $scope: scope
                users: users

    it "Exists", () ->
        expect UserListController
            .not.to.equal null

    it "Places resolved users on the $scope", () ->
        scope.users.should.equal users
