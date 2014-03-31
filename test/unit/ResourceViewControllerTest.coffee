describe "ResourceViewController", ->

    $scope = ResourceViewController = null

    resource =
        name: "NewName"

    beforeEach ->
        module "Bouncer"
        inject ($rootScope, $controller) ->
            $scope = $rootScope.$new()
            ResourceViewController = $controller "ResourceViewController",
                $scope: $scope
                resource: resource

    it "maps the resolved resource onto the scope.", ->
        $scope.resource.should.equal resource
