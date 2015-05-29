module HealthGraph
  module Model
    include API

    attr_accessor :body

    def self.included(includer)
      includer.extend ClassMethods
    end

    module ClassMethods
      def from_hash(hash)
        instance = new(hash)
        yield instance if block_given?
        instance
      end

      def hash_attr_accessor(*symbols)
        attr_writer(*symbols)
        symbols.each do |symbol|
          define_method(symbol) do
            instance_variable_get("@#{symbol}")
          end
        end
      end
    end

    def populate_from_request!(access_token, &block)
      self.access_token = access_token
      response = block.call
      self.body = response.body
      populate_from_hash! self.body
    end

    def perform_request(access_token, &block)
      self.access_token = access_token
      response = block.call
      self.location = response.headers[:location]
      self.status = response.status
    end

    def populate_from_hash!(hash)
      return unless hash

      hash.each do |key, value|
        set_attr_method = "#{key}="
        unless value.nil?
          if respond_to?(set_attr_method)
            self.__send__(set_attr_method, value)
          end
        end
      end
    end
  end
end
