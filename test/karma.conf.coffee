module.exports = (config) ->
    config.set
        autoWatch: true
        basePath: "../"
        files: [
          # General Dependencies
            "bower_components/angular/angular.js"
            "bower_components/angular-ui-router/release/angular-ui-router.js"
            "bower_components/angular-resource/angular-resource.js"
            "bower_components/angular-mocks/angular-mocks.js"
            "bower_components/Bounce/client/browser/bounce.js"
          # My Files
            "src/**/*.coffee"
            "test/**/*.coffee"
        ]
        frameworks: ["mocha", "sinon-chai"]
        reporters: ['dots']
        port: 9876
        colors: true
        logLevel: config.LOG_INFO
        autoWatch: true
        browsers: ['Chrome']
        singleRun: false
        preprocessors:
            "**/*.coffee": ["coffee"]
        coffeePreprocessor:
            options:
                bare: true
                sourceMap: true
            transformPath: (path) -> path.replace /\.coffee$/, ".js"

