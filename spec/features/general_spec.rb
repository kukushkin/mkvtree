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

  it 'uses SHA256' do
    expect(MKVTree.bin2hex(MKVTree.hash(value))).to eq hash
  end

  it 'hashes the null value to {NULL_VALUE_HASH}' do
    expect(MKVTree.bin2hex(MKVTree.null_value_hash)).to eq null_value_hash
  end
end # describe MKVTree
