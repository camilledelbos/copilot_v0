require 'test_helper'


class TravelCalculatorTest < ActiveSupport::TestCase

  attr_reader :katherine, :kingston, :trinidad, :vanadzor

  def setup
    travel = FactoryGirl.create(:travel)
    @katherine = FactoryGirl.create(:stage, :katherine, travel: travel, stage_position: 0, departure_date: DateTime.new(2014,1,23))
    @kingston = FactoryGirl.create(:stage, :kingston, travel: travel, stage_position: 1, duration: 20)
    @trinidad = FactoryGirl.create(:stage, :trinidad, travel: travel, stage_position: 2, duration: 35)
    @vanadzor = FactoryGirl.create(:stage, :vanadzor, travel: travel, stage_position: 3, duration: 40)
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

  def _test_1_depart_2_destinations_sunway_mois_janvier
    FactoryGirl.create(:climate, main_city: 'kingston', month: '1', notation: 5)
    FactoryGirl.create(:climate, main_city: 'katherine', month: '1', notation: 4)
    FactoryGirl.create(:climate, main_city: 'trinidad', month: '1', notation: 3)

    assert_equal [katherine, kingston, trinidad], sunway(katherine, [katherine, trinidad, kingston])
  end

  def test_1_calculer_les_enddates_fonction_de_la_position_et_de_la_durée
    FactoryGirl.create(:climate, main_city: 'kingston')
    FactoryGirl.create(:climate, main_city: 'katherine')
    FactoryGirl.create(:climate, main_city: 'trinidad')
    assert_equal ["Wed, 30 Jul 2014", "Mon, 08 Sep 2014", "Sun, 28 Sep 2014", "Sun, 02 Nov 2014"],  climateway["Wed, 30 Jul 2014", "Mon, 08 Sep 2014", "Sun, 02 Nov 2014", "Sun, 28 Sep 2014"]
#calculer les dates fonction de la durée et de l'ordre

  end

  def _test_nearest_neighbours
    FactoryGirl.create(:climate, main_city: 'kingston')
    FactoryGirl.create(:climate, main_city: 'katherine')
    FactoryGirl.create(:climate, main_city: 'trinidad')
    FactoryGirl.create(:climate, main_city: 'vanadzor')

    assert_equal [katherine, kingston, trinidad], nearest_neighbours(katherine, [katherine, trinidad, kingston])

  end

end
