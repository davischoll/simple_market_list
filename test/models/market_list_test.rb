# frozen_string_literal: true

require 'test_helper'

class MarketListTest < ActiveSupport::TestCase
  test 'Should not be valid without market_date' do
    assert_not MarketList.new(market_date: nil, name: 'Need buy something').valid?
  end

  test 'Should be valid with market_date and without name' do
    assert MarketList.new(market_date: Date.current, name: nil).valid?
  end
end
