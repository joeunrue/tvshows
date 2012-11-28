require 'test_helper'

class ShowTest < ActiveSupport::TestCase
  test 'parses show title from episode title' do
    assert_equal 'How I Met Your Mother',
      Show.parse_title('How I Met Your Mother - 8x07 - The Stamp Tramp (.mp4)')
  end

private
  def build_show
    Show.new
  end
end
