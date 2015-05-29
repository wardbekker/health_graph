require 'helper'

class TestNewFitnessActivity < Minitest::Test
  context "New Fitness Activity" do
    setup do
      stub_request(:post, HealthGraph.endpoint + '/fitnessActivities')
        .with(
          headers: { 'Authorization' => 'Bearer ' + TEST_USER_TOKEN, 'Content-Type' => HealthGraph.accept_headers[:new_fitness_activity] },
          body: json_fixture('new_fitness_activity_params.json').to_json
        )
        .to_return(:status => 201, :headers => {'location' => '/fitnessActivities/20'}, body: '{"test":1}')
    end

    should "make request to api" do
      activity = HealthGraph::NewFitnessActivity.new(TEST_USER_TOKEN, json_fixture('new_fitness_activity_params.json'))
      assert_requested :post,  HealthGraph.endpoint + '/fitnessActivities', :headers => {'Authorization' => 'Bearer ' + TEST_USER_TOKEN, 'Content-Type' => HealthGraph.accept_headers[:new_fitness_activity]}, :times => 1
    end

    should "get location" do
      activity = HealthGraph::NewFitnessActivity.new(TEST_USER_TOKEN, json_fixture('new_fitness_activity_params.json'))
      assert_equal '/fitnessActivities/20', activity.location
    end

    should "get success status" do
      activity = HealthGraph::NewFitnessActivity.new(TEST_USER_TOKEN, json_fixture('new_fitness_activity_params.json'))
      assert_equal 201, activity.status
    end
  end
end
