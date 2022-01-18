require 'minitest/autorun'
require_relative '../seed_database '

class GenerateChainsTest < Minitest::Test
  def setup
    # Do nothing
  end

  def teardown
    # Do nothing
  end

  def test_generate_chains
    from_currencies = Tradeup::Database::Seeding.get_currencies
    pairs = Tradeup::Database::Seeding.generate_pairs from_currencies
    chains = Tradeup::Database::Seeding.generate_chains(:GBP, pairs, :GBP)
    puts chains.to_s
    assert_includes chains, [:GBP,:USD,:JMD,:GBP]
    # TODO - Decide whether we need a pairs table
  end
end