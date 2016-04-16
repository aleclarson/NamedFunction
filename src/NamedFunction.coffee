
require "isDev"

# Use 'getName' as the safe way of getting
# a function name in any environment.
Object.defineProperty Function.prototype, "getName",
  writable: yes
  value: -> @name

createImpl = (isConfigurable, isDev) ->

  NamedFunction = `function NamedFunction(name, fn) { return renameFunction(fn, name) }`

  unless isDev

    renameFunction = (fn, name) ->
      fn.getName = -> name
      return fn

  else if isConfigurable

    renameFunction = (fn, name) ->
      Object.defineProperty fn, "name", { value: name }
      fn.toString = NamedFunction.toString
      return fn

    NamedFunction.toString = ->
      Function::toString
        .call this
        .replace /^function([^\(\r]+)/, "function " + @name

  else

    renameFunction = (orig, name) ->
      fn = (Function "orig", "return function " + name + "() { return orig.apply(this, arguments) }")(orig)
      fn.toString = ->
        Function::toString
          .call orig
          .replace /^function([^\(\r]+)/, "function " + name
      return fn

  return NamedFunction

isConfigurable = Object.getOwnPropertyDescriptor(Function, "name").configurable
module.exports = NamedFunction = createImpl isConfigurable, isDev
NamedFunction.createImpl = createImpl
