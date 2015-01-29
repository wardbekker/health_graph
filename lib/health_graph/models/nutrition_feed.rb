module HealthGraph
  class NutritionFeed
    include Model
    
    hash_attr_accessor :items, :next, :previous, :size
                      
    def initialize(access_token, path, params = {})
      self.access_token = access_token
      response = get path, HealthGraph.accept_headers[:nutrition_feed], params
      self.body = response.body
      populate_from_hash! self.body
    end
    
    def next_page
      NutritionFeed.new(self.access_token, self.next) if self.next
    end
  end
end
