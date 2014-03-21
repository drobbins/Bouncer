angular.module "Bouncer"
    .controller "CredentialsController", ($scope, Bouncer) ->
        $scope.credentials = Bouncer.credentials()
        $scope.setCredentials = (credentials) ->
            Bouncer.credentials credentials
        $scope.$on "bouncer.credentialsUpdated", (event,credentials) ->
            $scope.credentials = credentials
