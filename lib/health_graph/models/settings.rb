module HealthGraph
  class Settings
    include Model

    hash_attr_accessor :distance_units, :weight_units

    def initialize(access_token, path)
      populate_from_request!(access_token) do
        get path, HealthGraph.accept_headers[:settings]
      end
    end

    def elite?
      self.body["elite"] == "true"
    end
  end
end
