require 'test_helper'

class ChinaCityTest < ActiveSupport::TestCase
  self.use_instantiated_fixtures = true

  test 'should not save chinacity with level more than 3' do
    assert_not @level_more_3.save
  end

  test 'should not save chinacity with area code less 100000' do
    assert_not @area_code_less_100000.save
  end

  test 'should not save chinacity without area' do
    assert_not @without_area.save
  end
end
