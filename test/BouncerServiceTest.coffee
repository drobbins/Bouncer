describe "Unit: BouncerService", () ->

    beforeEach angular.mock.module "Bouncer"

    it "Existence", inject (Bouncer) -> chai.expect(Bouncer).not.to.equal(null)
