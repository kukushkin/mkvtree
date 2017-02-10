require_relative 'mkvtree/version'
require_relative 'mkvtree/bitarray'
require_relative 'mkvtree/bin2hex'
require_relative 'mkvtree/node'

require 'digest'

class MKVTree
  extend Bin2hex

  KEY_SIZE    = 256 # bits, equals the depth of the tree
  NULL_VALUE  = ''.freeze

  attr_reader :root_node

  # Creates an empty MKVTree
  #
  def initialize
    @root_node = Node.new
  end

  # Sets (hash of) the value for the given key
  #
  # @param key [String] key as a byte array
  # @param value [String] hash of the value as a byte array
  #
  def []=(key, value)
    node = root_node
    ba_key = Bitarray.new(key)

    # finds or creates the node
    1.upto(KEY_SIZE) do |depth|
      bit = ba_key[depth - 1]
      if bit == 0
        # 0, descend left
        node = node.left || (node.left = Node.new(key, depth))
      else
        # 1, descend right
        node = node.right || (node.right = Node.new(key, depth))
      end
    end
    node.value = value
  end

  # Returns the hash of the value for the given key
  #
  # @param key [String] key as a byte array
  #
  def [](key)
    node = root_node
    ba_key = Bitarray.new(key)

    # descend to the node or bail with null value hash
    1.upto(KEY_SIZE) do |depth|
      bit = ba_key[depth - 1]
      node = bit == 0 ? node.left : node.right
      return self.class.null_value_hash unless node
    end
    node.value
  end

  def roothash
    hash_at(root_node)
  end

  def roothash_hex
    self.class.bin2hex(roothash)
  end

  private

  # Recursively computes the hash of the given node
  #
  def hash_at(node)
    return node.value if node.value
    left = node.left ? hash_at(node.left) : self.class.null_hash_at(node.depth + 1)
    right = node.right ? hash_at(node.right) : self.class.null_hash_at(node.depth + 1)
    self.class.hash_children(left, right)
  end

  # Traverses the tree to the leaf with index +key+, creating the necessary nodes
  # along the way.
  #
  def find_or_create_leaf(key)
  end

  # Hashes the given value
  #
  def self.hash(value)
    Digest::SHA256.digest(value)
  end

  # Computes the hash of the concatenated left (l_value) and right (r_value) values
  #
  def self.hash_children(l_value, r_value)
    hash(l_value + r_value)
  end

  # Returns the hash of the null value
  #
  def self.null_value_hash
    hash(NULL_VALUE).freeze
  end

  # Computes the hash of a subtree at a given depth
  #
  def self.null_hash_at(depth)
    raise ArgumentError, 'Invalid depth' if depth < 0 || depth > KEY_SIZE
    @null_hashes ||= {}
    return @null_hashes[depth] if @null_hashes[depth]
    if depth == KEY_SIZE
      h = null_value_hash
    else
      h1 = null_hash_at(depth + 1)
      h = hash_children(h1, h1)
    end
    @null_hashes[depth] = h
  end
end