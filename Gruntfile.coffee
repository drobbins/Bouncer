module.exports = (grunt) ->
    grunt.initConfig
        pkg: grunt.file.readJSON "package.json"

        connect:
            dist:
                options:
                    livereload: 8081
                    port: 8080
                    base: "build"
                    hostname: "*"
        watch:
            dist:
                options:
                    livereload: 8081
                files: ["index.html", "src/**/*", "test/**/*", "templates/**/*"]
                tasks: ["build"]
            e2e:
                files: ["index.html", "src/**/*", "test/**/*", "templates/**/*"]
                tasks: ["build", "mongoimport", "protractor:all"]

        coffee:
            build:
                expand: true
                flatten: true
                cwd: 'src'
                src: ['**/*.coffee']
                dest: '.tmp/coffee'
                ext: '.js'

        concat:
            scripts:
                src: [".tmp/**/*.js"]
                dest: "build/bouncer.js"

        copy:
            index:
                src: "index.html"
                dest: "build/index.html"
            glyphicons:
                src: "bower_components/bootstrap/fonts/*"
                dest: "build/fonts/"
                flatten: true
                expand: true

        useminPrepare:
            html: "build/index.html"
            options:
                dest: "build"
                root: "."
                flow:
                    steps:
                        js: ["concat"]
                        css: ["concat"]
                    post: {}

        html2js:
            options:
                base: ""
                fileHeaderString: "(function () {"
                fileFooterString: "})();"
            bouncer:
                module: "BouncerTemplates"
                src: ["templates/**/*.html"]
                dest: ".tmp/templates.js"

        usemin:
            html: "build/index.html"

        clean:
            all: ["build"]
            release: [".tmp"]

        protractor:
            options:
                keepAlive: true
            all:
                options:
                    configFile: "test/protractor.conf.js"

        karma:
            unit:
                configFile: "test/karma.conf.coffee"

        mongoimport:
            options:
                db: "bounce-test"
                stopOnError: false
                collections: [
                    {
                        name: "bounce.users"
                        type: "json"
                        file: "test/fixtures/bounce.users.json"
                        drop: true
                    }
                ]


    grunt.loadNpmTasks task for task in [
        "grunt-contrib-coffee"
        "grunt-contrib-watch"
        "grunt-contrib-connect"
        "grunt-contrib-concat"
        "grunt-contrib-copy"
        "grunt-contrib-clean"
        "grunt-usemin"
        "grunt-protractor-runner"
        "grunt-karma"
        "grunt-html2js"
        "grunt-mongoimport"
    ]

    grunt.registerTask "build", [
        "html2js"
        "copy"
        "coffee:build"
        "useminPrepare"
        "concat"
        "usemin"
    ]

    grunt.registerTask "serve", [
        "build"
        "connect:dist"
        "watch:dist"
    ]

    grunt.registerTask "e2e", [
        "build"
        "mongoimport"
        "connect:dist"
        "protractor:all"
        "watch:e2e"
    ]

    grunt.registerTask "test", [
        "karma:unit"
    ]
