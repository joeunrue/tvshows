require 'test_helper'

class ShowTest < ActiveSupport::TestCase
  test 'parses show title from episode title' do
    assert_equal 'How I Met Your Mother',
      Show.parse_title('How I Met Your Mother - 8x07 - The Stamp Tramp (.mp4)')
  end

  test 'parse_and_find_by_title' do
    # Testing that it creates a new show if there isn't one already
    assert_nil Show.find_by_name('Test Show')
    Show.parse_and_find_by_title('Test Show')
    assert_not_nil Show.find_by_name('Test Show')

    # Testing one with a full show name for good measure
    assert_nil Show.find_by_name('Test Show 2')
    Show.parse_and_find_by_title('Test Show 2 - 1x11 - This is an episode')
    assert_not_nil Show.find_by_name('Test Show 2')
  end
end
