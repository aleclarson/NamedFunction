
{ createImpl } = require "../src/NamedFunction"

describe "NamedFunction", ->

  it "does not override 'name' when not in __DEV__ mode", ->

    NamedFunction = createImpl yes, no

    name = "Foo"

    fn = -> 1

    result = NamedFunction name, fn

    expect result
      .toBe fn

    expect result()
      .toBe 1

    expect result.name
      .toBe ""

    expect result.getName()
      .toBe name

  it "overrides 'name' when it is configurable", ->

    NamedFunction = createImpl yes, yes

    name = "Foo"

    fn = -> 1

    result = NamedFunction name, fn

    expect result
      .toBe fn

    expect result()
      .toBe 1

    expect result.name
      .toBe name

    expect result.getName()
      .toBe name

  it "creates a new Function when 'name' is not configurable", ->

    NamedFunction = createImpl no, yes

    name = "Foo"

    fn = -> 1

    result = NamedFunction name, fn

    expect result
      .not.toBe fn

    expect result()
      .toBe 1

    expect result.name
      .toBe name

    expect result.getName()
      .toBe name

    expect fn.name
      .toBe ""
