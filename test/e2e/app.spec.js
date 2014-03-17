describe("hello-protractor", function () {
    describe("index", function () {
        it("Should display the correct title", function () {
            browser.get("/#");
            expect(browser.getTitle()).toBe("Bouncer is Bouncing");
        });
    });
});
