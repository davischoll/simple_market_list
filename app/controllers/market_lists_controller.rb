# frozen_string_literal: true

class MarketListsController < ApplicationController
  def index; end

  def new
    @market_list = MarketList.new
  end
end
