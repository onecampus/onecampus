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

  test "should not save user with uid uniqueness" do
    @one.save
    assert_not @two.save, 'cat not save user two with same uid'
  end

  test "should not save user with mobile uniqueness" do
    @one.save
    assert_not @three.save, 'cat not save user two with same mobile'
  end

  test "should not save user with pass length less" do
    assert_not @user_with_pass_length_less_4.save
  end
end
