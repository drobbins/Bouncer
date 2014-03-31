describe "Bouncer Routes:", ->

    BouncerResolvers = $state = null

    beforeEach module "Bouncer" #equivalent to angular.mock.module "Bouncer"

    beforeEach inject (_$state_, _BouncerResolvers_) ->
        $state = _$state_
        BouncerResolvers = _BouncerResolvers_

    it "List Users", ->
        userListRoute = $state.get "UserList"
        userListRoute.controller.should.equal "UserListController"
        userListRoute.resolve.users.should.equal BouncerResolvers.userListResolver

    it "Add User", ->
        userAddRoute = $state.get "UserAdd"
        userAddRoute.controller.should.equal "UserAddController"

    it "View User", ->
        userViewRoute = $state.get "UserView"
        userViewRoute.controller.should.equal "UserViewController"
        userViewRoute.resolve.user.should.equal BouncerResolvers.userResolver

    describe "Collection Routes", ->

        it "Add Collection", ->
            collectionAddRoute = $state.get "CollectionAdd"
            collectionAddRoute.controller.should.equal "CollectionAddController"

        it "List Collections", ->
            collectionListRoute = $state.get "CollectionList"
            collectionListRoute.controller.should.equal "CollectionListController"
            collectionListRoute.resolve.collections.should.equal BouncerResolvers.collectionListResolver

        it "View Collection", ->
            collectionViewRoute = $state.get "CollectionView"
            collectionViewRoute.controller.should.equal "CollectionViewController"
            collectionViewRoute.resolve.collection.should.equal BouncerResolvers.collectionResolver

    it "The ResourceView route", ->
        resourceViewRoute = $state.get "ResourceView"
        resourceViewRoute.controller.should.equal "ResourceViewController"
