require 'test_helper'

describe Chatter::Connection do
  let(:socket) { Minitest::Mock.new }
  let(:connection) { Chatter::Connection.new(socket) }


  it 'is open' do
    connection.open?.must_equal(true)
  end

  describe '#close' do
    def setup
      socket.expect(:close, nil)
    end

    it 'should not be open afterwards' do
      connection.close
      connection.open?.must_equal(false)
    end

    it 'calls close on socket' do
      connection.close
      socket.verify
    end
  end

  describe '#write' do
    let(:msg) { {body: 'hello world'} }
    let(:result) { connection.write(msg) }

    def setup
      socket.expect(:write, nil, [String])
    end

    it 'returns self' do
      result.must_equal(connection)
    end

    it 'forwards encoded message to socket' do
      result
      socket.verify
    end

    it 'raises an ArgumentError if argument is not a hash' do
      proc { connection.write('this should fail') }.must_raise(Chatter::Codecs::JSON::JSONEncodeError)
    end

    describe 'codec' do
      let(:codec) { Minitest::Mock.new }

      it 'uses the codec' do
        connection = Chatter::Connection.new(socket, codec: codec)
        message = {body: 'hello'}
        encoded = '{"body": "hello"}'

        codec.expect(:encode, encoded, [message])
        socket.expect(:write, nil, [String])

        connection.write(message)

        codec.verify
        socket.verify
      end
    end

  end
end