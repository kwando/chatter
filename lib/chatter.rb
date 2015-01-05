require 'chatter/version'
require 'chatter/connection'
require 'chatter/client'
require 'chatter/codecs'

module Chatter
  class Server
    def initialize
      @clients = []
    end

    def connected_clients
      @clients.size
    end

    def register(client)
      @clients << client
      self
    end

    def broadcast(message)
      @clients.each { |client| client.send_message(message) }
      self
    end
  end
end
