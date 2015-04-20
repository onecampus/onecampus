require 'test_helper'

class Api::V1::UniversitiesControllerTest < ActionController::TestCase
  self.use_instantiated_fixtures = true

  test 'should get all universities' do
    get 'index'
    assert_response :success
    json = JSON.parse response.body
    assert_equal json['code'], 200
  end
end