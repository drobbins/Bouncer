describe "Unit Tests for BouncerService", () ->

  # Various test data
    collection =
        name: "myCollection"
    credentials =
        username: "test"
        password: "abc123"
        endpoint: "http://localhost:27080"
    document =
        id: "123"

  # Holders for injected items
    Bouncer = {}
    httpBackend = {}
    documents = {}

  # Convenience Functions
    headersCheck = (headers) ->
        headers["Authorization"] == "Basic #{btoa(credentials.username + ":" + credentials.password)}"

    beforeEach angular.mock.module "Bouncer"

    it "Existence", inject (Bouncer) ->
        expect Bouncer
            .not.to.equal(null)

    it "Get/Set Credentials", inject (Bouncer) ->
        credentials =
            username: "test"
            password: "abc123"
            endpoint: "http://localhost:27080"
        Bouncer.credentials credentials
        retrievedCredentials = Bouncer.credentials()
        retrievedCredentials.should.not.to.have.ownProperty "password" # Don't return password
        retrievedCredentials.username.should.equal credentials.username
        retrievedCredentials.endpoint.should.equal credentials.endpoint

    describe "Collections API", () ->

        beforeEach inject ($injector) ->
            httpBackend = $injector.get "$httpBackend"
            Bouncer = $injector.get "Bouncer"
            Bouncer.credentials credentials

        afterEach () ->
            httpBackend.verifyNoOutstandingExpectation()
            httpBackend.verifyNoOutstandingRequest()

        it "Get Collections", () ->
            httpBackend.expect "GET", credentials.endpoint, null, headersCheck
                .respond 200
            Bouncer.collections()
            httpBackend.flush()

        it "Add Collection", () ->
            httpBackend.expect "POST", credentials.endpoint, collection, headersCheck
                .respond 201
            Bouncer.collections(collection)
            httpBackend.flush()

        it "Get a Collection", () ->
            col = Bouncer.collection(collection.name)
            col.stats.should.be.a "Function"

        it "Collection Stats", () ->
            httpBackend.expect "GET", "#{credentials.endpoint}/#{collection.name}", null, headersCheck
                .respond 200
            col = Bouncer.collection(collection.name)
            col.stats()
            httpBackend.flush()

        it "Update Collection", () ->
            collection =
                name: "mycollection"
            httpBackend.expect "PUT", "#{credentials.endpoint}/#{collection.name}", collection, headersCheck
                .respond 201
            Bouncer.updateCollection(collection)
            httpBackend.flush()

    describe "Documents API", () ->

        beforeEach inject ($injector) ->
            httpBackend = $injector.get "$httpBackend"
            Bouncer = $injector.get "Bouncer"
            Bouncer.credentials credentials
            documents = Bouncer.collection(collection.name)

        afterEach () ->
            httpBackend.verifyNoOutstandingExpectation()
            httpBackend.verifyNoOutstandingRequest()

        it "Query Collection", () ->
            query = {}
            httpBackend.expect "POST", "#{credentials.endpoint}/#{collection.name}/query", query, headersCheck
                .respond 200, []
            docs = documents.query query, () ->
                docs.length.should.equal 0
            httpBackend.flush()

        it "Get document", () ->
            httpBackend.expect "GET", "#{credentials.endpoint}/#{collection.name}/#{document.id}", null, headersCheck
                .respond 200, {}
            doc = documents.get document, () ->
                doc.should.exist
            httpBackend.flush()
