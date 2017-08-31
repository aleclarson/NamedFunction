
{createImpl} = require ".."

describe "NamedFunction", ->

  it "creates a new Function when in __DEV__ mode", ->
    NamedFunction = createImpl yes
    name = "Foo"
    fn = do -> -> 1
    result = NamedFunction name, fn
    expect(fn.name).toBe ""
    expect(result).not.toBe fn
    expect(result()).toBe 1
    expect(result.name).toBe name
    expect(result.getName()).toBe name

  it "does not override 'name' when not in __DEV__ mode", ->
    NamedFunction = createImpl no
    name = "Foo"
    fn = do -> -> 1
    result = NamedFunction name, fn
    expect(result).toBe fn
    expect(result()).toBe 1
    expect(result.name).toBe ""
    expect(result.getName()).toBe name
