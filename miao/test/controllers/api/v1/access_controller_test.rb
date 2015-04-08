require 'test_helper'

class Api::V1::AccessControllerTest < ActionController::TestCase
  self.use_instantiated_fixtures = true

  test 'should login via post' do
    post :create, login: { mobile: '13560474456', pass: '123456' }
    json = JSON.parse(response.body)
    assert_equal('O4K4EGheju926VhH67KXOQ', json['data']['access_token'])
  end

  test 'should logout via delete' do
    @request.headers['Authorization'] = "Basic O4K4EGheju926VhH67KXOQ"
    delete :destroy
    json = JSON.parse(response.body)
    assert_equal(200, json['code'])
  end
end
