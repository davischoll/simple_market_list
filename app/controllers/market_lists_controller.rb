# frozen_string_literal: true

class MarketListsController < ApplicationController
  def index; end

  def new
    @market_list = MarketList.new
  end

  def create
    # raise params.require(:market_list).permit(:name, :market_date).inspect
    @market_list = MarketList.new(params.require(:market_list).permit(:name, :market_date))
    @market_list.save
    render :new
  end
end
