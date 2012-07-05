class GrouponDealController < ApplicationController

  def show
    @groupon = GrouponDeal.find(params[:id])
    @page_url = SITE_URL + "/groupon_deal/#{@groupon[:id]}"

    respond_to do |format|
      format.html
      format.js { render :layout => false}
    end
  end

  def search
    @groupon_deal = GrouponDeal.find_with_index('^'+params[:search])

    @groupon_deal = @groupon_deal.paginate(:page => params[:page], :per_page => 10)

    
    respond_to do |format|
      format.html
      format.js { render :layout => false}
    end
  end

  def viewdeal
    @groupon = GrouponDeal.find(params[:id])    
    @page_url = SITE_URL + "/groupon_deal/" + params[:id]
    if (!session.nil?) 
      Thread.new { session[:api].put_connections("me", "faiceupon:view", :groupon => @page_url) }
    end
  end



end


