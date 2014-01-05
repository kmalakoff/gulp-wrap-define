path = require 'path'

class GulpWrapDefine extends require('stream').Transform
  constructor: (@options={}) -> super {objectMode: true}

  _transform: (file, encoding, callback) ->
    return callback() if file.isNull() or file.stat.isDirectory()

    rel_path = file.path.replace("#{path.resolve(@options.root) or process.cwd()}/", '')
    define = @options.define or 'define'

    file.contents = new Buffer("#{define}('#{rel_path.replace(path.extname(rel_path), '')}', function(exports, require, module) {\n#{String(file.contents)}\n});")
    @push(file); callback()

module.exports = (options) -> return new GulpWrapDefine(options)
