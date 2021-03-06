module HealthGraph
  class FitnessActivityUpdate
    include Model

    hash_attr_accessor :location, :status

    def initialize access_token, params
      perform_request(access_token) do
        put params['uri'], HealthGraph.accept_headers[:fitness_activity], params
      end
    end
  end
end
