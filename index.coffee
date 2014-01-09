path = require 'path'
gutil = require 'gulp-util'
es = require 'event-stream'
toText = require './lib/to_text'

class GulpWrapDefine extends require('stream').Transform
  constructor: (@options={}) -> super {objectMode: true}

  _transform: (file, encoding, callback) ->
    return callback() if file.isNull() or file.stat.isDirectory()

    dir = if @options.root then path.resolve(@options.root) else process.cwd()
    dir += '/' if dir[dir.length-1] isnt '/'
    rel_path = file.path.replace(dir, '')
    define = @options.define or 'define'

    file
      .pipe(toText (text) =>
        file = new gutil.File({
          path: file.path
          cwd: file.cwd
          base: file.base
          contents: new Buffer("#{define}('#{rel_path.replace(path.extname(rel_path), '')}', function(exports, require, module) {\n#{String(text)}\n});")
        })
        @push(file); callback()
      )

module.exports = (options) -> new GulpWrapDefine(options)
