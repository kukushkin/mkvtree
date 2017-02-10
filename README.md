# MKVTree

A variation of Merkle key-value trees with key-value storage properties.

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

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/mkvtree. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

