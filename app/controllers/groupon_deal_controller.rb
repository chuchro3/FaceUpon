class GrouponDealController < ApplicationController

  def show
    @groupon = GrouponDeal.find(params[:id])
    @page_url = SITE_URL + "/groupon_deal/#{@groupon[:id]}"
  end

  def search
    #@groupon_deal = GrouponDeal.find :all,
     # :conditions => "division_name = '#{params[:search]}'"
    sunspot_search = GrouponDeal.search {
      fulltext params[:search]
      paginate :per_page => 100000
    }
    @groupon_deal = sunspot_search.results
    @groupon_deal = @groupon_deal.paginate(:page => params[:page], :per_page => 10)
    
  end

  def viewdeal
    @groupon = GrouponDeal.find(params[:id])    
    @page_url = SITE_URL + "/groupon_deal/" + params[:id]
    if (!session.nil?) 
      Thread.new { session[:api].put_connections("me", "faiceupon:view", :groupon => @page_url) }
    end
  end

end
