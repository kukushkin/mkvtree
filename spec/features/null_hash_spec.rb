require 'spec_helper'

describe 'An empty MKVTree:' do
  let(:null_roothash) { '9a596033c82b65c5eef0f5f160b9c9893844765a15ab685486931c870004b910' }

  subject { MKVTree.new }

  it 'has a roothash of {NULL_ROOTHASH}' do
    expect(subject.roothash).to eq MKVTree.hex2bin(null_roothash)
  end
end # An empty MKVTree
