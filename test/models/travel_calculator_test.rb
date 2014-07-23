require 'test_helper'


class TravelCalculatorTest < ActiveSupport::TestCase

  attr_reader :montreuil, :berlin, :turin, :bali, :sydney, :geocoder

  def setup
		@montreuil = Stage.new({latitude: 48.863746, longitude: 2.447334})
    @berlin = Stage.new({latitude: 52.520078, longitude: 13.394556})
    @turin = Stage.new({latitude: 45.071109, longitude: 7.687599})
    @bali = Stage.new({latitude: -8.307382, longitude: 115.151228})
    @sydney = Stage.new({latitude: -33.869931, longitude: 151.216317})
  end

  def _test_recette_chemin_optimal
    travel = Travel.new(stages:[montreuil])
    assert_equal [montreuil, berlin, turin, bali, sydney], travel.chemin_optimal
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
end
