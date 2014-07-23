require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "Factory should be valid" do
    assert FactoryGirl.build(:user).valid?, "User Factory should be valid"
  end
end
