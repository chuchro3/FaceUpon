class GrouponDealController < ApplicationController

  def show
    @groupon = GrouponDeal.find(params[:id])
  end

end
