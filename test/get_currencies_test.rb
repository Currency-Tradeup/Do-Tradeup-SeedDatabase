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
    assert_includes Tradeup::Database::Seeding.get_currencies, :GBP
  end
end