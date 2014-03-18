describe("hello-protractor", function () {
    describe("index", function () {
        it("Title", function () {
            browser.get("/#");
            expect(browser.getTitle()).toBe("Bouncer is Bouncing");
        });
        it("Brand", function () {
            browser.get("/#");
            expect($(".navbar-brand").getText()).toBe("Bouncer");
        });
    });
});
