require 'pathname'
require 'json'

# Returns pathname of the given fixture or folder in fixtures
#
def fixture_path(*name)
  Pathname.pwd.join('spec', 'fixtures', *name)
end

# Reads and returns fixture contents as a String.
#
def fixture(name)
  File.read(fixture_path(name))
end

# Reads and returns fixture contents parsed from a JSON string.
# Removes line-comments (start with #).
#
def fixture_json(name)
  contents = fixture("#{name}.json").split("\n").reject { |l| l =~ /^\s*\#/ }.join("\n")
  JSON.parse(contents)
end

# Reads and returns fixture contents parsed from a JSON string.
# Symbolizes the keys of a proof, converts hex2bin
#
def fixture_mkvtree_proof(name)
  proof = fixture_json(name)
  proof.map { |k, v| [k.to_sym, MKVTree.deep_hex2bin(v)] }.to_h
end
