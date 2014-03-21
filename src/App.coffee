try
    angular.module "BouncerTemplates"
catch
    angular.module "BouncerTemplates", []

angular.module "Bouncer", ["ngResource", "ui.router", "BouncerTemplates"]
    .config ($stateProvider, $urlRouterProvider, BouncerResolvers) ->
        $urlRouterProvider.otherwise "/"
        $stateProvider
            .state "Home",
                url: "/"
                template: ""
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
