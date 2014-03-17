angular.module "ngMock"
    .config ($provide) ->
        $provide.decorator "$q", ($delegate, $rootScope) ->
            $delegate.flush = -> $rootScope.$digest()
            return $delegate
