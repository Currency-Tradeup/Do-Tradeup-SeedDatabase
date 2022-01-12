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

  def test_does_not_contain_blacklist_items
    symbols = Tradeup::Database::Seeding.get_currencies # list of currency symbols
    Tradeup::Database::BLACKLIST.each do |item|
      refute_includes symbols , item
    end
  end

  def test_if_blacklist_does_not_contain_gbp
    Tradeup::Database::BLACKLIST.each do |item|
      refute_equal item, :GBP
    end
  end
end