module Chatter
  class Client
    def initialize(connection)
      @connection = connection
    end

    def send_message(message)
      @connection.write(message)
      self
    end
  end
end