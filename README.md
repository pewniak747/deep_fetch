# DeepFetch

[![Build Status](https://secure.travis-ci.org/pewniak747/deep_fetch.png?branch=master)](http://travis-ci.org/pewniak747/deep_fetch)

Easily fetch values from nested ruby hashes.

## Installation

    $ gem install deep_fetch

## Usage

``` ruby
require 'deep_fetch'

big_hash = {
  :foo => {
    :bar => [ 'a', 'b', 'c' ],
    :baz => :boo
  }
}

big_hash.deep_fetch(:foo, :baz) # :boo
big_hash.deep_fetch(:foo, :boo) # raises KeyError
big_hash.deep_fetch(:foo, :boo) { "not found" } # "not found"
big_hash.deep_fetch(:foo, :bar, 1) # also fetch nested array
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
