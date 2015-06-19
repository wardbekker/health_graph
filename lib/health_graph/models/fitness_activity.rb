module HealthGraph
  class FitnessActivity
    include Model              
    
    hash_attr_accessor :uri, :start_time, :climb, :total_calories, :path, :distance, :duration
    
    def initialize(access_token, path)            
      self.access_token = access_token
      response = get path, HealthGraph.accept_headers[:fitness_activity]
      self.body = response.body
      populate_from_hash! self.body
    end                   
    
  end
end