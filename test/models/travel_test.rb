require 'test_helper'

class TravelTest < ActiveSupport::TestCase
  test "Factory should be valid" do
    assert FactoryGirl.build(:travel).valid?, "Travel Factory should be valid"
  end

end
