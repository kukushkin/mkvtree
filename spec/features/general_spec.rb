require 'spec_helper'

describe MKVTree do
  let(:value) { 'test123' }
  let(:hash) { 'ecd71870d1963316a97e3ac3408c9835ad8cf0f3c1bc703527c30265534f75ae' }
  let(:null_value_hash) { 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855' }
  subject { MKVTree }

  it { is_expected.to respond_to(:hash) }
  it { is_expected.to respond_to(:null_value_hash) }

  it 'has key size of 256' do
    expect(MKVTree::KEY_SIZE).to eq 256
  end

  it 'converts bin2hex correctly' do
    expect(MKVTree.bin2hex("\x01\x02\x03\xFF")).to eq '010203ff'
  end

  it 'converts hex2bin correctly' do
    expect(MKVTree.hex2bin('010203')).to eq "\x01\x02\x03".encode(Encoding::ASCII_8BIT)
  end

  it 'uses SHA256' do
    expect(MKVTree.hash(value)).to eq MKVTree.hex2bin(hash)
  end

  it 'hashes the null value to {NULL_VALUE_HASH}' do
    expect(MKVTree.null_value_hash).to eq MKVTree.hex2bin(null_value_hash)
  end
end # describe MKVTree
