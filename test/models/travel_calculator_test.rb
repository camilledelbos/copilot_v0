require 'test_helper'


class TravelCalculatorTest < ActiveSupport::TestCase

  attr_reader :katherine, :kingston, :trinidad, :vanadzor

  def setup
    travel = FactoryGirl.create(:travel)
    @katherine = FactoryGirl.create(:stage, :katherine, travel: travel, stage_position: 0, departure_date: DateTime.new(2014,1,23))
    @kingston = FactoryGirl.create(:stage, :kingston, travel: travel, stage_position: 1)
    @trinidad = FactoryGirl.create(:stage, {latitude: 37.1694632, longitude: -104.5005407, address: 'trinidad', travel: travel, stage_position: 2})
    @vanadzor = FactoryGirl.create(:stage, {latitude: 40.812778, longitude: 44.488333, address: 'vanadzor', travel: travel, stage_position: 3})
	end

#je souhaite connaitre la saison de chaque station
#je souhaite connaitre le chemin optimal (distance) de manière à ce que je bénéficie du meilleur climat à chaque station
# => je reste plus ou moins longtemps dans chaque station donc selon l'ordre de visite, le climat dans chacun de ces stations ne sera pas le même

  def test_recette_chemin_optimal
    assert_equal [katherine, vanadzor, kingston, trinidad], better_path(katherine, [katherine, trinidad, vanadzor, kingston])
  end

  def test_juste_1_depart
    assert_equal [katherine], better_path(katherine, [katherine])
  end

  def test_1_depart_1_destination
  	assert_equal [katherine, kingston], better_path(katherine, [katherine, kingston])
  end

  def test_1_depart_2_destinations
  	assert_equal [katherine, trinidad, kingston], better_path(katherine, [katherine, kingston, trinidad])
  end

  def test_1_depart_2_destinations_dont_une_soleil_autre_pluie
    FactoryGirl.create(:climate, main_city: 'kingston', month: 'January', notation: 6)
    FactoryGirl.create(:climate, main_city: 'katherine', month: 'January', notation: 4)
    FactoryGirl.create(:climate, main_city: 'trinidad', month: 'January', notation: 3)

    assert_equal [katherine, kingston, trinidad], sunway(katherine, [katherine, trinidad, kingston])
  end

end
