# frozen_string_literal: true

class MarketListsController < ApplicationController
  def index
    @market_lists = MarketList.all
  end

  def new
    @market_list = MarketList.new
  end

  def create
    # raise params.require(:market_list).permit(:name, :market_date).inspect
    @market_list = MarketList.new(params.require(:market_list).permit(:name, :market_date))

    if @market_list.save
      flash[:success] = 'Nova lista criada com Sucesso'
      redirect_to action: :index
    else
      render :new
    end
  end

  def edit
    @market_list = MarketList.find(params[:id])
  end

  def update
    @market_list = MarketList.find(params[:id])
    @market_list.attributes = params.require(:market_list).permit(:name, :market_date)

    if @market_list.save
      flash[:success] = 'Lista editada com sucesso'
      redirect_to action: :index
    else
      render :edit
    end
  end
end
