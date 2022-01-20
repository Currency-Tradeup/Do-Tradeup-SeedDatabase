require 'minitest/autorun'
require_relative '../seed_database'
require 'Tradeup/Database/Models'

class SeedChainsTest < Minitest::Test
  def setup
    Tradeup::Database::Seeding.connect_to_test_database
    Tradeup::Database::Models::Chain.delete_all
  end

  def teardown
    # Do nothing
  end

  def test_seed_chains
    currencies = Tradeup::Database::Seeding.get_currencies
    pairs = Tradeup::Database::Seeding.generate_pairs currencies
    rates = Tradeup.get_rates pairs
    chains = Tradeup::Database::Seeding.generate_chains(:GBP,pairs,:GBP)
    Tradeup::Database::Seeding.connect_to_test_database
    Tradeup::Database::Seeding.seed_chains chains,rates
    chain = Tradeup::Database::Models::Chain.where(symbol_one: "GBP",symbol_two: "EUR" ,symbol_three: "USD",symbol_four: "GBP")
    puts chain
    assert chain.exists?
  end
end