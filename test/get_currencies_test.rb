require 'minitest/autorun'
require_relative '../seed_database'

class GetCurrenciesTest < Minitest::Test
  def setup
    # Do nothing
  end

  def teardown
    # Do nothing
  end

  def test_contains_gbp_symbol
    must_include Tradeup::Database::Seeding.get_currencies, 'BOOB'
  end
end