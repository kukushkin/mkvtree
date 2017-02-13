require 'spec_helper'

describe 'MKVTree proofs:' do
  let(:null_root_node_subhashes) { [MKVTree.null_hash_at(1), MKVTree.null_hash_at(1)] }
  let(:null_leaves_hashes) { [MKVTree.null_value_hash, MKVTree.null_value_hash] }

  subject { MKVTree.new }

  it { is_expected.to respond_to(:proof) }

  context 'when MKVTree is empty,' do
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
  end # when MKVTree is empty

  context 'when validating a proof,' do
    let(:mkvtree) { MKVTree.new }
    let(:key) { MKVTree.hash('somekey') }
    let(:null_key) { "\x00" * 32 } # 256 zero bits
    let(:null_proof) { mkvtree.proof(null_key) }
    let(:null_proof) { mkvtree.proof(key) }
    let(:invalid_null_roothash) { MKVTree.hash('bogus') }
    let(:invalid_null_proof) { null_proof.dup.merge(roothash: invalid_null_roothash) }

    it 'validates a valid null proof' do
      expect { MKVTree.valid_proof?(null_proof) }.to_not raise_error
      expect(MKVTree.valid_proof?(null_proof)).to be true
    end

    it 'reports as invalid an invalid null proof' do
      expect { MKVTree.valid_proof?(invalid_null_proof) }.to_not raise_error
      expect(MKVTree.valid_proof?(invalid_null_proof)).to be false
    end
  end # when validating a proof

  context 'when validating test vectors,' do
    let(:proof) { fixture_mkvtree_proof(fixture_name) }

    %w(
      proof_valid_01
      proof_valid_11
    ).each do |proof_name|
      context "test (valid proof): #{proof_name}" do
        let(:fixture_name) { proof_name }
        it 'validates a valid proof' do
          expect { MKVTree.valid_proof?(proof) }.to_not raise_error
          expect(MKVTree.valid_proof?(proof)).to be true
        end
      end
    end #

    %w(
      proof_invalid_01 proof_invalid_02 proof_invalid_03
      proof_invalid_11 proof_invalid_12 proof_invalid_13
    ).each do |proof_name|
      context "test (invalid proof): #{proof_name}" do
        let(:fixture_name) { proof_name }
        it 'validates an invalid proof' do
          expect { MKVTree.valid_proof?(proof) }.to_not raise_error
          expect(MKVTree.valid_proof?(proof)).to be false
        end
      end
    end #
  end
end # MKVTree generates proofs
