require 'test_helper'


class StageTest < ActiveSupport::TestCase

	test "factory always valid" do
		assert FactoryGirl.build(:stage).valid?	
	end

	test "invalid without duration" do
		assert FactoryGirl.build(:stage, duration: nil).invalid?	
	end

	test "invalid without travel" do
		assert FactoryGirl.build(:stage, travel: nil).invalid?	
	end

  def test_position
    montreuil = Stage.new({latitude: 48.863746, longitude: 2.447334})
    assert_equal [48.863746, 2.447334], montreuil.position
  end

  def test_distance_from
    montreuil = Stage.new({latitude: 48.863746, longitude: 2.447334})
    assert_equal 0, montreuil.distance_from(montreuil)
  end
end
