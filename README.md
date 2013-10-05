# deep_fetch

[![Build Status](https://secure.travis-ci.org/pewniak747/deep_fetch.png?branch=master)](http://travis-ci.org/pewniak747/deep_fetch)
[![Coverage Status](https://coveralls.io/repos/pewniak747/deep_fetch/badge.png?branch=master)](https://coveralls.io/r/pewniak747/deep_fetch)
[![Dependency Status](https://gemnasium.com/pewniak747/deep_fetch.png)](https://gemnasium.com/pewniak747/deep_fetch)
[![Gem Version](https://badge.fury.io/rb/deep_fetch.png)](http://badge.fury.io/rb/deep_fetch)

Easily fetch values from nested ruby hashes.

## Installation

Add this line to your application's Gemfile:

```
gem 'deep_fetch'
```

And then execute:

```
bundle
```

## How?

Let's say we have a big hash:

``` ruby
example = {
  :foo => {
    :bar => [ 'a', 'b', 'c' ],
    :baz => :boo
  }
}
```

We can fetch a value under :foo, :baz easily:

``` ruby
example.deep_fetch(:foo, :baz) # => :boo
```

If the key does not exist, we receive KeyError exception, just like using `Hash#fetch`

``` ruby
example.deep_fetch(:foo, :boo) # => KeyError: key not found: :boo
```

Specify a default value to be returned if key is missing in a block:

``` ruby
example.deep_fetch(:foo, :boo) { "not found" } # => "not found"
```

Lastly, if the hash contains nested array, we can get values from it by providing an integer:

``` ruby
example.deep_fetch(:foo, :bar, 1) # => 'b'
```

## Why?

The gem might be useful when working with deeply nested hashes, e.g. API responses.

By using `Hash#deep_fetch` we can assert that the response contains the key, making it fail loud otherwise.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
