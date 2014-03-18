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
                files: ["index.html", "src/**/*", "test/**/*"]
                tasks: ["build"]

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
                src: [".tmp/coffee/*.js"]
                dest: "build/bouncer.js"

        copy:
            index:
                src: "index.html"
                dest: "build/index.html"

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
    ]

    grunt.registerTask "build", [
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
        "connect:dist"
        "protractor:all"
    ]

    grunt.registerTask "test", [
        "karma:unit"
    ]
