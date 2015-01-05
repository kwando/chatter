require 'test_helper'

describe Chatter::Server do
  let(:server) { Chatter::Server.new }
  let(:client) { Minitest::Mock.new }

  it 'will have no connected clients' do
    server.connected_clients.must_equal(0)
  end

  describe '#broadcast' do
    let(:msg) { {body: 'Hello World'} }
    let(:result) { server.broadcast(msg) }

    it 'returns self' do
      result.must_equal(server)
    end

    it 'forwards message to clients' do
      client.expect(:hash, 1234)
      server.register(client)
      client.expect(:send_message, client, [msg])
      server.broadcast(msg)
      client.verify
    end
  end

  describe '#register' do
    let(:result) {
      client.expect(:hash, 1234)
      server.register(client)
    }

    it 'returns self' do
      result.must_equal(server)
    end

    it 'should have 1 connected clients' do
      result.connected_clients.must_equal(1)
    end
  end

  describe '#unregister' do
    let(:result){
      client.expect(:hash, 1234)
      client.expect(:hash, 1234)

      server.register(client)
      server.unregister(client)
    }

    it 'returns self' do
      result.must_equal(server)
      client.verify
    end

    it 'should remove client' do
      result.connected_clients.must_equal(0)
    end
  end
end