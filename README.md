# MKVTree

A variation of Merkle key-value trees with key-value storage properties.

[What is MKVTree and how it works](docs/introduction.md)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mkvtree'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mkvtree

## Usage

```
mkvt = MKVTree.new

mkvt.roothash # => root hash of an empty tree

key   = Digest::SHA256.digest('my_key')
value = Digest::SHA256.digest('my_value')
mkvt[key] = value

mkvt.roothash # => root hash of an updated tree
mkvt[key]     # => value (hash of 'my_value')
mkvt.proof(key) # => proof (path from the leaf to the root) of a key
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
