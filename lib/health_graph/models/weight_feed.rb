module HealthGraph
  class WeightFeed
    include Model              
    
    hash_attr_accessor :items, :next, :previous, :size
    
    class Item 
      include Model      
      
      hash_attr_accessor :timestamp, :weight, :free_mass, :mass_weight, :fat_percent, :bmi, :uri
      
      def initialize(hash) 
        populate_from_hash! hash
      end      
    end
                      
    def initialize(access_token, path, params = {})            
      self.access_token = access_token
      response = get path, HealthGraph.accept_headers[:weight_feed], params
      self.body = response.body
      populate_from_hash! self.body                  
    end                           
    
    def next_page
      WeightFeed.new(self.access_token, self.next) if self.next
    end
  end
end
