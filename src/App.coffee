try
    angular.module "BouncerTemplates"
catch
    angular.module "BouncerTemplates", []

angular.module "Bouncer", ["ngResource", "ui.router", "BouncerTemplates"]
    .config ($stateProvider, $urlRouterProvider) ->
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
                    users: "UserListResolver"
