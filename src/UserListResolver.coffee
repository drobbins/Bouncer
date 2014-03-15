angular.module "Bouncer"
    .factory "UserListResolver", (Bouncer) ->
        () ->
            Users = Bouncer.users()
            Users.query().$promise
