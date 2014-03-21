angular.module "Bouncer"
    .constant "BouncerResolvers",
        userListResolver: (Bouncer) ->
            Bouncer.users().query().$promise
