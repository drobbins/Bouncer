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
                makePromise db.getResource, resource
            updateResource: (resource, body) ->
                makePromise db.updateResource, resource, body
            deleteResource: (resource) ->
                makePromise db.deleteResource, resource
            addResource: (resource, body, contentType) ->
                if contentType # Only applicable for blobs
                    makePromise db.addResource, resource, body, contentType
                else
                    makePromise db.addResource, resource, body
            queryResource: (resource, query) ->
                makePromise db.queryResource, resource, query
            getPermissions: (resource) ->
                makePromise db.getPermissions, resource
            updatePermissions: (resource, body) ->
                makePromise db.updatePermissions, resource, body
            utils:
                makePromise: (fn, args...) ->
                    def = $q.defer()
                    args.push (err, results) ->
                        if err? then def.reject err else def.resolve results
                    fn.apply @, args
                    def.promise

        makePromise = api.utils.makePromise

        api
