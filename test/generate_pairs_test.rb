require 'minitest/autorun'
require_relative '../seed_database'

class GeneratePairsTest < Minitest::Test
  def setup
    # Do nothing
  end

  def teardown
    # Do nothing
  end

  def test_if_function_produces_gbpusd
    from_symbols_array = Tradeup::Database::Seeding.get_currencies # a list of currencies
    assert_includes Tradeup::Database::Seeding.generate_pairs(from_symbols_array), [:GBP,:USD]
  end
  def test_if_function_produces_usdgbp
    from_symbols_array = Tradeup::Database::Seeding.get_currencies # a list of currencies
    assert_includes Tradeup::Database::Seeding.generate_pairs(from_symbols_array), [:USD,:GBP]
  end
end