require 'minitest/autorun'
require_relative '../seed_database'

class GetRateTest < Minitest::Test
  def setup
    # Do nothing
  end

  def teardown
    # Do nothing
  end

  def test_get_rate
    rate = Tradeup.get_rate 'GBP','USD'
    assert_instance_of Float, rate
  end
end