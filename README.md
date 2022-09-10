

[![Issue Count](https://codeclimate.com/github/RobertDober/l42_map/badges/issue_count.svg)](https://codeclimate.com/github/RobertDober/l42_map)
[![CI](https://github.com/robertdober/l42_map/workflows/CI/badge.svg)](https://github.com/robertdober/l42_map/actions)
[![Coverage Status](https://coveralls.io/repos/github/RobertDober/l42_map/badge.svg?branch=master)](https://coveralls.io/github/RobertDober/l42_map?branch=master)
[![Gem Version](https://badge.fury.io/rb/l42_map.svg)](http://badge.fury.io/rb/l42_map)
[![Gem Downloads](https://img.shields.io/gem/dt/l42_map.svg)](https://rubygems.org/gems/l42_map)
<!--
     [![Code Climate](https://codeclimate.com/github/RobertDober/lab42_streams/badges/gpa.svg)](https://codeclimate.com/github/RobertDober/lab42_streams)
  [![Issue Count](https://codeclimate.com/github/RobertDober/lab42_streams/badges/issue_count.svg)](https://codeclimate.com/github/RobertDober/lab42_streams)
  [![Test Coverage](https://codeclimate.com/github/RobertDober/lab42_streams/badges/coverage.svg)](https://codeclimate.com/github/RobertDober/lab42_streams)
-->

# l42_map

Immutable OpenStruct On Steroids

## How does it work?

Let us [speculate about](https://github.com/RobertDober/speculate_about) that:

## Context Polluting the global namespace, or not?

Given that we included `l42/map`
```ruby
    require 'l42/map'
```

Then the global namespace is **not polluted**
```ruby
  expect {
    Map
  }.to raise_error(NameError, "uninitialized constant Map")
```

But we can access it inside the namespace
```ruby
  expect {
    L42::Map
  }.not_to raise_error
```

In order to access `Map` inside the global namespace one needs
to do

```ruby
    require 'l42/map/global'
```

## Context Setup

Given instance of `L42::Map`
```ruby
  let(:empty) { L42::Map.new }
  let(:single) { L42::Map.new(a: 1) }
  let(:map) { L42::Map.new(a: 10, b: 20, c: 30) }
```

### Context The OpenStruct API

Then they can be accessed by name
```ruby
  expect(single.a).to eq(1)
  expect(map.a).to eq(10)
  expect(map.c).to eq(30)
```

And we can use the `[]` syntax
```ruby
  expect(empty[:a]).to be_nil
  expect(single[:a]).to eq(1)
  expect(map[:b]).to eq(20)
```

### Context Extensions to the OpenStruct API

And we can use `fetch`
```ruby
  expect {
    empty.fetch(:a)
  }.to raise_error(KeyError)

  expect(empty.fetch(:a, 42)).to eq(42)
  expect(empty.fetch(:a) { 43 }).to eq(43)

  expect(single.fetch(:a)).to eq(1)
```

And we can merge into new instances
```ruby
  clone = empty.merge(x: "x")
  expect(clone.x).to eq("x")
  expect(empty).to be_empty
```

#### Context `with_default`

Given a `Map` instance with `with_default`
```ruby
  let(:wd) { L42::Map.new.with_default(42) }
```

Then any access will yield 42
```ruby
    expect(wd.some_value).to eq(42)
```

And the default value is passed on to clones
```ruby
    also_wd = wd.merge(a: 43)
    expect(wd.a).to eq(42)
    expect(also_wd.a).to eq(43)
    expect(also_wd.b).to eq(42)
```

#### Context `Hash` methods

And our instance behaves much like a `Hash`
```ruby
    expect(map.slice(:a, :c)).to eq(L42::Map.new(a: 10, c: 30))

```

#### Additional methods

And we can remove keys
```ruby
    expect(map.without(:a, :b)).to eq(L42::Map.new(c: 30))
```

### Context `Enumerable`

And we can iterate
```ruby
    result = map.inject(0) { |s, (_k, v)| s + v }
    expect(result).to eq(60)
```
## LICENSE

Copyright 2022] Robert Dober robert.dober@gmail.com,

Apache-2.0 [c.f LICENSE](LICENSE)
