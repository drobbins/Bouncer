angular.module "Bouncer"
.service "Bouncer", ($http, $resource) ->
    credentials = {}
    api =
        credentials: (_) ->
            if _
                credentials = _
                $http.defaults.headers.common.Authorization = "Basic #{btoa(credentials.username + ":" + credentials.password)}"
                api
            else
                username: credentials.username
                endpoint: credentials.endpoint
        collections: (collection) ->
            if collection
                $http.post credentials.endpoint, collection
            else
                $http.get credentials.endpoint
        collection: (collection) -> # Get a collection resource
            col = $resource "#{credentials.endpoint}/#{collection}/:id", null,
                stats:
                    method: "GET"
                query:
                    method: "POST"
                    isArray: true
                    params:
                        id: "query"
        updateCollection: (collection) ->
            $http.put "#{credentials.endpoint}/#{collection.name}", collection
