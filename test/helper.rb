require 'coveralls'
Coveralls.wear!

require 'simplecov'
SimpleCov.start

require 'test/unit'
require 'minitest/autorun'
require 'shoulda'
require 'webmock/minitest'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'health_graph'

class Minitest::Test
  TEST_USER_TOKEN = 'b9aaf2581480432a939a72f894bf'.freeze

  def fixture(file)
    path = File.expand_path('../fixtures', __FILE__)
    File.new(path + '/' + file)
  end

  def json_fixture(file)
    file = fixture(file)
    JSON.load(file)
  end
end
