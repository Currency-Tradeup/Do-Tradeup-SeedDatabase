require 'minitest/autorun'
require_relative '../seed_database'

class GetRatesTest < Minitest::Test
  def setup
    # Do nothing
  end

  def teardown
    # Do nothing
  end

  def contains_pair(symbol_one,symbol_two)
    using_pairs = generate_pairs_using_defaults
    rates = Tradeup::Database.get_rates using_pairs
    selected_rate = Tradeup.select_rate(rates, symbol_one, symbol_two)
    puts "Selected Rate is"
    puts selected_rate
    selected_rate.keys.include? ["#{ symbol_one }_#{symbol_two}".to_sym]
  end

  def test_get_rates_contains_gbp_usd
    assert_equal contains_pair('GBP','USD'), true
  end
  def test_get_rates_contains_usd_gbp
    assert_equal contains_pair('USD','GBP'), true
  end
  def test_if_blacklist_is_in_rates
    pairs = generate_pairs_using_defaults
    Tradeup::Database::BLACKLIST.each do |symbol|
      assert_equal contains_pair(symbol,symbol),true # tests for a known marker of a symbols presence. very lazy
    end
  end

  private


  def generate_pairs_using_defaults
    from_currencies_list = Tradeup::Database::Seeding.get_currencies
    Tradeup::Database::Seeding.generate_pairs from_currencies_list
  end

end