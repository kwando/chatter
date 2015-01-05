require 'test_helper'

describe Chatter::Client do
  let(:connection) { Minitest::Mock.new }
  let(:client) { Chatter::Client.new(connection) }

  describe '#send_message' do
    it 'passes message to the connection' do
      message = {body: 'Hello World'}
      connection.expect(:write, nil, [message])
      client.send_message(message)
      connection.verify
    end
  end
end