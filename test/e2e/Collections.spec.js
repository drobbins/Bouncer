describe("Collections", function () {
    beforeEach(function () {
        browser.get("/#/credentials");
        element(by.model("credentials.username")).sendKeys("TestBob");
        element(by.model("credentials.password")).sendKeys("password");
        $("[type=submit]").click();
    });

    it("Empty List of Collections", function () {
        var collections;
        browser.get("/#/");
        collections = element.all(by.repeater("collection in collections._embedded.collections"));
        expect(collections.count()).toBe(0);
    });
});
