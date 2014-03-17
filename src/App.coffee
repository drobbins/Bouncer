angular.module "Bouncer", ["ngResource", "ui.router"]
    .config ($stateProvider, $urlRouterProvider) ->
        $urlRouterProvider.otherwise "/"
        $stateProvider
            .state "UserList",
                url: "/users"
                template: "Hello World"
                controller: "UserListController"
                resolve:
                    users: "UserListResolver"
