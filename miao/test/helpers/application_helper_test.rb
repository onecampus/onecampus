require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "code status" do
    assert_equal 200, ApplicationHelper.code_status[:ok]
  end
end