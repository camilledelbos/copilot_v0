require 'test_helper'

class ClimateTest < ActiveSupport::TestCase
	
	test "valid factory" do
		assert FactoryGirl.create(:climate).valid?	
	end

	test "return city when exist" do
		katherine = FactoryGirl.create(:climate, main_city: 'katherine')
		assert_equal [], Climate.for_city('trinidad')
		assert_equal [katherine], Climate.for_city('katherine')
	end

	test "return month of city when exist" do
		april = FactoryGirl.create(:climate, main_city: 'katherine', month: 4)
		assert_equal [], Climate.for_city_and_month('kingston', 4)
		assert_equal [april], Climate.for_city_and_month('katherine', 4)
		assert_equal [], Climate.for_city_and_month('katherine', 5)
	end
end