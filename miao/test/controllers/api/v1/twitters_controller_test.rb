require 'test_helper'

class Api::V1::TwittersControllerTest < ActionController::TestCase
  self.use_instantiated_fixtures = true

  def setup
    @request.headers['Authorization'] = 'Basic O4K4EGheju926VhH67KXOQ'
  end

  def teardown
    @request.headers['Authorization'] = ''
  end

=begin
  test 'should test the index of twitter controller to get pagination twitter' do
    get :index
    assert_response :success
    json = JSON.parse response.body
    assert_equal json['code'], 200
  end
=end

  test 'should get user own twitters' do
    get :user_twitters
    assert_response :success
    json = JSON.parse response.body
    assert_equal json['code'], 200
  end

  test 'should get user relation twitters' do
    get :user_relation_twitters
    assert_response :success
    json = JSON.parse response.body
    assert_equal json['code'], 200
  end
end