# frozen_string_literal: true

class MarketList < ApplicationRecord
  validates :market_date, presence: true
end
