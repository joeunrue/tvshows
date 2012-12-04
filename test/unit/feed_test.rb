require 'test_helper'

class FeedTest < ActiveSupport::TestCase
  test 'create valid feed' do
    feed = Fabricate.build(:feed)
    assert feed.valid?

    feed = Fabricate.build(:feed, name: nil)
    assert !feed.valid?

    feed = Fabricate.build(:feed, url: nil)
    assert !feed.valid?
  end

  test 'parse_feed' do
    assert true
  end
end
