describe "Unit: BouncerService", () ->

    beforeEach angular.mock.module "Bouncer"

    it "Existence", inject (Bouncer) -> expect(Bouncer).not.to.equal(null)

    it "Hello World", inject (Bouncer) ->
        expect Bouncer.hello()
            .to.equal("World")
