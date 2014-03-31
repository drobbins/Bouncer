angular.module "Bouncer"
    .constant "BouncerResolvers",
        userListResolver: (Bouncer) ->
            Bouncer.users().query().$promise
        userResolver: ($stateParams, Bouncer) ->
            Bouncer.users().get(id: $stateParams.username).$promise
        collectionListResolver: (Bouncer) ->
            Bouncer.collections().query().$promise
        collectionResolver: ($stateParams, Bouncer) ->
            Bouncer.collection($stateParams.name).stats().$promise
        resourceResolver: ($stateParams, Bounce) ->
            Bounce.getResource($stateParams.resource)
