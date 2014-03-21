angular.module "Bouncer"
    .controller "UserListController", ($scope, users) ->
        $scope.users = users
