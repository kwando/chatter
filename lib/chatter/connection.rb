module Chatter
  class Connection
    def initialize(socket, codec: Codecs::JSON)
      @codec = codec
      @socket = socket
      @connected = true
    end

    def open?
      @connected
    end

    def write(message)
      @socket.write(codec.encode(message))
      self
    end

    def close
      @socket.close
      @connected = false
      self
    end

    private
    attr_reader :codec, :connection
  end
end