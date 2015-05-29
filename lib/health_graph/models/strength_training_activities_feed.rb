module HealthGraph
  class StrengthTrainingActivitiesFeed
    include Model

    hash_attr_accessor :items, :next, :previous, :size

    class Item
      include Model
      
      hash_attr_accessor :start_time, :uri
      
      def initialize(hash) 
        populate_from_hash! hash
      end
    end

    def initialize(access_token, path, params = {})
      populate_from_request!(access_token) do
        get path, HealthGraph.accept_headers[:strength_training_activity_feed], params
      end
    end

    def next_page
      StrengthTrainingActivitiesFeed.new(self.access_token, self.next) if self.next
    end
  end
end
