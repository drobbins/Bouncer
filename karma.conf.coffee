module.exports = (config) ->
    config.set
        basePath: ""
        frameworks: ["mocha"]
        preprocessors:
            "**/*.coffee": ["coffee"]
        reporters: ['progress']
        coffeePreprocessor:
            options:
                bare: true
                sourceMap: true
            transformPath: (path) -> path.replace /\.coffee$/, ".js"
        port: 9876
        colors: true
        logLevel: config.LOG_INFO
        autoWatch: true
        browsers: ['Chrome']
        singleRun: false

