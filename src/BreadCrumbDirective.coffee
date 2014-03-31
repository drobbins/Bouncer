angular.module "Bouncer"
    .directive "bouncerBreadCrumbs", ->
        restrict: "E"
        templateUrl: "templates/breadcrumbs.html"
        scope:
            resource: "=resource"
        controller: ($scope, $element, $attrs) ->
            $scope.breadcrumbs = $scope.resource._links.self.href.split("/").map (value, index, array) ->
                title = ""
                switch index
                    when 0 then title = "Deployment"
                    when 1 then title = "Collection"
                    when 2 then title = "Document"
                    when 3 then title = "Field"
                resource = if index > 0 then array[0..index].join "/" else "/"
                breadcrumb =
                    title: title
                    resource: resource
                    name: value or "Deployment"
