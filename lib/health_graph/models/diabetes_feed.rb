module HealthGraph
  class DiabetesFeed
    include Model              
    
    hash_attr_accessor :items, :next
    
    class Item 
      include Model      
      
      hash_attr_accessor :timestamp, :fasting_plasma_glucose_test, :oral_glucose_tolerance_test, :random_plasma_glucose_test
      
      def initialize(hash) 
        populate_from_hash! hash
      end      
    end
                      
    def initialize(access_token, path)            
      self.access_token = access_token
      response = get path, HealthGraph.accept_headers[:diabetes_feed]
      if response.body.reason
        raise response.body.reason
      end
      self.body = response.body
      populate_from_hash! self.body                  
    end                           
  end
end
