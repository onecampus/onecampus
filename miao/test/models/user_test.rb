require 'test_helper'

class UserTest < ActiveSupport::TestCase
  self.use_instantiated_fixtures = true

  test "the truth" do
    assert true
  end

  test "should not save user without profile" do
    u = User.new
    assert_not u.save
  end

  test "should not save user without uid" do
    assert_not @user_without_uid.save
  end

  test "should not save user without pass" do
    assert_not @user_without_pass.save
  end

  test "should not save user without mobile" do
    assert_not @user_without_mobile.save
  end

  test "should not save user with uid length less" do
    assert_not @user_with_uid_length_less_4.save
  end

  test "should not save user with mobile uniqueness" do
    @one.save
    assert_not @three.save, 'cat not save user two with same mobile'
  end

  test "should not save user with pass length less" do
    assert_not @user_with_pass_length_less_4.save
  end

  test "should not save user with invilde email address" do
    assert_not @user_with_invilde_email.save
  end

  test "hash password" do
    assert_equal '8d078cde66d2efc5984a09906bb5517175cd65b3c65e0e22ea87b51e1178c5fa', User.hash_password('123456')
  end

  test 'user email validation' do
    u = User.new(
      last_name: '杨',
      first_name: '浮生',
      nick_name: '浮生',
      uid: 'flowerwrong3',
      salt: 'flowerwrong',
      pass: User.hash_password('123456', 'flowerwrong'),
      avatar: '/test.png',
      email: 'yk3',  # 邮件格式有误
      age: 22,
      university_id: 1,
      address_current: '12.089, 72.569',
      birthday: (DateTime.now - 22.years),
      tel: '88888888',
      mobile: '13560474458',
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
    )
    assert_not u.save
    assert !u.valid?
  end
end
