path = require 'path'

class GulpWrapDefine extends require('stream').Transform
  constructor: (@options={}) -> super {objectMode: true}

  _transform: (file, encoding, callback) ->
    return callback() if file.isNull() or file.stat.isDirectory()

    dir = if @options.root then path.resolve(@options.root) else process.cwd()
    dir += '/' if dir[dir.length-1] isnt '/'
    rel_path = file.path.replace(dir, '')
    define = @options.define or 'define'

    file.contents = new Buffer("#{define}('#{rel_path.replace(path.extname(rel_path), '')}', function(exports, require, module) {\n#{String(file.contents)}\n});")
    @push(file); callback()

module.exports = (options) -> return new GulpWrapDefine(options)
