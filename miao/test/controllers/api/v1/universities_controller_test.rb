require 'test_helper'

class Api::V1::UniversitiesControllerTest < ActionController::TestCase
  self.use_instantiated_fixtures = true

  def setup
    @request.headers['Authorization'] = 'Basic O4K4EGheju926VhH67KXOQ'
  end

  def teardown
    @request.headers['Authorization'] = ''
  end

  test 'should return all universities' do
    get 'index'
    assert_response :success
    json = JSON.parse response.body
    assert_equal json['code'], 200
  end
end