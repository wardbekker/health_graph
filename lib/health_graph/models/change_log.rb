module HealthGraph
  class ChangeLog
    include Model              
    
    hash_attr_accessor :fitness_activities
    
    class FitnessActivities
      include Model

      hash_attr_accessor :modified, :deleted

      def initialize(hash) 
        populate_from_hash! hash
      end
    end
                      
    def initialize(access_token, path, params = {})            
      self.access_token = access_token
      response = get path, HealthGraph.accept_headers[:change_log], params
      self.body = response.body
      populate_from_hash! self.body
    end                           
  end
end