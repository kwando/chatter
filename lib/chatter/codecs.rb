require 'multi_json'
require 'chatter/errors'

module Chatter
  module Codecs
    module JSON
      class JSONDecodeError < Chatter::CodecError
        def initialize(input, error)
          @input = input
          @error = error
          super("could not parse #{input} as JSON")
        end

        attr_reader :input, :error
      end

      class JSONEncodeError < Chatter::CodecError
        def initialize(input, error)
          @input = input
          @error = error
          super("could dump #{input.inspect} as JSON")
        end

        attr_reader :input, :error
      end

      def self.encode(data)
        raise ArgumentError.new('expected ') unless data.kind_of?(Hash)
        MultiJson.dump(data)
      rescue => error
        raise JSONEncodeError.new(data, error)
      end

      def self.decode(data)
        MultiJson.load(data, symbolize_keys: true)
      rescue => error
        raise JSONDecodeError.new(data, error)
      end
    end
  end
end