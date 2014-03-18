angular.module "Bouncer"
    .controller "CredentialsController", ($scope, Bouncer) ->
        $scope.credentials = Bouncer.credentials()
        $scope.setCredentials = Bouncer.credentials
