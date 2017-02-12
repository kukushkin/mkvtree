require 'spec_helper'

describe 'Setting key/value in MKVTree:' do
  let(:key1) { MKVTree.hash('key1') } # 8174099687a26621f4e2cdd7cc03b3dacedb3fb962255b1aafd033cabe831530
  let(:key2) { MKVTree.hash('key2') } # b10253764c8b233fb37542e23401c7b450e5a6f9751f3b5a014f6f67e8bc999d
  let(:key3) { MKVTree.hash('key3') } # f576104eebeab09651d83acffc77c8b8c6eaa4b767aeab24d7da80f83f51d865
  let(:value1) { MKVTree.hash('value1') } # 3c9683017f9e4bf33d0fbedd26bf143fd72de9b9dd145441b75f0604047ea28e
  let(:value2) { MKVTree.hash('value2') } # 0537d481f73a757334328052da3af9626ced97028e20b849f6115c22cd765197
  let(:value3) { MKVTree.hash('value3') } # 89dc6ae7f06a9f46b565af03eab0ece0bf6024d3659b7e3a1d03573cfeb0b59d

  let(:null_roothash) { '9a596033c82b65c5eef0f5f160b9c9893844765a15ab685486931c870004b910' }
  let(:key1_roothash) { '524dbce33b5ecdd49edc60abd7df7c2bf4db9ab706527ac93e72a8f2bdcd4783' }
  let(:key2_roothash) { '582278fef08a8f724c8667ae6c91167ef1418ae6f641fd186626487866c24c0c' }
  let(:key3_roothash) { 'c51d0cdf6f1d57d2c49f80f4ca2c7588e5fdd5067fa71a55b13551f10cde3f3c' }
  let(:key123_roothash) { '55b800de862e9d325da570ebc434cf5070cc83ce29b2f3f6522388a9e9f73fb7' }

  subject { MKVTree.new }

  context 'when empty' do
    it 'has an empty roothash' do
      expect(subject.roothash).to eq MKVTree.hex2bin(null_roothash)
    end
  end # when empty

  context 'when a key1 is set' do
    before { subject[key1] = value1 }

    it 'has a correct roothash {ROOTHASH_KEY1}' do
      expect(subject.roothash).to eq MKVTree.hex2bin(key1_roothash)
    end
  end # when a key1 is set

  context 'when a key2 is set' do
    before { subject[key2] = value2 }

    it 'has a correct roothash {ROOTHASH_KEY2}' do
      expect(subject.roothash).to eq MKVTree.hex2bin(key2_roothash)
    end
  end # when a key2 is set

  context 'when a key3 is set' do
    before { subject[key3] = value3 }

    it 'has a correct roothash {ROOTHASH_KEY2}' do
      expect(subject.roothash).to eq MKVTree.hex2bin(key3_roothash)
    end
  end # when a key3 is set

  context 'when keys 1,2,3 are set in any order' do
    it 'has a correct roothash {ROOTHASH_KEY123}, order: 1 2 3' do
      subject[key1] = value1
      expect(subject.roothash).to eq MKVTree.hex2bin(key1_roothash)
      subject[key2] = value2
      subject[key3] = value3
      expect(subject.roothash).to eq MKVTree.hex2bin(key123_roothash)
    end

    it 'has a correct roothash {ROOTHASH_KEY123}, order: 2 3 1' do
      subject[key2] = value2
      expect(subject.roothash).to eq MKVTree.hex2bin(key2_roothash)
      subject[key1] = value1
      subject[key3] = value3
      expect(subject.roothash).to eq MKVTree.hex2bin(key123_roothash)
    end

    it 'has a correct roothash {ROOTHASH_KEY123}, order: 3 2 1' do
      subject[key3] = value3
      subject[key2] = value2
      subject[key1] = value1
      expect(subject.roothash).to eq MKVTree.hex2bin(key123_roothash)
    end
  end # when a key2 is set
end # Setting key/value in MKVTree
