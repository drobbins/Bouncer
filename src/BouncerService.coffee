angular.module "Bouncer"
.service "Bouncer", ($http, $resource, $rootScope) ->
    credentials =
        endpoint: "http://localhost:27080"
    api =
        credentials: (_) ->
            if _
                credentials = _
                $rootScope.$broadcast "bouncer.credentialsUpdated", api.credentials() # Strip out password
                $http.defaults.headers.common.Authorization = "Basic #{btoa(credentials.username + ":" + credentials.password)}"
                api
            else
                username: credentials.username
                endpoint: credentials.endpoint
        collections: ->
            $resource "#{credentials.endpoint}", null,
                query: # Bounce returns collectionlist as an Object
                    method: "GET"
                    isArray: false
        collection: (collection) -> # Get a collection resource
            col = $resource "#{credentials.endpoint}/#{collection}/:id/:field", null,
                stats:
                    method: "GET"
                query:
                    method: "POST"
                    isArray: true
                    params:
                        id: "query"
                update:
                    method: "PUT"
                    params:
                        id: "@id"
        updateCollection: (collection) ->
            $http.put "#{credentials.endpoint}/#{collection.name}", collection
        users: () ->
            $resource "#{credentials.endpoint}/bounce.users/:id", null,
                query: # Bounce returns userlist as an Object
                    method: "GET"
                    isArray: false
