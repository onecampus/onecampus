require 'test_helper'

class Api::V1::UsersControllerTest < ActionController::TestCase
  self.use_instantiated_fixtures = true

  def setup
    @request.headers['Authorization'] = 'Basic O4K4EGheju926VhH67KXOQ'
  end

  def teardown
    @request.headers['Authorization'] = ''
  end

  test 'should not register a new user with already_registered mobile' do
    post :register, register: { mobile: '13560474456', pass: '123456' }
    json = JSON.parse(response.body)
    assert_equal(1201, json['code'])
  end

  test 'should register a new user' do
    post :register, register: { mobile: '13560474459', pass: '123456' }
    json = JSON.parse(response.body)
    assert_equal(201, json['code'])
  end

  test 'should login via post' do
    post :login, login: { mobile: '13560474456', pass: '123456' }
    json = JSON.parse(response.body)
    assert_equal('O4K4EGheju926VhH67KXOQ', json['data']['access_token'])
  end

  test 'should logout via delete' do
    delete :logout, id: @flowerwrong.to_param
    json = JSON.parse(response.body)
    assert_equal(200, json['code'])
  end

=begin
  test 'should get users index' do
    get :index
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal(json['code'], 200)
    assert_not_nil assigns(:users)
  end

  test 'should get users with pagination' do

  end
=end
  test 'should get user info' do
    get :show, id: @flowerwrong.to_param
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal(json['code'], 200)
    assert_not_nil assigns(:user)
  end

=begin
  test 'should create a user via post' do
    assert_difference('User.count') do
      post :create, user: {  last_name: '杨',
        first_name: '浮生',
        nick_name: '浮生',
        uid: 'flowerwrongyang',
        salt: 'flowerwrong',
        pass: User.hash_password('123456', 'flowerwrong'),
        avatar: '/test.png',
        email: 'yk2@gmail.com',
        age: 22,
        university_id: 1,
        address_current: '12.089, 72.569',
        birthday: (DateTime.now - 22.years),
        tel: '88888888',
        mobile: '13560474457',
        gender: 'male',
        access_token: 'O4K4EGheju926VhH67KXOQ',
        expiration_time: (DateTime.now + 10.days),
        last_login_ip: '127.0.0.1',
        register_status: 'active',
        last_sign_in_at: (DateTime.now - 10.days),
        language: 'zh_CN',
        register_type: 'mobile',
        personalized_signature: 'flowerwrong',
        country: '中国',
        province: '广东',
        city: '广州',
        region: '番禺',
        postcode: '510000'
      }
    end
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal(json['code'], 201)
    assert_not_nil User.where(mobile: '13560474457').first
  end
=end
  test 'should update a user pass failed with not current user' do
    put :update_pass, id: @one.to_param, user: { pass: '12345678' }
    assert_response :forbidden
    json = JSON.parse(response.body)
    assert_equal(json['code'], 403)
  end

  test 'should update a user pass by current user' do
    put :update_pass, id: @flowerwrong.to_param, user: { pass: '12345678' }
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal(json['code'], 200)
  end

=begin
  test 'should delete a user' do
    delete :destroy, id: @flowerwrong.to_param
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal(json['code'], 200)
    assert_nil User.where(uid: 'flowerwrong').first
  end
=end
end
