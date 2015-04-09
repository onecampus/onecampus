require 'test_helper'

class TwitterTest < ActiveSupport::TestCase
  self.use_instantiated_fixtures = true

  test 'should save twitter with content in 0..140' do
    assert @twitter_in_140.save
  end

  test 'should not save twitter with content out 140' do
    assert_not @twitter_out_140.save
  end

  test 'should save twitter with content in Chinese 140' do
    assert @twitter_chinese_140.save
    assert_not @twitter_chinese_141.save
  end
end
