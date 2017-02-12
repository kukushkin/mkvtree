require 'spec_helper'

describe 'MKVTree proofs:' do
  let(:null_root_node_subhashes) { [MKVTree.null_hash_at(1), MKVTree.null_hash_at(1)] }
  let(:null_leaves_hashes) { [MKVTree.null_value_hash, MKVTree.null_value_hash] }

  subject { MKVTree.new }

  it { is_expected.to respond_to(:proof) }

  context 'when MKVTree is empty' do
    let(:key) { MKVTree.hash('somekey') }
    let(:proof) { subject.proof(key) }
    let(:proof_path) { proof[:path] }

    it 'provides a proof as a Hash with :roothash, :key, :value and :path keys' do
      expect(proof).to be_a(Hash)
      expect(proof).to have_key(:roothash)
      expect(proof).to have_key(:key)
      expect(proof).to have_key(:value)
      expect(proof).to have_key(:path)
    end

    it 'provides a null proof for any key' do
      expect(proof[:value]).to eq MKVTree.null_value_hash

      # quick path validation: top(root)-level and leaves
      expect(proof[:path]).to be_a(Array)
      expect(proof[:path].size).to eq 256
      expect(proof[:path].first).to eq null_root_node_subhashes
      expect(proof[:path].last).to eq null_leaves_hashes
    end
  end
end # MKVTree generates proofs
