require_relative 'bitarray'

class MKVTree
  class Node
    attr_accessor :left, :right, :value, :depth

    def initialize(key = '', depth = 0)
      @key = Bitarray.new(key, size: depth)
      @depth = depth
      @left = nil
      @right = nil
      @value = nil
    end

    def leaf?
      value && true
    end

    def to_s
      leaf? ? "(#{@key} -> #{value.inspect})" : "(#{@key})"
    end
  end # class Node
end # class MKVTree
