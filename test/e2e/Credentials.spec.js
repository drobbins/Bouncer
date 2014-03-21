describe("Credentials", function () {
    it("", function () {});
    it("Displays no credentials on initial load.", function () {
        browser.get("/");
        expect($(".navbar-right li a").getText()).toBe("Credentials");
    });
    it("Displays credentials after they are input", function () {
        var username = "TestBob";
        browser.get("/#/credentials");
        element(by.model("credentials.username")).sendKeys(username);
        $("[type=submit]").click();
        expect($(".navbar-right li a").getText()).toBe(username);
    });
});
