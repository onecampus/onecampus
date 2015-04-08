require 'test_helper'

class Api::V1::AuthControllerTest < ActionController::TestCase
  self.use_instantiated_fixtures = true

  test 'should auth via post' do
    post :create, login: { email: 'yangfusheng@gmail.com', password: '123456' }
    json = JSON.parse(response.body)
    assert_not_empty(json, 'Not Authorized')
    assert_equal('O4K4EGheju926VhH67KXOQ', json['auth_token'])
  end
end
