module HealthGraph
  class NewFitnessActivity
    include Model

    hash_attr_accessor :location, :status

    def initialize access_token, params
      perform_request(access_token) do
        post '/fitnessActivities', HealthGraph.accept_headers[:new_fitness_activity], params
      end
    end
  end
end
