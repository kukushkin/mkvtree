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
  end # module Bin2hex
end # class MKVTree
