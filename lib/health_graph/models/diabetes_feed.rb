module HealthGraph
  class DiabetesFeed
    include Model

    hash_attr_accessor :items, :next, :previous, :size

    class Item 
      include Model
      
      hash_attr_accessor :timestamp, :fasting_plasma_glucose_test, :oral_glucose_tolerance_test, :random_plasma_glucose_test

      def initialize(hash)
        populate_from_hash! hash
      end      
    end

    def initialize(access_token, path, params = {})
      populate_from_request!(access_token) do
        get path, HealthGraph.accept_headers[:diabetes_feed], params
      end
    end

    def next_page
      DiabetesFeed.new(self.access_token, self.next) if self.next
    end
  end
end
