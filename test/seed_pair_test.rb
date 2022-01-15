require 'minitest/autorun'
require_relative '../seed_database'
require 'Tradeup/Database/Models'

class SeedPairTest < Minitest::Test
  def setup
    # begin database connection
    Tradeup::Database::Seeding.connect_to_test_database
  end

  def teardown
    # Cleanup the database
    Tradeup::Database::Models::Pair.delete_all
  end

  def test_that_gbpusd_pair_exists
    from_currency_symbol_list = Tradeup::Database::Seeding.get_currencies
    from_pairs_list = Tradeup::Database::Seeding.generate_pairs from_currency_symbol_list
    Tradeup::Database::Seeding.connect_to_test_database
    Tradeup::Database::Seeding.seed_pairs from_pairs_list
    gbp_usd = Tradeup::Database::Models::Pair.find({"symbol_one" => 'GBP',"symbol_two" =>'USD' })
    assert gbp_usd.exists?
  end

  def test_that_usdgbp_pair_exists
    from_currency_symbol_list = Tradeup::Database::Seeding.get_currencies
    from_pairs_list = Tradeup::Database::Seeding.generate_pairs from_currency_symbol_list
    Tradeup::Database::Seeding.connect_to_test_database
    Tradeup::Database::Seeding.seed_pairs from_pairs_list
    usd_gbp = Tradeup::Database::Models::Pair.find({"symbol_one" => 'USD',"symbol_two" =>'GBP' })
    assert usd_gbp.exists?
  end
end