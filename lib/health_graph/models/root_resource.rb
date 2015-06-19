module HealthGraph
  class RootResource
    include Model              
    
    hash_attr_accessor :change_logs
    
    class Item 
      include Model      
      
      hash_attr_accessor :user_id, :uri
      
      def initialize(hash) 
        populate_from_hash! hash
      end      
    end

    def initialize
      self.access_type = "Basic"
      self.access_token = Base64.strict_encode64(ENV['RUNKEEPER_CLIENT_ID'] + ":" + ENV['RUNKEEPER_CLIENT_SECRET'])
      response = get '/', HealthGraph.accept_headers[:root]
      self.body = response.body
      populate_from_hash! self.body
    end                   

  end
end