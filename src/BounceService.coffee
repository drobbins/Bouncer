angular.module "Bouncer"
    .factory "Bounce", ($rootScope, $window) ->

        credentials =
            deployment: "http://localhost:27080"

        db = null

        api =
            credentials: (_) ->
                if _
                    credentials = _
                    $rootScope.$broadcast "bouncer.credentialsUpdated", api.credentials
                    db = $window.bounce credentials
                    api
                else
                    username: credentials.username
                    deployment: credentials.deployment
            db: db
