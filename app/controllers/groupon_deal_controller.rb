class GrouponDealController < ApplicationController

  def show
    @groupon = GrouponDeal.find(params[:id])
    @page_url = SITE_URL + "/groupon_deal/#{@groupon[:id]}"
  end

  def viewdeal
    @groupon = GrouponDeal.find(params[:id])    
    @page_url = SITE_URL + "/groupon_deal/" + params[:id] + "/"
    if (!session.nil?) 
      session[:api].put_connections("me", "faiceupon:view", :groupon => @page_url)
    end
  end

end
