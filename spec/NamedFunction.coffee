
describe "NamedFunction", ->

  it "renames an existing function", ->

    foo = -> 1

    Foo = NamedFunction "Foo", foo

    expect foo
      .toBe Foo

    expect Foo.name
      .toBe "Foo"

    expect Foo()
      .toBe 1
