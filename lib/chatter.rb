require 'chatter/version'
require 'chatter/connection'
require 'chatter/client'
require 'chatter/codecs'

require 'set'

module Chatter
  class Server
    def initialize
      @clients = Set.new
    end

    def connected_clients
      @clients.size
    end

    def register(client)
      @clients.add(client)
      self
    end

    def unregister(client)
      @clients.delete(client)
      self
    end

    def broadcast(message)
      @clients.each { |client| client.send_message(message) }
      self
    end
  end
end
