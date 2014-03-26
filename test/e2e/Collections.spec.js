describe("The collections UI", function () {
    beforeEach(function () {
        browser.get("/#/credentials");
        element(by.model("credentials.username")).sendKeys("TestBob");
        element(by.model("credentials.password")).sendKeys("password");
        $("[type=submit]").click();
        $(".navbar-brand").click(); //browser.get("/#/"); reloads the page.
    });

    it("renders an empty list of collections if there are none.", function () {
        var collections;
        collections = element.all(by.repeater("collection in collections._embedded.collections"));
        expect(collections.count()).toBe(0);
    });

    it("allows adding a collection.", function () {
        var collectionName = "MyTestCollection";
        $("[ui-sref=CollectionAdd]").click();
        element(by.model("collection.name")).sendKeys(collectionName);
        $("[type=submit]").click(); //Returns to collection list
        expect(element(by.repeater("collection in collections._embedded.collections").row(0).column("collection.name")).getText()).toBe(collectionName);
    });

    it("allows removing a collection.", function () {
        $("[title=\"Remove this collection\"]").click();
        expect(element.all(by.repeater("collection in collections._embedded.collections")).count()).toBe(0);
    });
});
