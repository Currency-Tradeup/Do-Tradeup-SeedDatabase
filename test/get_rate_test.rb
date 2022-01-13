require 'minitest/autorun'
require_relative '../seed_database'

class GetRateTest < Minitest::Test
  def setup
    # Do nothing
  end

  def teardown
    # Do nothing
  end

  # incorrect environmental variables will be show in the debug log if any problems arise.

  def test_get_rate
    rate = Tradeup.get_rate 'GBP','USD'
    puts 'Rate is'
    puts rate.to_s
    assert_instance_of Float, rate
  end
end