angular.module "Bouncer"
    .constant "BouncerResolvers",
        userListResolver: (Bouncer) ->
            Users = Bouncer.users()
            Users.query().$promise
