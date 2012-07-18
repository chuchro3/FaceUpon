class GrouponDealController < ApplicationController

  def show
    @groupon = GrouponDeal.find(params[:id])
    @title = @groupon[:merchant_name]
    @page_url = SITE_URL + "/groupon_deal/#{@groupon[:id]}"

    respond_to do |format|
      format.html
      format.js { render :layout => false}
    end
  end

  def search
    @title = params[:search]

    if @title.empty?
      flash[:error] = 'Invalid search'
      redirect_to :back
    else
      @groupon_deal = GrouponDeal.find_with_index('^'+params[:search])
      @groupon_deal = @groupon_deal.select {|x| x[:active_status]} | @groupon_deal.reject {|x| x[:active_status]}
      @groupon_deal = @groupon_deal.paginate(:page => params[:page], :per_page => 10)

      respond_to do |format|
        format.html
        format.js { render :layout => false}
      end
    end
  end

  def viewdeal
    @groupon = GrouponDeal.find(params[:id])    
    @page_url = SITE_URL + "/groupon_deal/" + params[:id]
    if (!session.nil?) 
      Thread.new { session[:api].put_connections("me", "faiceupon:view", :groupon => @page_url) }
    end
    redirect_to @groupon.dealUrl
  end

  def buydeal
    @groupon = GrouponDeal.find(params[:id])    
    @page_url = SITE_URL + "/groupon_deal/" + params[:id]
    if (!session.nil?) 
      Thread.new { session[:api].put_connections("me", "faiceupon:buy", :groupon => @page_url) }
    end
    redirect_to @groupon.buyUrl
  end



end


