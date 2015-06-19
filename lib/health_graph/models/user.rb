module HealthGraph
  class User
    include Model

    hash_attr_accessor :userID

    def initialize(access_token)
      populate_from_request!(access_token) do
        get 'user', HealthGraph.accept_headers[:user]
      end
    end

    def profile
      HealthGraph::Profile.new self.access_token, self.body['profile']
    end

    def settings
      HealthGraph::Settings.new self.access_token, self.body['settings']
    end

    def nutrition(params={})
      HealthGraph::NutritionFeed.new self.access_token, self.body['nutrition'], params
    end

    def background_activities(params={})
      HealthGraph::BackgroundActivitiesFeed.new self.access_token, self.body['background_activities'], params
    end

    def weight(params={})
      HealthGraph::WeightFeed.new self.access_token, self.body['weight'], params
    end

    def general_measurements(params={})
      HealthGraph::GeneralMeasurementFeed.new self.access_token, self.body['general_measurements'], params
    end

    def diabetes(params={})
      HealthGraph::DiabetesFeed.new self.access_token, self.body['diabetes'], params
    end

    def sleep(params={})
      HealthGraph::SleepFeed.new self.access_token, self.body['sleep'], params
    end

    def fitness_activities params = {}
      HealthGraph::FitnessActivitiesFeed.new self.access_token, self.body['fitness_activities'], params
    end

    def fitness_activity params

    end

    def new_fitness_activity params
      HealthGraph::NewFitnessActivity.new self.access_token, params
    end

    def fitness_activity_update params
      HealthGraph::FitnessActivityUpdate.new self.access_token, params
    end

    def fitness_activity_delete params
      HealthGraph::FitnessActivityDelete.new self.access_token, params
    end

    def strength_training_activities params = {}
      HealthGraph::StrengthTrainingActivitiesFeed.new self.access_token, self.body['strength_training_activities'], params
    end

    def change_log params = {}
      HealthGraph::ChangeLog.new self.access_token, self.body["change_log"], params
    end

  end
end
