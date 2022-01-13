require 'minitest/autorun'
require '../seed_database'
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

  end
end