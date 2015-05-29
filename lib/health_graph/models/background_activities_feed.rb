module HealthGraph
  class BackgroundActivitiesFeed
    include Model

    hash_attr_accessor :items, :next, :previous, :size

    def initialize(access_token, path, params = {})
      populate_from_request!(access_token) do
        get path, HealthGraph.accept_headers[:background_activity_feed], params
      end
    end

    def next_page
      BackgroundActivitiesFeed.new(self.access_token, self.next) if self.next
    end
  end
end
