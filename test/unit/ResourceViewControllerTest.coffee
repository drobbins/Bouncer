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

    it "identifies the type of resource for deployments.", inject ($controller) ->
        scope = {}
        resource =
            _links: self: href: "/"
        $controller "ResourceViewController",
            $scope: scope
            resource: resource
        scope.resourceType.should.equal "deployment"

