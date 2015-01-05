require 'test_helper'

describe Chatter::Codecs::JSON do
  let(:codec) { Chatter::Codecs::JSON }
  let(:msg) { {body: 'hello'} }


  describe '#encoding' do
    it 'returns a string' do
      codec.encode(msg).must_be_kind_of(String)
    end
  end

  describe '#decoding' do
    let(:encoded) { codec.encode(msg) }

    it 'returns a hash' do
      codec.decode(encoded).must_be_kind_of(Hash)
    end

    it 'raises a codec error on invalid input' do
      proc { codec.decode('asdlakj') }.must_raise Chatter::Codecs::JSON::JSONDecodeError
    end
  end

  it 'passes the sanity test' do
    codec.decode(codec.encode(msg)).must_equal(msg)
  end
end