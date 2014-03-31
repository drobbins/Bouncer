angular.module "Bouncer"
    .controller "CredentialsController", ($scope, Bounce) ->
        $scope.credentials = Bounce.credentials()
        $scope.setCredentials = (credentials) ->
            Bounce.credentials credentials
        $scope.$on "bouncer.credentialsUpdated", (event,credentials) ->
            $scope.credentials = credentials
