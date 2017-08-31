
isDev = require "isDev"

# The `getName` method works in and out of __DEV__ mode.
isDev and Object.defineProperty Function::, "getName", value: -> @name

createImpl = (isDev) ->

  NamedFunction = `function NamedFunction(name, fn) { return renameFunction(fn, name) }`

  if isDev

    renameFunction = (orig, name) ->
      fn = Function("orig", "return function " + name + "() { return orig.apply(this, arguments) }")(orig)
      Object.defineProperty fn, "__orig", {value: orig}
      fn.toString = NamedFunction.toString
      return fn

    NamedFunction.toString = ->
      Function::toString
        .call @__orig
        .replace /^function([^\(\r]+)/, "function " + @name

  else
    renameFunction = (fn, name) ->
      fn.getName = -> name
      return fn

  NamedFunction.createImpl = createImpl

  return NamedFunction

module.exports = NamedFunction = createImpl isDev
