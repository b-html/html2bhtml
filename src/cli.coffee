html2bhtml = require './'
commander = require 'commander-b'
fs = require 'fs-extra'
path = require 'path'

class CLI
  constructor: ->

  run: ->
    command = commander 'html2bhtml <file>'
    command.version @_getVersion()
    command
    .option '-o, --output <dir>', 'the output directory for converted b-html'
    .option '-s, --sgml-line-break', 'ignore line break following a start tag and before an end tag'
    .action (file, { output, sgmlLineBreak } = {}) =>
      @_compileRecursive file, dir: output, removeWhiteSpace: sgmlLineBreak
    command.execute()
    .catch (e) ->
      console.error e

  _compile: (srcFile, { dir, removeWhiteSpace } = {}) ->
    ext = path.extname srcFile
    return if ext isnt '.html'
    data = fs.readFileSync srcFile, encoding: 'utf-8'
    bhtml = html2bhtml data, { removeWhiteSpace }
    dir ?= path.dirname srcFile
    base = path.basename srcFile, ext
    dstFile = path.join dir, base + '.bhtml'
    fs.outputFileSync dstFile, bhtml, encoding: 'utf-8'

  _compileRecursive: (srcFile, options) ->
    if fs.statSync(srcFile).isDirectory()
      files = fs.readdirSync srcFile
      files.forEach (f) =>
        @_compileRecursive path.join(srcFile, f), options
    else
      @_compile srcFile, options

  _getVersion: ->
    packageJsonFile = path.join __dirname, '/../package.json'
    packageJsonData = fs.readFileSync packageJsonFile, encoding: 'utf-8'
    packageJson = JSON.parse packageJsonData
    packageJson.version

module.exports.CLI = CLI
