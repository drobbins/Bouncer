describe("UserList", function () {
    it("Highlights the correct browser tab", function () {
        browser.get("/#/users");
        expect($("li.active a").getText()).toBe("Users");
    });
    it("Loads the correct template", function () {
        browser.get("/#/users");
        expect($("h2").getText()).toBe("User List");
    });
});
