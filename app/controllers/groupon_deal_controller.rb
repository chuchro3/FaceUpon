class GrouponDealController < ApplicationController

  def new
    @groupon_deal = GrouponDeal.new
  end

  def create
    @groupon_deal = GrouponDeal.new(params[:groupondeal])
  end
end
