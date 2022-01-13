require 'minitest/autorun'
require_relative '../seed_database'

class GetRatesTest < Minitest::Test
  def setup
    # Do nothing
  end

  def teardown
    # Do nothing
  end

  def test_get_rates_contains_gbp_usd
    from_currencies_list = Tradeup::Database::Seeding.get_currencies
    rates = Tradeup::Database::Seeding.generate_pairs from_currencies_list
    # TODO - Search rates for GBPUSD

  end
end