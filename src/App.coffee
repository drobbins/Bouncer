try
    angular.module "BouncerTemplates"
catch
    angular.module "BouncerTemplates", []

angular.module "Bouncer", ["ngResource", "ui.router", "BouncerTemplates"]
    .config ($stateProvider, $urlRouterProvider, BouncerResolvers) ->
        $urlRouterProvider.otherwise "/"
        $stateProvider
            .state "UserList",
                url: "/users"
                templateUrl: "templates/userlist.html"
                controller: "UserListController"
                resolve:
                    users: BouncerResolvers.userListResolver
            .state "UserAdd",
                url: "/users/new"
                templateUrl: "templates/useradd.html"
                controller: "UserAddController"
            .state "UserView",
                url: "/users/:username"
                templateUrl: "templates/userview.html"
                controller: "UserViewController"
                resolve:
                    user: BouncerResolvers.userResolver
            .state "Credentials",
                url: "/credentials"
                templateUrl: "templates/credentials.html"
                controller: "CredentialsController"
            .state "CollectionAdd",
                url: "/new"
                templateUrl: "templates/collectionadd.html"
                controller: "CollectionAddController"
            .state "CollectionList",
                url: "/"
                templateUrl: "templates/collectionlist.html"
                controller: "CollectionListController"
                resolve:
                    collections: BouncerResolvers.collectionListResolver
            .state "CollectionView",
                url: "/:name"
                templateUrl: "templates/collectionview.html"
                controller: "CollectionViewController"
                resolve:
                    collection: BouncerResolvers.collectionResolver
    .run ($state, $stateParams) ->
        # Fix for https://github.com/angular-ui/ui-router/issues/582
        $state.reload =  -> $state.transitionTo $state.current, angular.copy($stateParams),
            reload: true
            inherit: true
            notify: true
