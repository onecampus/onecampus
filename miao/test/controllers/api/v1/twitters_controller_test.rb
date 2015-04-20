require 'test_helper'
require 'awesome_print'

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
    # assert_equal 6, json['data']['user_twitters'].count
  end

  test 'should get user own twitters with last twitter id' do
    get :user_twitters, last_twitter_id: 4
    assert_response :success
    json = JSON.parse response.body
    assert_equal json['code'], 200
    # assert_equal 2, json['data']['user_twitters'].count
  end

  test 'should get user relation twitters' do
    get :user_relation_twitters
    assert_response :success
    json = JSON.parse response.body
    assert_equal json['code'], 200
  end
end