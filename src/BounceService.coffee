angular.module "Bouncer"
    .factory "Bounce", ($rootScope, $window, $q) ->

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
            db: -> db
            getResource: (resource) ->
                def = $q.defer()
                db.getResource resource, (err, results) ->
                    if err? then def.reject err else def.resolve results
                def.promise
            updateResource: (resource, body) ->
                def = $q.defer()
                db.updateResource resource, body, (err, results) ->
                    if err? then def.reject err else def.resolve results
                def.promise
            utils:
                makePromise: (fn, args...) ->
                    def = $q.defer()
                    args.push (err, results) ->
                        if err? then def.reject err else def.resolve results
                    fn.apply @, args
                    def.promise
