require 'test_helper'


class TravelCalculatorTest < ActiveSupport::TestCase

  attr_reader :montreuil, :berlin, :turin, :bali, :sydney, :geocoder

  def setup
		@montreuil = FactoryGirl.create(:stage, {latitude: 48.863746, longitude: 2.447334, stage_position: 0})
    @berlin = FactoryGirl.create(:stage, {latitude: 52.520078, longitude: 13.394556})
    @turin = FactoryGirl.create(:stage, {latitude: 45.071109, longitude: 7.687599})
    @bali = FactoryGirl.create(:stage, {latitude: -8.307382, longitude: 115.151228})
    @sydney = FactoryGirl.create(:stage, {latitude: -33.869931, longitude: 151.216317})
  end

#je souhaite connaitre la saison de chaque station
#je souhaite connaitre le chemin optimal (distance) de manière à ce que je bénéficie du meilleur climat à chaque station
# => je reste plus ou moins longtemps dans chaque station donc selon l'ordre de visite, le climat dans chacun de ces stations ne sera pas le même

  def test_recette_chemin_optimal
    assert_equal [montreuil, turin, berlin, bali, sydney], better_path(montreuil, [montreuil, sydney, turin, bali, berlin])
  end

  def test_juste_1_depart
  	travel = Travel.new(stages:[montreuil])
    assert_equal [montreuil], travel.chemin_optimal
  end

  def test_1_depart_1_destination
  	travel = Travel.new(stages:[montreuil])
    travel.add_stage(berlin)
  	assert_equal [montreuil, berlin], travel.chemin_optimal
  end

  def test_1_depart_2_destinations
  	travel = Travel.new(stages:[montreuil])
    travel.add_stage(berlin)
    travel.add_stage(turin)
  	assert_equal [montreuil, turin, berlin], travel.chemin_optimal
  end

  def _test_1_depart_2_destinations_ordonne_par_distance
  	travel = Travel.new(stages:[montreuil])
  end

  def _test_1_depart_2_destinations_dont_une_soleil_autre_pluie
    travel = Travel.new(stages:[montreuil])
    travel.add_stage(berlin)
    travel.add_stage(turin)
    assert_equal [montreuil, berlin, turin], travel.sunway
  end

  def test_chemin_au_soleil
    assert_equal [[montreuil, turin, bali, sydney, berlin],
                [montreuil, turin, sydney, bali, berlin]], sunway(montreuil, [montreuil, sydney, turin, bali, berlin])
  end

end
