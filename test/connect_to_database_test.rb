require 'minitest/autorun'
require_relative '../seed_database'

class ConnectToDatabaseTest < Minitest::Test
  def setup
    # Do nothing
  end

  def teardown
    # Do nothing
  end

  def test_database_connection
    Tradeup::Database::Seeding.connect_to_database
  end
end