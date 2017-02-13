class MKVTree
  module Bin2hex
    # Converts a byte array (as String) to a hex-string
    #
    # @param string_bin [String] byte array
    # @return [String]
    #
    def bin2hex(string_bin)
      string_bin.unpack('H*').first
    end

    # Converts a hex-string to a byte array (as String)
    #
    # @param string [String] hex-string
    # @return String
    #
    def hex2bin(string)
      [string].pack('H*')
    end

    # Applies bin2hex to all values of the Hash or Array
    #
    def deep_bin2hex(value)
      case value
      when String
        bin2hex(value)
      when Hash
        value.map { |k, v| [k, deep_bin2hex(v)] }.to_h
      when Array
        value.map { |v| deep_bin2hex(v) }
      else
        raise ArgumentError, "Cannot apply bin2hex to a value of class: #{value.class}"
      end
    end

    # Applies hex2bin to all values of the Hash or Array
    #
    def deep_hex2bin(value)
      case value
      when String
        hex2bin(value)
      when Hash
        value.map { |k, v| [k, deep_hex2bin(v)] }.to_h
      when Array
        value.map { |v| deep_hex2bin(v) }
      else
        raise ArgumentError, "Cannot apply hex2bin to a value of class: #{value.class}"
      end
    end
  end # module Bin2hex
end # class MKVTree
