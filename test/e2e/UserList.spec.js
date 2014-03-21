describe("UserList", function () {

    it("Highlights the correct browser tab", function () {
        browser.get("/#/users");
        expect($("li.active a").getText()).toBe("Users");
    });

    it("Displays the list of users", function () {
        // User list loaded from test/fixtures/bounce.users.json
        browser.get("/#/users");
        expect($("h2").getText()).toBe("User List");
        expect(element.all(by.repeater("user in users._embedded.users")).count()).toBe(3);
    });

    describe("Adding Users", function () {

        it("New User Button", function () {
            browser.get("/#/users");
            $("[ui-sref=\"UserAdd\"]").click();
            expect(browser.getLocationAbsUrl()).toBe("http://localhost:8080/#/users/new");
        });

        it("Add a User", function () {
            var username = "TestJan";
            browser.get("/#/users/new");
            element(by.model("user.username")).sendKeys(username);
            element(by.model("user.password")).sendKeys("password");
            $("[type=submit]").click();
            expect(browser.getLocationAbsUrl()).toBe("http://localhost:8080/#/users");
            expect(element.all(by.repeater("user in users._embedded.users")).count()).toBe(4);
            nameCell = element(by.repeater("user in users._embedded.users").row(3).column("user.username"));
            expect(nameCell.getText()).toBe(username);
        });

    });
});
