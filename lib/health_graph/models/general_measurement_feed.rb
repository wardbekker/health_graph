module HealthGraph
  class GeneralMeasurementFeed
    include Model              
    
    hash_attr_accessor :items, :next, :previous, :size
    
    class Item 
      include Model      
      
      hash_attr_accessor :timestamp, :systolic, :diastolic
      
      def initialize(hash) 
        populate_from_hash! hash
      end      
    end
                      
    def initialize(access_token, path, params = {})            
      self.access_token = access_token
      response = get path, HealthGraph.accept_headers[:general_measurement_feed], params
      self.body = response.body
      populate_from_hash! self.body                  
    end                           
    
    def next_page
      GeneralMeasurementFeed.new(self.access_token, self.next) if self.next
    end
  end
end
