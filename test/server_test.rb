require 'test_helper'

describe Chatter::Server do
  let(:server) { Chatter::Server.new }

  it 'will have no connected clients' do
    server.connected_clients.must_equal(0)
  end
end