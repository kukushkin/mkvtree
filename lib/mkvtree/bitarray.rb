class MKVTree
  class Bitarray
    DEFAULT_OPTS = {
      size: 256 # in bits
    }.freeze

    attr_reader :size
    attr_reader :bytes
    attr_reader :bytesize

    def initialize(value = '', opts = DEFAULT_OPTS)
      @size = opts[:size]
      @bytesize = (opts[:size] / 8.0).ceil

      raise ArgumentError, 'String expected as value' unless value.is_a?(String)

      @bytes = value.bytes

      # trim excess bytes
      @bytes = @bytes.first(@bytesize)
      # pad with zeros
      @bytes += [0] * (@bytesize - value.size) if value.size < @bytesize
    end

    # Returns value as String
    #
    def value
      @bytes.pack('C*')
    end

    # Sets the i-th bit of the value to v.
    #
    # Bit 0 is the most significant bit of the value.
    # Bit (size - 1) is the least significant bit.
    #
    # @param i [Fixnum]
    # @param v [Fixnum,true,false]
    #
    def []=(i, v)
      raise ArgumentError, 'Invalid bit index' unless i >= 0 && i < size
      byte_i = i / 8
      bit_i  = i % 8
      if !v || v == 0
        # clear bit
        @bytes[byte_i] = @bytes[byte_i] & (0xff ^ (0x80 >> bit_i))
      else
        # set bit
        @bytes[byte_i] = @bytes[byte_i] | (0x80 >> bit_i)
      end
      v
    end

    # Returns the i-th bit of the value.
    #
    def [](i)
      raise ArgumentError, 'Invalid bit index' unless i >= 0 && i < size
      byte_i = i / 8
      bit_i  = i % 8
      @bytes[byte_i] & (0x80 >> bit_i) > 0 ? 1 : 0
    end

    # Represent bits as String
    #
    # @example
    #   ba.to_s # => "01110001"
    #
    def to_s
      value.unpack('B*').first[0...size]
    end
  end # class Bitarray
end # class MKVTree
