gulp-wrap-define
================

Gulp plugin for wrapping files in a define statement.

Create a single JavaScript file with each file wrapped in `define('file_name', function(exports, require, module) { /* file content */ });`
```
gulp = require 'gulp'
define = require 'gulp-wrap-define'
concat = require 'gulp-concat'

gulp.task 'build', ->
    gulp.src('./lib/**/*.js')
    .pipe(define(root: './lib'))
    .pipe(concat('your-js-library.js'))
    .pipe(gulp.dest('./dist/'))
```


Create a single JavaScript file with each file wrapped in `require.register('file_name', function(exports, require, module) { /* file content */ });` like Brunch.
```
gulp = require 'gulp'
coffee = require 'gulp-coffee'; gutil = require 'gulp-util'
define = require 'gulp-wrap-define'
concat = require 'gulp-concat'

gulp.task 'build', ->
  gulp.src('./src/**/*.coffee').pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(define({root: './src', define: 'require.register'}))
    .pipe(concat('your-cs-library.js'))
    .pipe(gulp.dest('./dist/'))
```

