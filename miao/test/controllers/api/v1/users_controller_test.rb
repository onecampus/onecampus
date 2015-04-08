require 'test_helper'

class Api::V1::UsersControllerTest < ActionController::TestCase
  self.use_instantiated_fixtures = true

  def setup
    @request.headers['Authorization'] = 'Basic O4K4EGheju926VhH67KXOQ'
  end

  def teardown
    @request.headers['Authorization'] = ''
  end

  test 'should get user index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test 'should create a user via post' do
    assert_difference('User.count') do
      post :create, user: { name: 'yang', email: 'yang@gmail.com',
                            password: '123456', avatar: '/test.png' }
    end
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal(json['status'], 'created')
    assert_not_nil User.where(name: 'yang').first
  end

  test 'should update a user pass failed with not current user' do
    put :update_pass, id: @yangkang.to_param, user: { password: '12345678' }
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal(json['error'], 'Not current user')
  end

  test 'should update a user pass by current user' do
    put :update_pass, id: @yangfusheng.to_param, user: { password: '123456789' }
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal(json['status'], 'password_updated')
  end

  test 'should delete a user not by the first user' do
    delete :destroy, id: @yangfusheng.to_param
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal(json['error'], 'Not admin user')
    assert_not_nil User.where(name: 'yangfusheng').first
  end
end
