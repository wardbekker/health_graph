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
      populate_from_request!(access_token) do
        get path, HealthGraph.accept_headers[:weight_feed], params
      end
    end

    def next_page
      WeightFeed.new(self.access_token, self.next) if self.next
    end
  end
end
