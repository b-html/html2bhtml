{Promise} = require 'es6-promise'
htmlParser = require 'html-parser'

format = (root) ->
  html = root.children.map(formatElement).join('')
  html.substring 1 # remove first \n

formatAttribute = (attr) ->
  indent = [0...(attr.level - 2)].map(-> ' ').join('')
  '\n' + indent + '@' + attr.name + ' ' + attr.value

formatElement = (node) ->
  indent = [0...(node.level - 2)].map(-> ' ').join('')
  switch node.type
    when 'text'
      '\n' + indent + node.content
    when 'element'
      '\n' + indent + '<' + node.name +
      node.attributes.map(formatAttribute).join('') +
      node.children.map(formatElement).join('')
    when 'empty element'
      '\n' + indent + '</' + node.name +
      node.attributes.map(formatAttribute).join('')

parse = (html) ->
  root =
    name: 'root'
    attributes: []
    children: []
  root.parent = root
  node = root
  level = 0
  htmlParser.parse html,
    docType: (value) ->
      # console.log('doctype: %s', value)
      node.children.push
        type: 'text'
        content: '><!DOCTYPE ' + value + '>'
    openElement: (name) ->
      # console.log('open: %s', name)
      level += 2
      n =
        level: level
        name: name
        attributes: []
        children: []
        parent: node
      node.children.push n
      node = n
    closeOpenedElement: (name, token, unary) ->
      # console.log('token: %s, unary: %s', token, unary)
      if unary
        level -= 2
        node.type = 'empty element'
        node = node.parent
    closeElement: (name) ->
      # console.log('close: %s', name)
      node.type = 'element'
      level -= 2
      node = node.parent
    attribute: (name, value) ->
      # console.log('attribute: %s=%s', name, value)
      node.attributes.push
        level: level + 2
        name: name
        value: value
    comment: (value) ->
      # console.log('comment: %s', value)
      indent = [0...level].map(-> ' ').join('')
      node.children.push
        level: level + 2
        type: 'text'
        content:  '><!--' + value.replace(/\n/g, '\n|') + '-->'
    cdata: (value) ->
      # console.log('cdata: %s', value)
      node.children.push
        level: level + 2
        type: 'text'
        content:  '><![CDATA[' + (if value.length is 1
          value.replace /\n/g, '\n|'
        else
          value.replace /\n/g, '\n|'
        ) + ']]>'
    text: (value) ->
      # console.log('text: %s', value)
      indent = [0...level].map(-> ' ').join('')
      value = '>' + value.split(/\n/).map((i) -> i).join('\n' + indent + '|')
      value = value.replace /^>\n\s*\|/, '|'
      node.children.push
        level: level + 2
        type: 'text'
        content: value
  root

module.exports = (html) ->
  root = parse html
  format root