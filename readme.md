# Bouncer is Bouncing

## Tests

This repo uses Karma and Protractor

Clone this repo, then:

```
npm install
bower install
./node_modules/grunt-protractor-runner/node_modules/protractor/bin/webdriver-manager update
```

Then one of these:

* ``npm test``
* ``npm run-script e2e``
* ``grunt e2e``
* ``grunt test``
* ``protractor test/protractor.conf.js``
* ``karma start test/karma.conf.coffee``

E2E tests expect that you have Bounce running @ ``http://localhost:27080`` against the ``bounce-test`` database (e.g. from your Bounce folder, ``node bin/bounce.js --connection-string mongodb://localhost/bounce-test``)
