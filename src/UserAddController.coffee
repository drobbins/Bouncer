angular.module "Bouncer"
    .controller "UserAddController", ($scope, Bouncer, $state) ->
        $scope.addUser = (user) ->
            Bouncer.users().save(user, -> $state.go "UserList")
