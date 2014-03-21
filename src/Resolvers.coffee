angular.module "Bouncer"
    .constant "BouncerResolvers",
        userListResolver: (Bouncer) ->
            Bouncer.users().query().$promise
        userResolver: ($stateParams, Bouncer) ->
            Bouncer.users().get(id: $stateParams.username).$promise
