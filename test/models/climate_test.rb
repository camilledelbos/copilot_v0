require 'test_helper'

class ClimateTest < ActiveSupport::TestCase
	
	test "valid factory" do
		assert FactoryGirl.create(:climate).valid?	
	end

	test "return city when exist" do
		turin = FactoryGirl.create(:climate, main_city: 'turin')
		assert_equal [], Climate.for_city('bagdad')
		assert_equal [turin], Climate.for_city('turin')
	end

	test "return month of city when exist" do
		april = FactoryGirl.create(:climate, main_city: 'berlin', month: 'april')
		assert_equal [], Climate.for_city_and_month('bagdad', 'april')
		assert_equal [april], Climate.for_city_and_month('berlin', 'april')
		assert_equal [], Climate.for_city_and_month('berlin', 'may')
	end
end