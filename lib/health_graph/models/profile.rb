module HealthGraph
  class Profile
    include Model

    hash_attr_accessor :location, :name, :gender, :athlete_type, :profile

    def initialize(access_token, path)
      populate_from_request!(access_token) do
        get path, HealthGraph.accept_headers[:profile]
      end
    end

    def elite?
      self.body['elite'] == 'true'
    end
  end
end
